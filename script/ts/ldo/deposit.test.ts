import { ethers } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { contractAddress, getSigners, swap_abi } from "./utils";


describe("depposit function testings",()=>{

  describe("Deposit 20000",function(){

    it("Should deposit successfully and stBalance increased",async function(){
      const depositor = await getSigners(1)
      const testContract = new ethers.Contract(contractAddress, swap_abi,depositor)
      const tx = await testContract.deposit({value: 100000000});
      console.log("tx is ",tx)
      const stBalance = await testContract.getStEthBalance();
      console.log("contract ownerSTEthAmount is ",stBalance)
      console.log("Starting to get user sth amoutn balance")
      const userStBalance  = await testContract.getUserStEthBalance(depositor.address);
      console.log("user sth balance is ",userStBalance);
    })
  })
})


