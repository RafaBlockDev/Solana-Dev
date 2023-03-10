// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IAccount.sol";

interface IAggregatedAccount is IAccount {
    function getAggregator() external view returns(address);
}