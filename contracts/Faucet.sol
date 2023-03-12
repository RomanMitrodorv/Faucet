// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {
    mapping(address => uint) public lockTime;
    address public owner;
    uint amountAllowed = 0.001 ether;

    event MoneyTaken(address, uint);
    event SendToken(address, uint);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function setOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function setAmountAllowed(uint newAmountAllowed) public onlyOwner {
        amountAllowed = newAmountAllowed;
    }

    function sendToken() public payable {
        emit SendToken(msg.sender, msg.value);
    }

    function getTokens() public {
        require(
            block.timestamp > lockTime[msg.sender],
            "You have already taken the amount for this day"
        );
        require(
            address(this).balance > amountAllowed,
            "Oops. I ran out of money"
        );

        payable(msg.sender).transfer(amountAllowed);

        emit MoneyTaken(msg.sender, amountAllowed);

        lockTime[msg.sender] = block.timestamp + 1 days;
    }
}
