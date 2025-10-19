
# Registry-Evvm-Contracts

Main repository for EVVM contracts. Here, all contract implementations for the Ethereum Virtual Virtual Machine (EVVM) are developed, tested, and promoted. The entire lifecycle (prototyping, validation, promotion, and production) takes place within this same repository.

---

## Workflow

1. **Development & Experimentation:** New ideas and features are implemented and tested directly here.
2. **Validation:** If a feature passes all local and CI tests, it is considered for promotion.
3. **Promotion:** Validated features are deployed to testnet.
4. **Production:** After testnet validation, features are promoted to mainnet.

---

## Prerequisites

- [Foundry](https://getfoundry.sh/) (for Solidity development and testing)
- Node.js (for package management)

## Installation

Install dependencies and compile contracts:

```bash
make install
```

## Local Development

Start a local Anvil chain:

```bash
make anvil
# In another terminal:
make mock  # Deploy mock contracts
```

## Compilation

Recompile contracts:

```bash
make compile
```

## Testing

Run all unit tests:

```bash
make test
# Or directly with Foundry:
forge test
```

## Formatting

Format Solidity code:

```bash
forge fmt
```

## Deployment

Example script deployment:

```bash
forge script script/DeployRegistryEvvm.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key>
```

## Included Tools

- **Forge**: Ethereum testing framework
- **Cast**: Utility for interacting with contracts and chain data
- **Anvil**: Local EVM-compatible node
- **Chisel**: Solidity REPL

## Documentation

See the official Foundry documentation: [https://book.getfoundry.sh/](https://book.getfoundry.sh/)

## Project Structure

- `src/` — Main contracts
- `test/` — Unit and integration tests
- `lib/` — External libraries (OpenZeppelin, forge-std, etc.)
- `script/` — Deployment and utility scripts

## Contributing

1. Fork the repository
2. Create a feature branch and make your changes
3. Add tests for new features
4. Submit a PR with a detailed description

> **Security Note**: Never commit real private keys. Use test credentials only.
