// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Fund {
    address public owner;
    uint256 public funds;

    constructor() {
        owner = msg.sender;
    }

    // Function to add funds with validation
    function addFunds() public payable {
        // Require that the amount sent is greater than zero
        require(msg.value > 0, "You must send some Ether");
        funds += msg.value;
    }

    // Function to withdraw funds with ownership and balance validation
    function withdrawFunds(uint256 amount) public {
        // Require that the caller is the owner
        require(msg.sender == owner, "Only the owner can withdraw funds");
        
        // Require that there are sufficient funds
        require(amount <= address(this).balance, "Insufficient funds in the contract");
        
        // Update funds before transferring (ensures state integrity)
        funds -= amount;

        // Transfer the funds to the owner
        payable(owner).transfer(amount);
    }

    // Function to demonstrate assert
    function checkInvariant() public view returns (bool) {
        // Assert that funds should never exceed the contract balance
        // This checks an invariant in the contract
        assert(funds <= address(this).balance);
        return true;
    }

    // Function to demonstrate revert with custom error logic
    function resetFunds() public {
        // Only the owner can reset funds
        if (msg.sender != owner) {
            revert("Only the owner can reset the funds");
        }
        funds = 0;
    }
}
