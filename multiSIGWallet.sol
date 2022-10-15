// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract multiSIGWallet {
    address[] public owners;

    mapping(address => bool) public isOwner;

    mapping(address => bool) public isApproved;

    uint256 public reqApprovals;

    uint256 countVote;

    enum Status {
        approved,
        notApproved,
        pending
    }

    struct Transaction {
        address to;
        uint256 amount;
        uint256 approvals;
        Status status;
    }

    Transaction public transaction =
        Transaction(address(0), 0, 0, Status.approved); //initialise the transaction

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not the owner");
        _;
    }

    modifier isExecuted() {
        require(
            transaction.status == Status.pending,
            "Transaction is already executed"
        );
        _;
    }

    constructor(address[] memory _address, uint256 _required) {
        require(_address.length > 0, "Owners required");
        require(
            _required > 0 && _required <= _address.length,
            "Invalid required number of owners"
        );

        reqApprovals = _required;

        for (uint256 i = 0; i < _address.length; i++) {
            require(_address[i] != address(0), "An address is null");
            require(isOwner[_address[i]] == false, "An address is repeated");

            isOwner[owners[i]] = true;
            owners.push(_address[i]);
        }
    }

    receive() external payable {} //to recieve ether for the payment of transactions

    function createTransaction(address _to, uint256 _amt) external onlyOwner {
        require(
            transaction.status != Status.pending,
            "Only one transaction is submitted at a time"
        );

        transaction = Transaction(_to, _amt, 0, Status.pending);
    }

    function approveTransaction(bool _vote) external onlyOwner isExecuted {
        require(
            transaction.approvals <= owners.length,
            "All owners have already casted their vote"
        );
        require(
            !isApproved[msg.sender],
            "This owner have already casted their vote"
        );

        isApproved[msg.sender] = _vote;

        countVote++;

        if (_vote) {
            transaction.approvals++;
        }
    }

    function executeTransaction()
        external
        payable
        onlyOwner
        isExecuted
        returns (string memory)
    {
        require(
            countVote == owners.length,
            "All owners have not casted their votes yet"
        );
        require(
            transaction.status == Status.pending,
            "Transaction is already executed"
        );

        (bool isSuccess, ) = transaction.to.call{value: transaction.amount}("");

        if (isSuccess) {
            transaction.status = Status.approved;
            return ("Transaction successfully executed");
        } else {
            transaction.status = Status.notApproved;
            return ("Transaction failed");
        }
    }
}
