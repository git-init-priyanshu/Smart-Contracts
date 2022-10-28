// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

string constant name = "MyNFT";

string constant symbol = "NFT";

contract MyNFT is ERC721(name, symbol), Ownable {
    function mintNFT(address _to, uint256 _tokenID) internal onlyOwner {
        _safeMint(_to, _tokenID);
    }
}
