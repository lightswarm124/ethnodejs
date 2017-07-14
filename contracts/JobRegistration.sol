pragma solidity ^0.4.8;

contract JobRegistration  {

    mapping(uint => address) jobTrackers;

    function addJobTracker(uint id, address _jt) {
        jobTrackers[id] = _jt;
    }

    function getJobTracker(uint id) constant returns (address) {
        return jobTrackers[id];
    }
}
