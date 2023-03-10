// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./lib/Structures.sol";

abstract contract StakeManager {

    uint32 public immutable unstakeDelaySec;

    uint256 public immutable payStake;

    constructor(uint256 _payStake, uint32 _unstakeDelaySec) {
        unstakeDelaySec = _unstakeDelaySec;
        payStake = _payStake;
    }

    mapping(address => DepositInfo) public deposits;

    function internalIncrementDep(address account, uint256 amount) internal {
        DepositInfo storage info = deposits[account];
        uint256 newAmount = info.deposit + amount;
        require(newAmount <= type(uint112).max, "deposit overflow");
        info.deposit = uint112(newAmount);
    }

    function depositTo(address account) public payable {
        internalIncrementDep(account, msg.value);
        DepositInfo storage info = deposits[account];
    }

    function addStake(uint32 _unstakeDelaySec) public payable {
        DepositInfo storage info = deposits[msg.sender];
        require(_unstakeDelaySec >= unstakeDelaySec, "unstake delay too low");
        require(_unstakeDelaySec >= info.unstakeDelaySec, "cannot decrease unstake time");
        uint256 stake = info.stake + msg.value;
        require(stake >= payStake, "stake value too low");
        deposits[msg.sender] = DepositInfo(
            info.deposit,
            uint112(stake),
            0,
            _unstakeDelaySec,
            true
        );
    }

    function unlockStake() external {
        DepositInfo storage info = deposits[msg.sender];
        require(info.unstakeDelaySec != 0, "not staked");
        require(info.staked, "already unstaking");
        uint64 withdrawTime = uint64(block.timestamp) + info.unstakeDelaySec;
        info.withdrawTime = withdrawTime;
        info.staked = false;
    }

    function withdrawStake(address payable withdrawAddress) external {
        DepositInfo storage info = deposits[msg.sender];
        uint256 stake = info.stake;
        require(stake > 0, "no stake to withdraw");
        require(info.withdrawTime > 0, "must call unlockStake() first");
        require(info.withdrawTime <= block.timestamp, "stake withdrawal is not due");
        info.unstakeDelaySec = 0;
        info.withdrawTime = 0;
        info.stake = 0;
        (bool success, ) = withdrawAddress.call{value: stake}("");
        require(success, "failed to withdraw stake");
    }

    function withdrawTo(address payable withdrawAddress, uint256 withdrawAmount) external {
        DepositInfo storage info = deposits[msg.sender];
        require(withdrawAmount <= info.deposit, "withdraw amount too large");
        info.deposit = uint112(info.deposit - withdrawAmount);
        (bool success, ) = withdrawAddress.call{value: withdrawAmount}("");
        require(success, "failed to withdraw");
    }

    /****************************************/
    /*********** GETTER FUNCTIONS ***********/
    /**************************************+*/

    function getDepositInfo(address account) public view returns(DepositInfo memory info) {
        return deposits[account];
    }
    
    function getBalanceOf(address account) public view returns(uint256) {
        return deposits[account].deposit;
    }

}