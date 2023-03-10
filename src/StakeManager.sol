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

        require(newAmount <= type(uint112).max, "Deposit overflow");

        info.deposit = uint112(newAmount);
    }

    function depositTo(address account) public payable {
        internalIncrementDep(account, msg.value);
        DepositInfo storage info = deposits[account];
    }

    /****************************************/
    /*********** GETTER FUNCTIONS ***********/
    /**************************************+*/

    function getDepositInfo(address account) public view returns(DepositInfo memory info) {
        return deposits[account];
    }

}