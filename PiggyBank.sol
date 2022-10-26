// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PiggyBank {
    address payable owner;

    receive() external payable {}

    constructor() {
        owner = payable(msg.sender);
    }

    function withdrawEther() public payable {
        require(msg.sender == owner, "Not the owner");
        selfdestruct(owner);
    }

    function checkBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
