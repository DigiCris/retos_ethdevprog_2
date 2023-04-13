// SPDX-License-Identifier: MIT
pragma solidity >0.7.0 <=0.9.0;

contract VisitContract {


event VisitEvent( address sender, person info, uint256 time );

struct person {
    uint256 counter;
    string[] message;
}

mapping (address => person) public people;
uint256 public counter;

function visit(string calldata _msg) external {
    counter ++;
    people[msg.sender].counter++;
    people[msg.sender].message.push(_msg);
    emit VisitEvent(msg.sender, people[msg.sender] , block.timestamp);
}

function getVisit(address _addr) external view returns (person memory) {
    return (people[_addr]);
}

}