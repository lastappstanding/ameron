// AmeronTokenSale.sol





pragma solidity ^0.4.24;

import "./ERC20.sol";

import "./SafeMath.sol";

import "./StandardToken.sol";

import "./AmeronToken.sol";

import "./AmeronVault.sol";

import "./AmeronWhitelisted.sol";

contract AmeronTokenSale {

using SafeMath for uint256;

ERC20 public token;

AmeronVault public vault;

AmeronWhitelisted public whitelisted;

address public beneficiary;

uint256 public startTime;

uint256 public endTime;

uint256 public minContribution;

uint256 public maxContribution;

uint256 public hardCap;

uint256 public softCap;

bool public ended = false;

bool public fundingGoalReached = false;

modifier onlyWhitelisted {

require(whitelisted.isWhitelisted(msg.sender));

_;

}

modifier afterStartTime {

require(now >= startTime);

_;

}

modifier beforeEndTime {

require(now <= endTime);

_;

}

modifier validContribution {

require(msg.value >= minContribution && msg.value <= maxContribution);

_;

}

constructor(

address _token,

address _vault,

address _whitelisted,

address _beneficiary,

uint256 _startTime,

uint256 _endTime,

uint256 _minContribution,

uint256 _maxContribution,

uint256 _hardCap,

uint256 _softCap

) public {

require(_token != address(0));

require(_vault != address(0));

require(_whitelisted != address(0));

require(_beneficiary != address(0));

require(_startTime >= now);

require(_endTime >= _startTime);

require(_minContribution > 0);

require(_maxContribution >= _minContribution);

require(_hardCap >= _maxContribution);

require(_softCap > 0);

require(_softCap <= _hardCap);

token = ERC20(_token);

vault = AmeronVault(_vault);

whitelisted = AmeronWhitelisted(_whitelisted);

beneficiary = _beneficiary;

startTime = _startTime;

endTime = _endTime;

minContribution = _minContribution;

maxContribution = _maxContribution;

hardCap = _hardCap;

softCap = _softCap;

}

function() external payable onlyWhitelisted afterStartTime beforeEndTime validContribution {

uint256 amount = msg.value;

require(vault.deposit(amount));

require(token.transferFrom(msg.sender, this, amount));

if (vault.balance() >= hardCap) {

ended = true;

} else if (vault.balance() >= softCap) {

fundingGoalReached = true;

}

}

function claimRefund() external onlyWhitelisted afterStartTime beforeEndTime {

require(ended || fundingGoalReached);

require(!whitelisted.isRefunded(msg.sender));

require(vault.withdraw(msg.sender, msg.sender.balance));

whitelisted.markAsRefunded(msg.sender);

}

function withdrawTokens() external onlyWhitelisted afterStartTime beforeEndTime {

require(ended || fundingGoalReached);

require(whitelisted.isRefunded(msg.sender));

require(token.transfer(beneficiary, msg.sender.balance));

}

}