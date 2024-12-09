import { ethers } from "hardhat";
import { task } from "hardhat/config"
import { CalleeContract, CalleeContract__factory } from "../../types";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";


task("Deploy Callee Contract", "Deploy Callee Contract", async () => {
  const signers: SignerWithAddress[] = await ethers.getSigners();
  const contractFactory: CalleeContract__factory = <CalleeContract__factory>await ethers.getContractFactory("InterestSwapStorage");
  const calleeContract: CalleeContract = <CalleeContract>await contractFactory.connect(signers[0])
    .deploy(); //contract contructor params
  await calleeContract.deployed();
  console.log("callee deployed to: ", calleeContract.address);
})
