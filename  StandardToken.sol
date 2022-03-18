// StandardToken.sol



// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

import "./AmeronToken.sol";

/// @title Standard ERC20 token

contract StandardToken {



using SafeMath for uint256;



mapping (address => uint256) internal balances;

mapping (address => mapping (address => uint256)) internal allowed;



constructor (

uint256 initialSupply

) public {

balances[msg.sender] = initialSupply;

emit Transfer(0x0, msg.sender, initialSupply);

}



/// @dev transfer token for a specified address

/// @param _to The address to transfer to.

/// @param _value The amount to be transferred.

function transfer(

address _to,

uint256 _value

)

public

returns (bool success)

{

require(

_value <= balances[msg.sender],

"Insufficient balance"

);

require(

_to != msg.sender,

"Cannot transfer to yourself"

);

balances[msg.sender] = balances[msg.sender].sub(_value);

balances[_to] = balances[_to].add(_value);

emit Transfer(msg.sender, _to, _value);

return true;

}



/// @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.

/// @param _spender The address of the account able to transfer the tokens.

/// @param _value The amount of wei to be approved for transfer.

function approve(

address _spender,

uint256 _value

)

public

returns (bool success)

{

allowed[msg.sender][_spender] = _value;

emit Approval(msg.sender, _spender, _value);

return true;

}



/// @dev Function to check the amount of tokens that an owner allowed to a spender.

/// @param _owner The address of the account owner.

/// @param _spender The address of the account able to transfer the tokens.

function allowance(

address _owner,

address _spender

)

public

view

returns (uint256 remaining)

{

return allowed[_owner][_spender];

}



/// @dev increase the amount of tokens that an owner allowed to a spender.

/// @param _spender The address of the account able to transfer the tokens.

/// @param _addedValue The amount of wei to increase the allowance by.

function increaseAllowance(

address _spender,

uint256 _addedValue

)

public

returns (bool success)

{

allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);

emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

return true;

}



/// @dev decrease the amount of tokens that an owner allowed to a spender.

/// @param _spender The address of the account able to transfer the tokens.

/// @param _subtractedValue The amount of wei to decrease the allowance by.

function decreaseAllowance(

address _spender,

uint256 _subtractedValue

)

public

returns (bool success)

{

require(

_subtractedValue <= allowed[msg.sender][_spender],

"Decrease allowance below zero"

);

allowed[msg.sender][_spender] = allowed[msg.sender][_spender].sub(_subtractedValue);

emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

return true;

}



emit Transfer(address,address,uint256);

emit Approval(address,address,uint256);

}