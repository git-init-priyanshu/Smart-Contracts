// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract EnglishAuction is ERC721, Ownable {
    // safeTransferFrom function is not working: "Ownable: caller is not the owner"

    uint256 public timePeriod;

    mapping(address => uint256) public bidAmount;

    struct HighestBid {
        address bidder;
        uint256 amount;
    }

    HighestBid public highestBid;

    constructor(uint32 _time) ERC721("NFTAuction", "NAN") {
        _safeMint(owner(), 1); //Owner gets the nft
        timePeriod = uint32(block.timestamp + _time);

        transferFrom(owner(), address(this), 1); //this contract is the owner of the NFT
    }

    function bidOnNFT() public payable {
        require(block.timestamp <= timePeriod, "Auctions is closed now");
        require(
            msg.value > 0 ether,
            "You must provide some ether to bid on NFT"
        );

        bidAmount[msg.sender] += msg.value;

        if (msg.value > highestBid.amount) {
            highestBid.bidder = msg.sender;
            highestBid.amount = msg.value;
        }
    }

    function declareWinner() public onlyOwner {
        require(
            block.timestamp >= timePeriod,
            "You can't withdraw before the auction closes"
        );

        // hightest bidder gets the NFT
        safeTransferFrom(address(this), highestBid.bidder, 1);

        // Owner gets the money
        payable(owner()).transfer(highestBid.amount);
    }

    function withdraw() public {
        require(
            block.timestamp >= timePeriod,
            "You can't withdraw before the auction closes"
        );
        require(msg.sender != owner(), "Owner can't use this function");

        // Other participants can withdraw their bid amount
        payable(msg.sender).transfer(bidAmount[msg.sender]);
    }
}
