import { ethers } from "hardhat";import { task } from "hardhat/config"
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";
import { deploySwapContract } from "./deploy-contract";

describe("InterestSwapVault", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  // async function deployInterestSwapVaultFixture() {
  //   const signers: SignerWithAddress[] = await ethers.getSigners();
  //   const contractFactory = await ethers.getContractFactory("InterestSwapVault")
  //   const contractForDeploy = await contractFactory.connect(signers[0])
  //     .deploy(); //contract contructor params
  //   const deploy_tx = await contractForDeploy.deployed();
  //   console.log("deployt tx is ",deploy_tx)
  //   console.log("contract deployed to: ", contractForDeploy.address);
  //   return contractForDeploy;
  // }
  describe("Deployment", function () {
    it("Should deposite successfully", async function () {
    // const contractForDeploy = loadFixture(deployInterestSwapVaultFixture);
    const contractDeployed = deploySwapContract()
    const tx = await contractDeployed.deposit({value: 10090000});
    console.log("tx is ",tx)

    const ownerstEthAmount = await contractDeployed.getStEthBalance();
    console.log("contract ownerSTEthAmount is ",ownerstEthAmount)

    });
  });


});


