// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract todoList {
    string[] public tasksArray;

    function addTasks(string memory _task) public {
        tasksArray.append(_task);
    }

    function doneTask(uint256 _index) public {
        tasksArray.pop(_index);
    }
}
