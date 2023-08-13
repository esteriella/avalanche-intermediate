
# DegenToken Smart Contract

This is a Solidity contract pertaining to the DegenToken, an ERC20 token that has been deployed onto the Avalanche network. This contract expands upon the capabilities of the OpenZeppelin `ERC20` and `Ownable` contracts, furnishing a range of functionalities including token minting, transferring, redeeming, burning, as well as the ability to verify token balances.

## Usage

To use the project, downdload the code or clone the repository, run the following command:

`npm install`

To deploy the project, run the following command:

`npx hardhat run scripts/deploy.js --network fuji`

To verify the smart contract, run the following command:

`npx hardhat verify 'your-contract-address' --network fuji`

## Contract Details

- Contract Name: DegenToken
- Symbol: DGN

## Functions

### constructor

The constructor initializes the token with the name "Degen" and the symbol "DGN". It is executed only once during contract deployment.

### mint

This function allows the owner of the contract to create and distribute new tokens.

### transfer

This function allows token holders to transfer their tokens to another address.

### redeem

This function allows token holders to burn their tokens in exchange for some specific rewards.

### burn

This function allows anyone to burn tokens they own.

### balanceOf

This function gives the balance of the specified account that its address is provided.

## Author

[Opeyemi Esther Agbaje](https://github.com/esteriella)

## License

This project is licensed under the [MIT License](LICENSE).
