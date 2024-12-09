#!/bin/bash

# Remove existing lib directory if it exists
rm -rf lib

# Initialize git submodules
git submodule init

# Install forge-std
forge install --no-commit foundry-rs/forge-std
forge install --no-commit transmissions11/solmate

# Install OpenZeppelin contracts
# forge install --no-commit OpenZeppelin/openzeppelin-contracts

# Update remappings
forge remappings > remappings.txt
