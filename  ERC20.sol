// ERC20.sol



contract ERC20 {

function totalSupply() public constant returns (uint);

function balanceOf(address who) public constant returns (uint);

function allowance(address owner, address spender) public constant returns (uint);

function transfer(address to, uint value) public returns (bool);

function approve(address spender, uint value) public returns (bool);

function transferFrom(address from, address to, uint value) public returns (bool);



event Transfer(address indexed from, address indexed to, uint value);

event Approval(address indexed owner, address indexed spender, uint value);



}