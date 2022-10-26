// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ERC20 {
    address payable owner;

    string public name;

    string public symbol;

    uint256 public totalSupply; //maximum no. of tokens in circulation

    uint256 public value; //value of 1 token as compared to ether

    uint8 public decimals; //

    mapping(address => uint256) public balanceOf; //to store which user have what amount of token

    constructor() {
        owner = payable(msg.sender);

        name = "Toxken";

        symbol = "Txn";

        value = 0.5 ether;

        decimals = 18;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function mint(uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[owner] += _amount;
    }

    function burn(uint256 _amount) public onlyOwner {
        totalSupply -= _amount;
        balanceOf[owner] -= _amount;
    }

    function transferTo(uint256 _amount, address _addressTo)
        public
        onlyOwner
        returns (bool)
    {
        balanceOf[_addressTo] += _amount;
        balanceOf[owner] -= _amount;
        return true;
    }
}
