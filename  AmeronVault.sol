// AmeronVault.sol



pragma solidity ^0.4.18;

import "./ERC20.sol";

import "./SafeMath.sol";

import "./StandardToken.sol";

import "./AmeronToken.sol";

/**

* @title AmeronVault

* @dev AmeronVault is a smart contract that allows Ameron holders to

* deposit and withdraw Ameron from the Ameron Republic.

*/

contract AmeronVault is StandardToken, ERC20 {

using SafeMath for uint256;

// The Ameron Republic ( https://ameron.io )

address public ameronRepublic = 0x8f8221afbb33998d8584a2b05749ba73c37a938a;

// The Ameron Foundation ( https://ameron.io )

address public ameronFoundation = 0xd46e8dd67c5d32be8058bb8eb970870f07244567;

// The Ameron Reserve ( https://ameron.io )

address public ameronReserve = 0x0f4f2ac550a1b4e2280d04c21cea7ebd822934b5;

/**

* @dev AmeronVault constructor

*/

function AmeronVault() public {

totalSupply_ = 10000000000000000000000000; // 1 billion

balances[ameronRepublic] = totalSupply_;

balances[ameronFoundation] = totalSupply_.div(100).mul(2); // 2%

balances[ameronReserve] = totalSupply_.div(100).mul(10); // 10%

symbol_ = "AMR";

decimals_ = 18;

name_ = "Ameron";

}

/**

* @dev Authorizes an address to spend Ameron on behalf of Ameron Republic

* @param _spender The address of the spender

* @param _value The amount of Ameron to be spent

*/

function approve(address _spender, uint256 _value) public returns (bool) {

require(_spender != ameronRepublic);

return super.approve(_spender, _value);

}

/**

* @dev Transfers Ameron from Ameron Republic to a recipient

* @param _to The address of the recipient

* @param _value The amount of Ameron to be transferred

*/

function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {

require(_from == ameronRepublic);

require(_to != ameronRepublic);

return super.transferFrom(_from, _to, _value);

}

/**

* @dev Withdraws Ameron from AmeronVault to Ameron Republic

* @param _value The amount of Ameron to be withdrawn

*/

function withdraw(uint256 _value) public {

require(balances[ameronRepublic] >= _value);

balances[ameronRepublic] = balances[ameronRepublic].sub(_value);

balances[msg.sender] = balances[msg.sender].add(_value);

emit Transfer(ameronRepublic, msg.sender, _value);

}

/**

* @dev Deposits Ameron to AmeronVault from Ameron Republic

* @param _value The amount of Ameron to be deposited

*/

function deposit(uint256 _value) public {

require(balances[msg.sender] >= _value);

balances[ameronRepublic] = balances[ameronRepublic].add(_value);

balances[msg.sender] = balances[msg.sender].sub(_value);

emit Transfer(msg.sender, ameronRepublic, _value);

}

}