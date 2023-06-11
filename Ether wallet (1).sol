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

    modifier sendvalue {
        require(msg.value <= owner.balance, "Not enough wallet balance");
        _;
    }

    struct registrationDetails {
        string email_address;
        uint phone_number;
    }

    event _sendcrypto(address payable _to, uint _amount);

    mapping(address => uint) walletbalance;
    mapping(address => registrationDetails) regDetails;

}

contract functionalities is honeywallet {

    function register(  string memory _email, 
                        uint _phone_number) public{

        regDetails[msg.sender] = registrationDetails(_email, _phone_number);
    }

    function sendCrypto(address payable _to, uint _amount) payable public sendvalue returns (bool Sent) {
        _to.transfer(_amount);
        walletbalance[msg.sender] -= _amount;
        emit _sendcrypto (_to, _amount);
        return true;
       
    }
    function checkbalance() payable public onlyowner returns (uint) {
        return (owner.balance);
    }

}
