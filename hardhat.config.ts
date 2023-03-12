require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  etherscan: {
    apiKey: "PGUNSQBG127PRE82AIX7RVT4J5JH3DDD25",
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    testnet: {
      url: process.env.RPC_URL,
      chainId: 97,
      gasPrice: 20000000000,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
