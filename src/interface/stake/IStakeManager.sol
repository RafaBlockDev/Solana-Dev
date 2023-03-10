// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../lib/Structures.sol";

interface IStakeManager {
    event Deposited(address indexed account, uint256 totalDeposit);

    event Withdran(address indexed account, address withdrawAddress, uint256 amount);

    event StakeLocked(address indexed account, uint256 totalStaked, uint256 withdrawTime);

    event StakeUnlocked(address indexed account, uint256 withdrawTime);

    event StakeWithdrawn(address indexed account, address withdrawAddress, unit256 amount);

    function depositTo(address account) external payable;

    function addStake(uint32 _unstakeDelaySec) external payable;

    function unlockStake() external;

    function withdrawStake(address payable withdrawAddress) external;

    function withdrawTo(address payable withdrawAddress, uint256 withdrawAmount) external;

    function getDepositInfo(address account) external view returns(DepositInfo memory info);
    
    function getBalanceOf(address account) external view returns(uint256);
}