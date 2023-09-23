// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicketBooking {

    uint[] public allSeats = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
    uint[] public availableSeats;
    mapping(uint => bool) public isBooked;
    mapping(address => uint[]) public bookedSeats;

    //To book seats
    mapping (uint=> uint) private count;
    function bookSeats(uint[] memory seatNumbers) public {
        require(bookedSeats[msg.sender].length <4);
        require(seatNumbers.length > 0 && seatNumbers.length <= 4);

        for(uint i=0; i<seatNumbers.length; i++){
            count[seatNumbers[i]] ++;
            if(count[seatNumbers[i]] > 1){
                revert();
            }
        }
        for(uint i=0; i<seatNumbers.length; i++){
            require(checkAvailability(seatNumbers[i]) == true);
        }
        for(uint i=0; i<seatNumbers.length; i++){
            isBooked[seatNumbers[i] - 1] = true;
            bookedSeats[msg.sender].push(seatNumbers[i]); 
        }
    }
    
    //To get available seats
    function showAvailableSeats() public returns (uint[] memory) {
        for(uint i=0; i<allSeats.length; i++){
            if(isBooked[i] == false){
                availableSeats.push(allSeats[i]);
            }
        }
        return availableSeats;
    }
    
    //To check availability of a seat
    function checkAvailability(uint seatNumber) public view returns (bool) {
        require(seatNumber <= 20 && seatNumber > 0);
        return !isBooked[seatNumber -1];
    }
    
    //To check tickets booked by the user
    function myTickets() public view returns (uint[] memory) {
        return bookedSeats[msg.sender];
    }
}
