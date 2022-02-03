const Migrations = artifacts.require("GLDToken");
const employ = artifacts.require("Employ");
const CorpPay = artifacts.require("CorpPay");

module.exports = async function (deployer) {
  await deployer.deploy(Migrations);
  const token = await Migrations.deployed();

  await deployer.deploy(employ);
  const _employ = await employ.deployed();

  await deployer.deploy(CorpPay,_employ.address,token.address);
  const corpPay = await CorpPay.deployed();

  // await token.transfercoin(corpPay.address,1000000000);
};
