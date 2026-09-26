// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CrystalFlakCoin (CFC)
 * @author CrystalFlakCoin Contributors
 * @notice A simple, honest ERC-20 token with fixed supply and no admin gimmicks.
 *
 * Design principles (matching the project's "honest-by-design" mandate):
 *  - Fixed supply minted once at deployment. No mint function exposed.
 *  - Burnable by token holders. Total supply can only decrease.
 *  - Ownable, but ownership is meant to be renounced immediately after deployment.
 *  - No transfer fees, no reflections, no rebasing, no whitelist, no blacklist.
 *  - No pausable, no upgradeable proxy, no admin override.
 *
 * After deployment:
 *  1. Verify the source on Sourcify (https://sourcify.dev) — free, no API key.
 *  2. Verify on Etherscan — free with an API key from https://etherscan.io/apis.
 *  3. Renounce ownership via the `renounce()` function — makes the contract immutable.
 *  4. Distribute the initial supply via the project's chosen distribution method.
 */
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CrystalFlakCoin is ERC20, ERC20Burnable, ERC20Permit, Ownable {
    /// @notice Total supply cap. Fixed forever at deployment.
    /// 1,000,000,000 tokens × 18 decimals.
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10 ** 18;

    /// @notice Address where burned tokens are effectively sent (in ERC-20 burns,
    /// tokens are destroyed, but for clarity we document the dead address).
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    /// @notice Emitted when ownership is renounced (making the contract immutable).
    event OwnershipRenounced(address indexed previousOwner);

    /**
     * @param initialHolder Address that will receive the entire initial supply.
     * @param initialOwner  Address that will own the contract initially.
     *                      Intended to call `renounce()` shortly after deployment.
     */
    constructor(address initialHolder, address initialOwner)
        ERC20("CrystalFlakCoin", "CFC")
        ERC20Permit("CrystalFlakCoin")
        Ownable(initialOwner)
    {
        require(initialHolder != address(0), "CFC: initial holder is zero");
        require(initialOwner != address(0), "CFC: initial owner is zero");
        _mint(initialHolder, MAX_SUPPLY);
    }

    /**
     * @notice Renounce ownership — makes the contract fully immutable.
     * @dev After this call, no admin function can be performed. This is irreversible.
     * The recommended workflow:
     *   1. Deploy the contract.
     *   2. Verify source on Sourcify / Etherscan.
     *   3. Distribute the initial supply as planned.
     *   4. Call `renounce()` to lock the contract.
     */
    function renounce() external onlyOwner {
        address previousOwner = owner();
        renounceOwnership();
        emit OwnershipRenounced(previousOwner);
    }

    /**
     * @notice Returns the current circulating supply (total minus burned).
     * Identical to `totalSupply()` for ERC-20, but documented here for clarity.
     */
    function circulatingSupply() external view returns (uint256) {
        return totalSupply();
    }

    /**
     * @notice Returns the maximum supply ever issued. Constant.
     */
    function maxSupply() external pure returns (uint256) {
        return MAX_SUPPLY;
    }
}
