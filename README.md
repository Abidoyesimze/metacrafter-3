Error Handling Smart Contract
This smart contract demonstrates the usage of Solidity's error handling mechanisms, including require(), assert(), and revert(). These statements ensure the contract operates securely by validating inputs, maintaining internal invariants, and explicitly handling invalid states.

Features
Add Funds:

Allows anyone to send Ether to the contract.
Validates that the transaction includes a positive amount of Ether using require().
Withdraw Funds:

Restricted to the contract owner.
Ensures sufficient balance before allowing a withdrawal using require().
Check Invariants:

Verifies that the funds variable is always consistent with the contract's actual balance using assert().
Reset Funds:

Allows the owner to reset the funds variable to zero.
Restricts access to the owner using revert() with a custom error message.
Contract Functions
1. addFunds()
Description: Accepts Ether and adds it to the funds variable.
Visibility: public payable.
Validation: Uses require() to ensure a non-zero amount of Ether is sent.
State Changes:
Updates the funds variable with the amount of Ether received.
Example:
solidity
require(msg.value > 0, "You must send some Ether");
funds += msg.value;
2. withdrawFunds(uint256 amount)
Description: Allows the owner to withdraw a specified amount of Ether.
Visibility: public.
Validation:
Verifies that the caller is the owner using require().
Checks that the contract has sufficient balance using require().
State Changes:
Deducts the amount from the funds variable.
Transfers the Ether to the owner's address.
Example:
solidity
require(msg.sender == owner, "Only the owner can withdraw funds");
require(amount <= address(this).balance, "Insufficient funds in the contract");
3. checkInvariant()
Description: Verifies that the funds variable is consistent with the contract’s balance.
Visibility: public view.
Validation: Uses assert() to ensure funds is always less than or equal to the contract's balance.
State Changes: None (read-only).
Example:
solidity
assert(funds <= address(this).balance);
4. resetFunds()
Description: Resets the funds variable to zero.
Visibility: public.
Validation: Uses revert() to restrict this function to the contract owner.
State Changes:
Sets the funds variable to 0.
Example:
solidity
if (msg.sender != owner) {
    revert("Only the owner can reset the funds");
}
funds = 0;
Contract Properties
1. owner:
Type: address
Description: Stores the address of the contract deployer.
Access: Public.
2. funds:
Type: uint256
Description: Tracks the total Ether deposited into the contract.
Access: Public.

Example Usage
Adding Funds
Call addFunds() and send Ether with the transaction.
The require statement ensures the amount is greater than zero.
Withdrawing Funds
Only the contract owner can call withdrawFunds().
Specify the amount to withdraw as an argument.
The function validates ownership and sufficient balance.
Checking Invariants
Call checkInvariant() to ensure the internal state of the contract is consistent.
Resetting Funds
The owner can call resetFunds() to reset the funds variable to zero.
If a non-owner attempts this, the revert() statement will block the action.
Error Handling Overview
require():

Ensures conditions like non-zero Ether deposits and ownership validation.
Provides clear error messages when conditions fail.
assert():

Used for critical invariant checks, like ensuring funds matches the balance.
revert():

Explicitly reverts the transaction with custom logic and error messages.
Testing
Test Ether Deposits:

Ensure addFunds() works correctly and updates the funds variable.
Try sending zero Ether and verify that the require() statement blocks the transaction.
Test Withdrawals:

Ensure only the owner can withdraw funds.
Attempt to withdraw more than the contract balance and verify failure.
Test Invariant:

Manually alter the state (if possible) to test the assert() logic.
Test Reset Function:

Ensure only the owner can reset funds using resetFunds().
