
pragma solidity 0.8.12;

enum ActionType {
    None,
    Deposit,
    Withdraw
}

enum AmountType {
    None,
    Relative,
    Absolute
}

enum SwapType {
    None,
    FixedInputs,
    FixedOutputs
}

enum PermitType {
    None,
    EIP2612,
    DAI,
    Yearn
}
