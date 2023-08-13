// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event RedeemToken(address account, uint rewardCategory);
    event BurnToken(address account, uint amount);
    event TransferToken(address from, address to, uint amount);

    // onlyOwner modifier allows only the user to execute the function
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    
    // function to transfers tokens
    // override the transfer function in ERC20
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    // function for balanceOf function of ERC20
    function getBalance() public view returns (uint){
        return balanceOf(msg.sender);
    }

    // function to get the game store
    function gameStore() public pure returns(string memory) {
        // Return a string indicating that the caller can get a random amount between 0 and 1000
        return "get random Amount = [0-1000]";
    }

    // function to redeem tokens based on user input
    function reedemTokens(uint _userInput) external payable {
        // Check if the user input is valid
        require(_userInput == 1, "Invalid selection");

        // If the user input is 1, proceed with the redemption
        if (_userInput == 1) {
            // Generate random numbers based on the current timestamp and the caller's address
            uint amount = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
            uint amount2 = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 10;

            // Check if the caller has sufficient balance for this redemption
            require(balanceOf(msg.sender) >= 200, "Insufficient Balance for this redemption");

            // Calculate the final redemption amount
            uint finalAmount = amount * amount2;

            // Approve the caller to transfer the final amount of tokens
            approve(msg.sender, finalAmount);

            // Transfer the final amount of tokens from the caller to the contract owner
            transferFrom(msg.sender, owner(), finalAmount);
        }
    }

    // function to access the private _burn function of ERC20
    function burn(uint amount) public {
        _burn(msg.sender, amount);
        emit BurnToken(msg.sender, amount);
    }
}
