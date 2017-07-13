module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id
      gas: 8712388,
      gasPrice: 10000000000
    }
  }
};
