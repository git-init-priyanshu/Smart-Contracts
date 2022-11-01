// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract DutchAuction is ERC721, Ownable {
    uint256 public timePeriod;

    uint256 public nftPrice;

    bool internal nftStatus = false;

    bool public status = nftStatus;

    // mapping (address => uint) public bidAmount;

    constructor(uint32 _time, uint256 _price) ERC721("NFTAuction", "NAN") {
        _safeMint(owner(), 1); //Owner gets the nft

        timePeriod = uint32(block.timestamp + _time);
        nftPrice = _price;

        transferFrom(owner(), address(this), 1); //transfering ownership of nft to this contract
    }

    function buyNFT() public payable {
        require(block.timestamp <= timePeriod, "Auctions is closed now");
        require(!nftStatus, "nft has already been sold");
        require(
            msg.value >= nftPrice,
            "Your amount is less than the price of NFT"
        );

        // hightest bidder gets the NFT
        safeTransferFrom(address(this), msg.sender, 1);

        // Owner gets the money
        payable(owner()).transfer(msg.value);

        nftStatus = true;
    }

    function reducePrice(uint256 _by) public onlyOwner {
        nftPrice -= (nftPrice * _by) / 100;
    }
}
