// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/Structure.sol";

interface IAccount {
    /**
     * @dev Validate user´s signature
     * @return sigTimeRange signature and time range
     */
    function validateUserOp(
        UserOperation calldata userOp,
        bytes32 userOpHash,
        address aggregator,
        uint256 missingAccountFunds
    ) external returns (uint256 sigTimeRange);
}
