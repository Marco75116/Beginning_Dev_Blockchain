pragma solidity ^0.8.9;

contract Lotterie {
    address public owner;
    address[] public participants;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(
            msg.sender == owner,
            "Vous n'etes pas le proprietaire du contract."
        );
        _;
    }

    function getParticipants() public view returns (address[] memory) {
        return participants;
    }

    function enter() public payable {
        require(
            msg.value == 2000000000000000000,
            "Vous devez envoyer plus de gwei pour participer a la lotterie!"
        );
        participants.push(msg.sender);
    }

    function getRandomNumber() public view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        participants
                    )
                )
            );
    }

    function retrievefound(address payable _to) public {
        _to.transfer(address(this).balance);
    }

    function winner() public isOwner {
        require(
            msg.sender == owner,
            "Vous n'etes pas le proprietaire du contract."
        );
        uint256 rd = getRandomNumber();
        uint256 winningPositionNumber = rd % participants.length;
        retrievefound(payable(participants[winningPositionNumber]));

        // RESET Participants
        participants = new address[](0);
    }
}
