// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/Structure.sol";

interface IAccount {
    /**
     * @dev
     * @return
     */
    function validateUserOp(
        UserOperation calldata userOp,
        bytes32 userOpHash,
        address aggregator,
        uint256 missingAccountFunds
    ) external returns (uint256 sigTimeRange);
}
