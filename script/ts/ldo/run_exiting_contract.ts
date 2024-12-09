import { ethers } from "hardhat"
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";


const proxy_abi =[
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint8",
        "name": "version",
        "type": "uint8"
      }
    ],
    "name": "Initialized",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "mmAddr",
        "type": "address"
      },
      {
        "components": [
          {
            "internalType": "uint256",
            "name": "ethAmount",
            "type": "uint256"
          },
          {
            "internalType": "uint256",
            "name": "stEthAmount",
            "type": "uint256"
          }
        ],
        "indexed": false,
        "internalType": "struct Vault.DepositReceipt",
        "name": "depositReceipt",
        "type": "tuple"
      }
    ],
    "name": "MarketMakerDepositEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "userAddr",
        "type": "address"
      },
      {
        "components": [
          {
            "internalType": "uint256",
            "name": "ethAmount",
            "type": "uint256"
          },
          {
            "internalType": "uint256",
            "name": "stEthAmount",
            "type": "uint256"
          }
        ],
        "indexed": false,
        "internalType": "struct Vault.DepositReceipt",
        "name": "depositReceipt",
        "type": "tuple"
      }
    ],
    "name": "UserDepositEvent",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "claimMarketMakerETHInterest",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "claimUserETHInterest",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "name": "claimableInterests",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "deposit",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getEthBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_mmAddress",
        "type": "address"
      }
    ],
    "name": "getMarketMarkerEthBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getMarketMarkerTotalEthBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getStEthBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_userAddr",
        "type": "address"
      }
    ],
    "name": "getUserStEthBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "lido",
    "outputs": [
      {
        "internalType": "contract ILido",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "name": "marketMakerDeposits",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "ethAmount",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "stEthAmount",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "name": "marketMarkerClaimableInterests",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "marketMarkerDeposit",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "roundInterestRate",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "stETHContract",
    "outputs": [
      {
        "internalType": "contract ISTETH",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "swapInterest",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "name": "userDeposits",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "ethAmount",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "stEthAmount",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  }
]
async function call() {
  const addr = "0x721d8077771ebf9b931733986d619aceea412a1c";
  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log(signers[0].address)
  console.log(signers[1].address)


  const contract1 = new ethers.Contract(addr, proxy_abi,signers[0])
  console.log(contract1.address)
  // contract1.connect(signers[0])
  const tx = await contract1.deposit({
    value: 300000000
  })

  const tx1 = await contract1.marketMarkerDeposit({
    value: 300000000
  })
  console.log(tx)
  const balanceOf = await contract1.getStEthBalance()
  console.log("contract sthEther balance: ",balanceOf)
  const tx_hash= "0xfd9172283420106fde4a1793e7bb1e3dca2478b1632b65b16313aaed1ce0bdd8";
  const provider = await new ethers.providers.JsonRpcProvider("http://127.0.0.1:8545/")
  await contract1.swapInterest();
  await contract1.claimUserETHInterest();
  await contract1.claimMarketMakerETHInterest();
  // const tx_result = await provider.getTransactionReceipt(tx_hash)
  // console.log("tx_result is ",JSON.stringify(tx_result))
}


call().then((response)=>{
  console.log(response)
}).catch((error)=>{
  console.log(error)
})
