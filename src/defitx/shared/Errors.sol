// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

import { AmountType } from "./Enums.sol";
import { Fee } from "./Structs.sol";

error BadAccount(address account, address expectedAccount);
error BadAccountSignature();
error BadAmount(uint256 amount, uint256 requiredAmount);
error BadAmountType(AmountType amountType, AmountType requiredAmountType);
error BadFee(Fee fee, Fee baseProtocolFee);
error BadFeeAmount(uint256 actualFeeAmount, uint256 expectedFeeAmount);
error BadFeeSignature();
error BadFeeShare(uint256 protocolFeeShare, uint256 baseProtocolFeeShare);
error BadFeeBeneficiary(address protocolFeeBanaficiary, address baseProtocolFeeBeneficiary);
error BadLength(uint256 length, uint256 requiredLength);
error BadMsgSender(address msgSender, address requiredMsgSender);
error BadProtocolAdapterName(bytes32 protocolAdapterName);
error BadToken(address token);
error ExceedingDelimiterAmount(uint256 amount);
error ExceedingLimitFee(uint256 feeShare, uint256 feeLimit);
error FailedEtherTransfer(address to);
error HighInputBalanceChange(uint256 inputBalanceChange, uint256 requiredInputBalanceChange);
error InconsistentPairsAndDirectionsLengths(uint256 pairsLength, uint256 directionsLength);
error InputSlippage(uint256 amount, uint256 requiredAmount);
error InsufficientAllowance(uint256 allowance, uint256 requiredAllowance);
error InsufficientMsgValue(uint256 msgValue, uint256 requiredMsgValue);
error LowActualOutputAmount(uint256 actualOutputAmount, uint256 requiredActualOutputAmount);
error LowReserve(uint256 reserve, uint256 requiredReserve);
error NoneActionType();
error NoneAmountType();
error NonePermitType();
error NoneSwapType();
error PassedDeadline(uint256 timestamp, uint256 deadline);
error TooLowBaseFeeShare(uint256 baseProtocolFeeShare, uint256 baseProtocolFeeShareLimit);
error UsedHash(bytes32 hash);
error ZeroReceiver();
error ZeroAmountIn();
error ZeroAmountOut();
error ZeroFeeBeneficiary();
error ZeroLength();
error ZeroProtocolAdapterRegistry();
error ZeroSigner();
error ZeroSwapPath();
error ZeroTarget();
