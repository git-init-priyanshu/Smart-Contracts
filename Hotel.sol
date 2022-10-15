// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Hotel {
    address payable public owner;

    event(uint _roomNo, address _address) checkoutInfo;

    uint256[] public rooms = [101, 102, 103, 104, 105];
    enum roomStatus {
        occupied,
        vacant
    }

    // roomStatus status;

    struct Room {
        roomStatus status;
        address occupant;
    }

    mapping(uint256 => Room) public roomInfo;

    constructor() {
        owner = payable(msg.sender);

        for (uint256 i = 0; i < rooms.length; i++) {
            //defines the mapping
            roomInfo[rooms[i]] = Room(
                roomStatus.vacant,
                address(0);
            );
        }
    }

    function bookRooms() public payable {//only msg.sender can checkout, only one room is being alloted
        for (uint256 i = 0; i < rooms.length; i++) {
            require(roomInfo[rooms[i]].status == roomStatus.vacant);
            require(msg.value == 1 ether);

            roomInfo[rooms[i]] = Room(roomStatus.occupied, msg.sender);
            owner.transfer(msg.value);

            emit chechoutInfo(room[i],msg.sender);

            break;//maybe the problem?
        }
    }

    
}
