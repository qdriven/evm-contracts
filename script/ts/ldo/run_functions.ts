import { ethers } from "hardhat"
import abi    from "./lido-abi.json"
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

// console.log(abi)

const LidoContract = "0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"
const lido_abi = abi.abi
console.log(lido_abi)

async function getLidoContract(){
  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log(signers[0].address)
  console.log(signers[1].address)


  const lidoContract = new ethers.Contract(LidoContract, lido_abi,signers[0])
  console.log(lidoContract.address)
  const name = await lidoContract.name()
  const symbol = await lidoContract.symbol()
  const decimals = await lidoContract.decimals()
  console.log("contract name is ",name,symbol,decimals)
  const totalPooledEther = await lidoContract.getTotalPooledEther()
  console.log(totalPooledEther.toString())
  const totalShares = await lidoContract.getTotalShares()
  console.log(totalShares)
  const getCurrentStakeLimit = await lidoContract.getCurrentStakeLimit()
  console.log(getCurrentStakeLimit)

  //staking to get stEth
  const stEthAddress  = ethers.utils.getAddress("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266")
  const refer_address = ethers.utils.getAddress("0x70997970C51812dc3A010C7d01b50e0d17dc79C8")
  const tx = await lidoContract.submit(refer_address,{
    value: 4500000000
  })
  console.log(tx)
  console.log(signers[0].address)
  const result = await lidoContract.get
  const stEthBalance = await lidoContract.balanceOf(signers[0].address)
  console.log(await lidoContract.symbol(),stEthBalance.toString())
  const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:8545/")
  const balance = await provider.getBalance(signers[0].address)
  console.log(balance)

  const receiptId = await lidoContract.getDepositReceipt(signers[0].address)
  console.log(receiptId)


}


getLidoContract().then((response)=>{
  console.log(response)
}).catch((error)=>{
  console.log(error)
})
