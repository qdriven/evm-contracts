// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "./interfaces/IInterestSwapProtocol.sol";
import "./interfaces/lido/ILido.sol";
import "./interfaces/lido/IstETH.sol";
import "./library/InterestSwapLib.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract IRSwapProtocol is ERC721, IInterestSwapContractMarket {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint256 => InterestSwapLib.TimeBasedInterestSwapSlotInfo) contracts;
    address owner;

    // IWSTETH public wstETHContract = IWSTETH(0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0);
    ISTETH public stETHContract = ISTETH(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);
    ILido public lido = ILido(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);
    address vaultAddress;
    InterestSwapVault vault;

    constructor() ERC721("SwapContract", "NFTC") {
        owner = msg.sender;
    }

    function setVault(address _vaultAddress) external {
        vaultAddress = _vaultAddress;
        vault = InterestSwapVault(_vaultAddress);
    }

    function _submit() payable public returns (uint256) {
        uint256 amount = msg.value;
        uint256 stEthAmount = lido.submit{ value: amount }(owner);
        return stEthAmount;
    }

    function createSwapContract() public override returns (uint256 tokenId) {
        _tokenIds.increment();
        uint256 newContractId = _tokenIds.current();

        InterestSwapLib.TimeBasedInterestSwapSlotInfo memory contractInfo = InterestSwapLib.TimeBasedInterestSwapSlotInfo(
            true,0,0,7,address(bytes20(bytes("0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"))),
            0,0,0,0,0,6,false
        );

        _mint(msg.sender, newContractId);
        contracts[newContractId] = contractInfo;
        // vault.initSwapContractVault(newContractId);
        // require(vault!= , "Insufficient funds");
        vault.createSwapContractVault(newContractId);
        return newContractId;
    }


    function offer(uint64 tokenId, uint256 value) public {
        stETHContract.transfer(msg.sender, value);
        vault.offer(tokenId, msg.sender, value);
    }

    function offEth(uint64 tokenId) payable external {
         uint256 stETHAmount = _submit();
         offer(tokenId,stETHAmount);
    }

    function buy(uint64 tokenId, uint256 value) public {
        stETHContract.transfer(msg.sender, value);
        vault.buy(tokenId, msg.sender, value);
    }

    function buyByEth(uint64 tokenId) external {
        uint256 stETHAmount = _submit();
        buy(tokenId, stETHAmount);
    }

    function lockContract(uint64 tokenId) external {
        contracts[tokenId].lockStatus = true;
    }

    function swap(uint64 tokenId) external override {
        vault.calculateSwapInterest(tokenId,contracts[tokenId],address(this));
    }

}
