//////////////////////////////////////////////////
//SYNLEV price calculator proxy V 1.0.0
//////////////////////////

pragma solidity >= 0.6.4;

import './ownable.sol';
import './interfaces/priceCalculatorInterface.sol';

contract priceCalculatorProxy is Owned {

  priceCalculatorInterface public priceCalculator;
  address public priceCalculatorPropose;
  uint256 public proposeTimestamp;

  function getUpdatedPrice(address vault, uint256 roundId)
  public
  view
  virtual
  returns(
    uint256 rBullPrice,
    uint256 rBearPrice,
    uint256 rBullLiqEquity,
    uint256 rBearLiqEquity,
    uint256 rBullEquity,
    uint256 rBearEquity,
    uint256 rRoundId,
    bool updated
  ) {

    return(priceCalculator.getUpdatedPrice(vault, roundId));
  }


  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //FOR TESTING ONLY. REMOVE ON PRODUCTION
  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  function setVaultPriceAggregator(address account) public onlyOwner() {
    vaultPriceAggregator = vaultPriceAggregatorInterface(account);
  }

  function proposeVaultPriceAggregator(address account) public onlyOwner() {
    vaultPriceAggregatorPropose = account;
    proposeTimestamp = block.timestamp;
  }
  function updateVaultAggregator() public {
    if(vaultPriceAggregatorPropose != address(0) && proposeTimestamp + 1 days <= block.timestamp) {
      vaultPriceAggregator = vaultPriceAggregatorInterface(vaultPriceAggregatorPropose);
      vaultPriceAggregatorPropose = address(0);
    }
  }

}
