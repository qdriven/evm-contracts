import { ContractInterface, Provider, Signer } from 'ethers';

export interface TxnOptions {
  gasLimit: number;
  gasPrice: number;
}

export type ContractProps = {
  address: string;
  abi: ContractInterface;
  signer: Signer | Provider;
  startDay?: number;
};
