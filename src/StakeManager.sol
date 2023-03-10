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

    /****************************************/
    /*********** GETTER FUNCTIONS ***********/
    /**************************************+*/

    function getDepositInfo(address account) public view returns(DepositInfo memory info) {
        return deposits[account];
    }

}