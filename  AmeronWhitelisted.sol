// AmeronWhitelisted.sol



pragma solidity ^0.4.18;

import "./ AmeronToken.sol ";



contract AmeronWhitelisted is AmeronToken {



address public owner;



modifier onlyOwner() {

require(msg.sender == owner);

_;

}



function AmeronWhitelisted() public {

owner = msg.sender;

}



function addToWhitelist(address _address) public onlyOwner {

require(_address != 0x0);

require(whitelist[_address] == false);

whitelist[_address] = true;

}



function removeFromWhitelist(address _address) public onlyOwner {

require(whitelist[_address] == true);

whitelist[_address] = false;

}



function isWhitelisted(address _address) public view returns (bool) {

return whitelist[_address];

}

}