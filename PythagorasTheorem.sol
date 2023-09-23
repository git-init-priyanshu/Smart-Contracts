// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RightAngledTriangle {
    //To check if a triangle with side lenghts a,b,c is a right angled triangle
    function check(uint a, uint b, uint c) pure public returns (bool) {
        if(!(a>0 && b>0 && c>0)){
            return false;
        }
        uint longestSideIndex = 0; 
        uint[3] memory arr = [a,b,c];
        for (uint i=0; i<2;i++){
            if (arr[i] <= arr[i+1]){
                longestSideIndex = i+1;
            }
        }
        uint LHS = arr[longestSideIndex]**2;
        uint RHS = 0;
        for (uint i=0; i<3; i++){
            if(i!=longestSideIndex){
                RHS += arr[i]**2;
            }
        }
        if(LHS == RHS){
            return true;
        }else{
            return false;
        }
    }
}
