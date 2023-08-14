// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    // event emitted when tokens are transferred between accounts
    event TransferToken(address from, address to, uint amount);

    // event emitted when a token redemption occurs
    event RedeemToken(address account, uint itemId);

    // event emitted when tokens are burned (destroyed)
    event BurnToken(address account, uint amount);

    // function to mint tokens
    // onlyOwner modifier allows only the user to execute the function
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    
    // function to transfers tokens
    // override the transfer function in ERC20
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        // emit the transfer event
        emit TransferToken(msg.sender, to, amount);
        return true;
    }

    // function to redeem tokens based on user input
    function redeemTokens(uint256 _amount) external {
        // require that the input amount is at least 50 tokens for redemption
        require(_amount >= 50, "Minimum amount required for redemption: 50 tokens");

        // generate a random number using block data and caller's address
        uint256 randomNumber = uint256(keccak256
            (abi.encode
                (block.difficulty, block.timestamp, block.number, msg.sender)
            )
        );

        // generate random number between 1 and 3
        uint256 itemId = (randomNumber % 3) + 1; 

        // calculate the redemption multiplier based on the generated itemId
        uint256 redemptionMultiplier;

        if (itemId == 1) {
            // redeem amount will be doubled for Item 1
            redemptionMultiplier = 2; 
        } else if (itemId == 2) {
            // redeem amount will be tripled for Item 2
            redemptionMultiplier = 3; 
        } else {
            // redeem amount will be quintupled for Item 3
            redemptionMultiplier = 5; 
        }

        // calculate the final redemption amount 
        // based on the input amount and multiplier
        uint256 finalAmount = _amount * redemptionMultiplier;

        // require that the caller's balance is sufficient for the redemption
        require(balanceOf(msg.sender) >= finalAmount, 
            "Insufficient Balance for this redemption"
        );

        // deduct tokens from the caller's balance
        _burn(msg.sender, finalAmount); 

        // emit event of the redeemed item
        emit RedeemToken(msg.sender, itemId);
    }

    // function to get balance of a user
    function getBalance() public view returns (uint){
        // get the balance of the caller using 
        // balanceOf function of ERC20
        return balanceOf(msg.sender);
    }

    // function to access the private _burn function of ERC20
    function burn(uint amount) public {
        _burn(msg.sender, amount);

        // emit the burn event
        emit BurnToken(msg.sender, amount);
    }
}
