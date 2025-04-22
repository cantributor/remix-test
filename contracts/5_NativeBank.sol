// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import "./5_NativeBankInterface.sol";

contract NativeBank is INativeBank {

    mapping(address => uint) private balances;

    function balanceOf(address account) external override view returns (uint256) {
        return balances[account];
    }

    function deposit() external payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        if (amount == 0) {
            revert WithdrawalAmountZero(msg.sender);
        }
        if (amount > balances[msg.sender]) {
            revert WithdrawalAmountExceedsBalance(msg.sender, amount, balances[msg.sender]);
        }
        unchecked {
            balances[msg.sender] -= amount;
        }
        msg.sender.transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
}