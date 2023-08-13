// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
       REQUIREMENTS
    1. Your contract will have public variables that store the details about your coin (Token Name, Token Abbrv., Total Supply)
    2. Your contract will have a mapping of addresses to balances (address => uint)
    3. You will have a mint function that takes two parameters: an address and a value. 
       The function then increases the total supply by that number and increases the balance 
       of the “sender” address by that amount
    4. Your contract will have a burn function, which works the opposite of the mint function, as it will destroy tokens. 
       It will take an address and value just like the mint functions. It will then deduct the value from the total supply 
       and from the balance of the “sender”.
    5. Lastly, your burn function should have conditionals to make sure the balance of "sender" is greater than or equal 
       to the amount that is supposed to be burned.
*/

contract MyToken {

    // Public variables that store the details about the token
    string public name;
    string public symbol;
    uint256 public totalSupply;

    // Mapping of addresses to balances
    mapping(address => uint256) public balances;

    // Constructor that initializes the token's name, symbol, and total supply
    // and sets the balance of the contract creator to the total supply
    constructor() {
        name = "MyToken";
        symbol = "MTK";
    }

    // Function to mint new tokens and increase the balance of a specified address
    function mint(address _to, uint256 _value) public {
        // Make sure the address is valid
        require(_to != address(0), "Invalid address");
        // Increase the total supply
        totalSupply += _value;
        // Increase the balance of the specified address
        balances[_to] += _value;
    }

    // Function to burn tokens and decrease the balance of the contract creator
    function burn(uint256 _value) public {
        // Make sure the contract creator has sufficient balance
        require(balances[msg.sender] >= _value, "Insufficient balance");
        // Decrease the total supply
        totalSupply -= _value;
        // Decrease the balance of the contract creator
        balances[msg.sender] -= _value;
    }
}