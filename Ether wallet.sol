// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.22 < 0.9.0;

contract honeywallet{
    address payable public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyowner {
        require(msg.sender == owner, "Can not perfrom transaction");
        _;
    }

    modifier minEtherSend () {
        require(msg.value > 10 ether, "Minimum value send amount is 10 ether");
        _;
    }
}

contract functionalities is honeywallet {
    function sendEther(address payable _to, uint _amount) payable public onlyowner minEtherSend {
        _to.transfer(_amount);

    }
    function checkbalance() payable public onlyowner {
        owner.balance;
    }
}
