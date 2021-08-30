pragma solidity ^0.5.16;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    event votedEvent (uint indexed _candidateId);

    constructor () public {
        addCandidate("MARCO PESTRIN");
        addCandidate("GIANCARLO FACCI");
        addCandidate("OSVALDO DU");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // msg.sender is the value of keyword "from"
        // require is the condition in Solidity
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount ++;
        emit votedEvent(_candidateId);
    }
}