import { ethers } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

export const swap_abi =[
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
    "outputs": [],
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

export const contractAddress = "0x85495222fd7069b987ca38c2142732ebbfb7175d";

export async function getSigners(index:number){
  const signers: SignerWithAddress[] =  await ethers.getSigners();
  return signers[index];
}


export async function getDeployedContract(){
  const addr = "0x85495222fd7069b987ca38c2142732ebbfb7175d";
  const signers: SignerWithAddress[] = await ethers.getSigners();
  const contract1 = new ethers.Contract(addr, swap_abi,signers[0])
  return contract1
}
