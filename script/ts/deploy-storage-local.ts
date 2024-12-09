import { deployIRSWapContract, deployStEthMockContract } from "./irswapContract";
//local: 0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e


async function main() {
  const mockContract = await deployStEthMockContract();
  const irswapContract = await deployIRSWapContract();
  const mockContractAddr= await mockContract.getAddress();
  console.log("mock contract address is ",mockContractAddr);
  const tx1 = await mockContract.setTotalShares(100);
  const tx2 = await mockContract.setTotalPooledEther(100);
  const tx3 = await irswapContract.setStakingContact(mockContractAddr);
  const mockAddress = await irswapContract.stETHContract();
  console.log("current mock address is ",mockAddress);
  console.log(tx1,tx2,tx3);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });


  // Mock Contract address: 0x809d550fca64d94Bd9F66E60752A544199cfAC3D
  // starting setup mock conctract
  // Deploying contracts with the account: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  // Contract address: 0x4c5859f0F772848b2D91F1D83E2Fe57935348029
  // starting setup mock contract
  // mock contract address is  0x809d550fca64d94Bd9F66E60752A544199cfAC3D
  // current mock address is  0x809d550fca64d94Bd9F66E60752A544199cfAC3D

