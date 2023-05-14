// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; // Solidity compiler version

/// @title A digital ATM machine smart contract
/// @author Kanishka Yamani
/// @notice Allows users to deposit, withdraw and store Ether
contract ATM {

    // A mapping of user addresses to their account balances
    mapping (address => uint) public userBalances;

    /// @notice Allows users to deposit ether into ATM machine
    function deposit() public payable {
        userBalances[msg.sender] += msg.value;
    }

    /// @notice Allows users to withdraw their balance from ATM machine
    /// @param amount - The amount that the user wishes to withdraw
    function withdraw(uint amount) public {
        address user = msg.sender;


        // Step 1: Verify user has the amount
        //================================//
        //             Checks             //
        //=============================== //
        require(userBalances[user] >= amount, "Insufficient balance");


        // Step 2: Deduct amount from balance 
        //================================//
        //             Effects            //
        //================================//
        userBalances[user] -= amount;


        // Step 3: Give user requested Ether
        //================================//
        //          Interactions          //
        //================================//
        (bool success, ) = user.call{value: amount}("");
        require(success);
    }
}
