// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract EntityDIDRegistryContract {
    address public admin;
    mapping(string => address) private didToAddress;
    mapping(address => string) private addressToDid;
    mapping(string => address) private issuerMapping;
    mapping(string => address) private manufacturerMapping;
    mapping(address => bool) private whitelist;

    event WhitListChangeEvent(address indexed addr,bool indexed status);
    event DIDRegistryEvent(string indexed did, address indexed owner);
    event RemoveDIDRegistryEvent(string indexed did,address indexed removedAddr);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    modifier onlyAdminOrWhitelist() {
        require(msg.sender == admin || whitelist[msg.sender], "Sender is not authorized");
        _;
    }

    function setWhitelist(address _address, bool _status) public onlyAdmin {
        whitelist[_address] = _status;
        emit WhitListChangeEvent(_address,_status);
    }

    function setDIDAddressMapping(string memory _did, address _address) public onlyAdminOrWhitelist {
        didToAddress[_did] = _address;
        addressToDid[_address] = _did;
        emit DIDRegistryEvent(_did, _address);
    }


    function removeDIDAddressMapping(string memory _did) public onlyAdminOrWhitelist {
        require(didToAddress[_did] != address(0), "DID does not exist");
        address addressToRemove = didToAddress[_did];
        delete didToAddress[_did] ;
        delete addressToDid[addressToRemove];
        emit RemoveDIDRegistryEvent(_did,addressToRemove);
    }

    function getDIDFromAddress(address _address) public view returns (string memory) {
        return addressToDid[_address];
    }

    function getAddressFromDID(string memory _did) public view returns (address) {
        return didToAddress[_did];
    }

}
