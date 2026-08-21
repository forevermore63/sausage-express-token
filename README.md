# Sausage Express Token ($SAUSAGE)

Value-bearing ERC-20 for the Sausage Express Empire.

**Goal**: Revenue share and fees feed a treasury earmarked for the Mercedes Sprinter “Sausage Express 2.0” + amazing accommodation for the sausage army.

## CRITICAL SECURITY RULE

- You alone control your private keys and seed phrase.
- Never share them with anyone, including this AI or any “helper”.
- We do not have, and will never have, access to your keys.
- You deploy and sign every transaction yourself.

## Setup

```bash
git clone https://github.com/forevermore63/sausage-express-token.git
cd sausage-express-token
forge install OpenZeppelin/openzeppelin-contracts
```

Create a `.env` file (NEVER commit it):

```
PRIVATE_KEY=your_own_private_key_here
BASE_SEPOLIA_RPC=https://sepolia.base.org
BASE_RPC=https://mainnet.base.org
```

## Deploy to Base Sepolia (testnet first)

```bash
forge script script/Deploy.s.sol:DeployScript --rpc-url $BASE_SEPOLIA_RPC --broadcast --private-key $PRIVATE_KEY
```

## Deploy to Base Mainnet (only after testing)

Same command with `--rpc-url $BASE_RPC` and real funds for gas.

## Tokenomics notes

- Fee (default 1%) routes to the treasury address you set.
- You control the treasury (use a multisig for safety later).
- Fee can be set to 0 by owner.
- Initial supply minted to the deployer (you).

## Next steps after deploy

1. Verify the contract on Basescan.
2. Add liquidity on Uniswap (Base) with part of your $2,000.
3. Update the Sausage Treasury Tracker with the contract address.

Built for real value only. No fake demand, no wash trading.
