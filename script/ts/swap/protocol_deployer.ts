import { deployIRSProtocol ,deploySwapVault} from "../sdk/IRSwapSdk";


//Deploy Vault
const vaultContract =  deploySwapVault().then((result)=>{
  console.log("deployed swap vault address is ",result.address)
});
console.log("vault contract is ",vaultContract);


//Deploy IRS Protocol
console.log("Deploy IRS Protocol ......")
const protocolContract =  deployIRSProtocol().then((result)=>{
  console.log("deployed swap protocol address is ",result.address)
  return result;
});

//set vault contract

