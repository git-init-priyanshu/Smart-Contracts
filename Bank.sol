// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank {
    address public owner;

    uint256 public accountPrice;

    mapping(address => bool) public isValidAccount;

    mapping(address => uint256) public depositeAmount;

    mapping(address => uint256) public loan;

    modifier validAccount() {
        require(
            isValidAccount[msg.sender] == true,
            "You have to create an account first to deposite money in our bank"
        );

        _;
    }

    constructor(uint256 _price) {
        //0.0125 ether
        owner = msg.sender;
        accountPrice = _price;
    }

    function openAnAccount() public payable {
        require(
            msg.value == accountPrice,
            "Please provide the required amount to open your account"
        );

        isValidAccount[msg.sender] = true;
    }

    function depositeYourMoney(uint256 _minAmount) public payable validAccount {
        require(
            msg.value >= _minAmount,
            "You have to deposite money greater than the minimum amount"
        );

        depositeAmount[msg.sender] = msg.value;
    }

    function withdrawYourMoney() public payable validAccount {
        address payable tempAddress = payable(msg.sender);
        tempAddress.transfer(depositeAmount[msg.sender]);
    }

    function takeLoan(uint256 _loanAmount) public payable validAccount {
        // require(_loanAmount <= ) _loanAmount should be less than the total amount a bank currently posses

        address payable tempAddress = payable(msg.sender);
        tempAddress.transfer(_loanAmount);

        loan[msg.sender] = _loanAmount;
    }

    function payLoan(uint256 _amt) public payable validAccount {
        //should have both SIP and lumpsum option
    }
}
