// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public admin;

    constructor() ERC20("ToxKen", "Txn") {
        _mint(msg.sender, 10000 * 10**18);
        admin = msg.sender;
    }

    function mint(address _to, uint256 _amount) external {
        require(msg.sender == admin, "Not the admin");
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount);
    }
}
