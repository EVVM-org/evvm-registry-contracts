-include .env

.PHONY: all install compile anvil wizard help

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Network Arguments
ANVIL_ARGS := --rpc-url http://localhost:8545 \
              --private-key $(DEFAULT_ANVIL_KEY) \
              --broadcast \
              --via-ir

ARB_SEPOLIA_TESTNET_ARGS := --rpc-url $(RPC_URL_ARB_SEPOLIA) \
                            --account defaultKey \
                            --broadcast \
                            --verify \
                            --etherscan-api-key $(ETHERSCAN_API) \

ETH_SEPOLIA_TESTNET_ARGS := --rpc-url $(RPC_URL_ETH_SEPOLIA) \
                            --account defaultKey \
                            --broadcast \
                            --verify \
                            --etherscan-api-key $(ETHERSCAN_API) \

# Main commands
all: clean remove install update build 

install:
	@echo "Installing libraries"
	@forge compile --via-ir

compile:
	@forge b --via-ir

seeSizes:
	@forge b --via-ir --sizes

anvil:
	@echo "Starting Anvil, remember to use another terminal to run tests"
	@anvil -m 'test test test test test test test test test test test junk' --block-time 10

deployTestnet: 
	@echo "Deploying RegistryEvvm contract on $(NETWORK)"
	@forge clean
	@if [ "$(NETWORK)" = "eth" ]; then \
		forge script script/DeployRegistryEvvm.s.sol:DeployRegistryEvvm $(ETH_SEPOLIA_TESTNET_ARGS) -vvvvvv; \
	elif [ "$(NETWORK)" = "arb" ] || [ -z "$(NETWORK)" ]; then \
		forge script script/DeployRegistryEvvm.s.sol:DeployRegistryEvvm $(ARB_SEPOLIA_TESTNET_ARGS) -vvvvvv; \
	else \
		echo "Unknown network: $(NETWORK). Use 'eth' or 'arb'"; exit 1; \
	fi

deployAnvil: 
	@echo "Deploying RegistryEvvm contract on Anvil local testnet"
	@forge clean
	@forge script script/DeployRegistryEvvm.s.sol:DeployRegistryEvvm $(ANVIL_ARGS) -vvvvvv


## Test Suites

testRegistryEvvm:
	@echo "Running all RegistryEvvm unit correct tests"
	@forge test --match-contract unitTestCorrect_RegistryEvvm --summary --detailed --gas-report -vvv --show-progress
	@sleep 3
	@echo "Running all RegistryEvvm unit revert tests"
	@forge test --match-contract unitTestRevert_RegistryEvvm --summary --detailed --gas-report -vvv --show-progress
	@sleep 3

### Unit tests

#### Correct Tests

unitTestCorrectRegistryEvvm:
	@echo "Running all RegistryEvvm unit correct tests"
	@forge test --match-contract unitTestCorrect_RegistryEvvm --summary --detailed --gas-report -vvv --show-progress

#### Revert Tests
unitTestRevertRegistryEvvm:
	@echo "Running all RegistryEvvm unit revert tests"
	@forge test --match-contract unitTestRevert_RegistryEvvm --summary --detailed --gas-report -vvv --show-progress

unitTestRevertRegistryEvvmRegisterEvvm:
	@echo "Running RegisterEvvm unit revert tests"
	@forge test --match-contract unitTestRevert_RegistryEvvm__RegisterEvvm --summary --detailed --gas-report -vvv --show-progress

unitTestRevertRegistryEvvmSudoRegisterEvvm:
	@echo "Running SudoRegisterEvvm unit revert tests"
	@forge test --match-contract unitTestRevert_RegistryEvvm__SudoRegisterEvvm --summary --detailed --gas-report -vvv --show-progress

unitTestRevertRegistryEvvmRegisterChainId:
	@echo "Running RegisterChainId unit revert tests"
	@forge test --match-contract unitTestRevert_RegistryEvvm__RegisterChainId --summary --detailed --gas-report -vvv --show-progress
######################################################################################################

# Help command
help:                 
	@echo "\n=================================================================================="
	@echo "\n-----------------------=Basic Commands=----------------------\n"
	@echo "  make all            Cleans, installs dependencies, updates and compiles everything"
	@echo "  make install        Installs libraries and compiles contracts"
	@echo "  make compile        Compiles contracts and shows sizes"
	@echo "  make seeSizes       Compiles and shows contract sizes"
	@echo "  make anvil          Starts local Anvil with test mnemonic"
	@echo "  make help           Shows this help message"
	@echo "\n-----------------------=Deployment=----------------------\n"
	@echo "  make deployTestnet  Deploys RegistryEvvm to testnet (use NETWORK=eth or arb)"
	@echo "  make deployAnvil    Deploys RegistryEvvm to local Anvil"
	@echo "\n-----------------------=Test Suites=----------------------\n"
	@echo "  make testRegistryEvvm                Runs all correct and revert tests for RegistryEvvm"
	@echo "  make unitTestCorrectRegistryEvvm     Runs unit correct tests for RegistryEvvm"
	@echo "  make unitTestRevertRegistryEvvm      Runs unit revert tests for RegistryEvvm"
	@echo "  make unitTestRevertRegistryEvvmRegisterEvvm     Runs revert tests for RegisterEvvm"
	@echo "  make unitTestRevertRegistryEvvmSudoRegisterEvvm Runs revert tests for SudoRegisterEvvm"
	@echo "  make unitTestRevertRegistryEvvmRegisterChainId  Runs revert tests for RegisterChainId"
	@echo "\n-----------------------=Development Tools=----------------------\n"
	@echo "  make staticAnalysis  Runs static security analysis"
	@echo "\n=================================================================================="
