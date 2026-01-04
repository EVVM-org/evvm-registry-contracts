
# Registry-Evvm-Contracts

![Solidity](https://img.shields.io/badge/Solidity-^0.8.0-363636?logo=solidity)
![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFDB1C?logo=foundry)
![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-Upgradeable-4E5EE4?logo=openzeppelin)
![License](https://img.shields.io/badge/License-EVVM--NONCOMMERCIAL--1.0-blue)
[![docs](https://img.shields.io/badge/docs-evvm.info-blue.svg)](https://www.evvm.info/docs/RegistryEvvm/Overview)

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
# In another terminal, deploy to Anvil:
make deployAnvil
```

## Compilation

Recompile contracts:

```bash
make compile
```

## Testing

Run unit tests:

```bash
make testRegistryEvvm
```

Or run specific test suites:

```bash
# Run all correct behavior tests
make unitTestCorrectRegistryEvvm

# Run all revert/error tests
make unitTestRevertRegistryEvvm

# Run specific function revert tests
make unitTestRevertRegistryEvvmRegisterEvvm
make unitTestRevertRegistryEvvmSudoRegisterEvvm
make unitTestRevertRegistryEvvmRegisterChainId
```

Or directly with Foundry:

```bash
forge test
```

## Formatting

Format Solidity code:

```bash
make install  # installs and compiles
forge fmt     # formats code
```

## Deployment

Deploy to testnet:

```bash
# Deploy to Arbitrum Sepolia (default)
make deployTestnet

# Deploy to Ethereum Sepolia
make deployTestnet NETWORK=eth
```

Deploy to local Anvil:

```bash
make deployAnvil
```

Or use Forge directly:

```bash
forge script script/DeployRegistryEvvm.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

## Included Tools

- **Forge**: Ethereum testing framework
- **Cast**: Utility for interacting with contracts and chain data
- **Anvil**: Local EVM-compatible node
- **Chisel**: Solidity REPL

## Documentation

- **RegistryEvvm Documentation**: [https://www.evvm.info/docs/RegistryEvvm/Overview](https://www.evvm.info/docs/RegistryEvvm/Overview)
- **Foundry Documentation**: [https://book.getfoundry.sh/](https://book.getfoundry.sh/)

## Project Structure

- `src/` — Main contracts (RegistryEvvm.sol)
- `test/` — Unit tests organized in:
  - `unit/correct/` — Tests for correct behavior
  - `unit/revert/` — Tests for error handling and reverts
- `lib/` — External libraries (OpenZeppelin, forge-std, etc.)
- `script/` — Deployment scripts (DeployRegistryEvvm.s.sol)
- `makefile` — Build and test automation

## Contributing

1. Fork the repository
2. Create a feature branch and make your changes
3. Add tests for new features
4. Submit a PR with a detailed description

> **Security Note**: Never commit real private keys. Use test credentials only.
