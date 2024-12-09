import { ethers } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { contractAddress, getSigners, swap_abi } from "./ldo/utils";
//local: 0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const contract = await ethers.deployContract("InterestSwapStorage");
  //0xF6A6F13ee4Ba1895A39c5544513a76A238f3038b
  console.log("Contract address:", await contract.getAddress());
  console.log("starting setup mock contract");
  // contract.setStakingContact(ethers.getAddress("0x1432FA839259DBBDd2a556440ED657E33f683923"));

//   const contractId = await contract.createSwapContract(
//     1691608979,
//     1694287379,
//     ethers.getAddress("0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"),
//     1800,
//     2000,
//     4,
//     6,
//     5
// );
// console.log("deployed contract id",contractId);
// const currentId = await contract.getCurrentContractId();
// console.log("current contract id",currentId);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
