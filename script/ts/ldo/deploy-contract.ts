import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";


export async function deploySwapContract(){
  const signers: SignerWithAddress[] = await ethers.getSigners();
  const contractFactory = await ethers.getContractFactory("InterestSwapVault")
  const contractForDeploy = await contractFactory.connect(signers[0])
    .deploy(); //contract contructor params
  const deploy_tx = await contractForDeploy.deployed();
  console.log("deployt tx is ",deploy_tx)
  console.log("contract deployed to: ", contractForDeploy.address);
  return contractForDeploy;
}
