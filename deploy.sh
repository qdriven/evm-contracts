PRIVATE_KEY=$1
CONTRACT_FILE=$2
forge create --rpc-url http://localhost:8545  \
  --private-key ${PRIVATE_KEY} \
    ${CONTRACT_FILE} --legacy

