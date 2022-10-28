// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract NFT_Collection is ERC721, Ownable {
    //transferFrom function is not working. "Invalid token ID".

    using Counters for Counters.Counter;

    uint256 public totalNFTs;

    uint256 public NFTprice = 1 ether;

    Counters.Counter public tokenIdCounter;

    constructor() ERC721("NFT_Collection", "CLN") {
        totalNFTs = 10;
        tokenIdCounter.increment();
    }

    function mint(address _to) public payable returns (uint256) {
        // require(totalSupply() < 10, "All NFTs are minted already");
        require(tokenIdCounter._value < 10, "All NFTs are minted already");
        require(msg.value >= NFTprice, "Not enough ethers provided");

        tokenIdCounter.increment();
        _safeMint(_to, tokenIdCounter.current()); //problem lies here I think
        return tokenIdCounter.current();
    }

    function currentID() public view returns (uint256) {
        return tokenIdCounter.current();
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // function safeTransferNFT(address _from, address _to, uint _tokenID) public {
    //     safeTransferFrom(_from,_to,_tokenID);
    // }
}
