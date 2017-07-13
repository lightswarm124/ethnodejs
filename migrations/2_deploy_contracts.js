var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var Token = artifacts.require("./Token.sol");
var SafeMath = artifacts.require("./SafeMath.sol");
var StandardToken = artifacts.require("./StandardToken.sol");
var JobTracker = artifacts.require("./JobTracker.sol");


module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(Token);
  deployer.deploy(SafeMath);
  deployer.deploy(StandardToken);
  deployer.deploy(JobTracker);
};
