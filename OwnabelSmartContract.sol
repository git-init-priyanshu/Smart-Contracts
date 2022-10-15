// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ownable {
    address owner;

    uint256 x;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function setX(uint256 _x) public onlyOwner {
        x = _x;
    }

    function getX() public view onlyOwner returns (uint256) {
        return x;
    }

    function changeOwnership(address _address) public onlyOwner {
        owner = _address;
    }
}
