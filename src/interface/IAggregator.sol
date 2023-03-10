// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/Structures.sol";

interface IAggregator {
    /**
     * @dev Payment validation
     * @return sigForUserOp value to send to a postOp
     */
    function validateUserOpSignature(
        UserOperation calldata userOp
    ) external view returns (bytes memory sigForUserOp);

    /**
     * @dev Verify sender is the entryPoint
     * @return aggregatesSignature that user verified
     */
    function aggregateSignatures(
        UserOperation[] calldata userOps
    ) external view returns (bytes memory aggregatesSignature);

    function validateSignatures(
        UserOperation[] calldata userOps,
        bytes calldata signature
    ) external view;
}
