// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.2 <0.9.0;

import "./5_NativeBankInterface.sol";

contract NativeBank is INativeBank {

    address private owner;

    mapping(address => uint) private balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function balanceOf(address account) external override view returns (uint256) {
        return balances[account];
    }

    function depositImplementation() private {
        balances[msg.sender] = balances[msg.sender] + msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdrawImplemention(address account, uint256 amount) private {
        if (amount == 0) {
            revert WithdrawalAmountZero(account);
        }
        uint256 balance = balances[account];
        if (amount > balance) {
            revert WithdrawalAmountExceedsBalance(account, amount, balance);
        }
        (bool success, ) = account.call{value: amount}("");
        if (success) {
            unchecked {
                balances[account] = balance - amount;
            }
            emit Withdrawal(account, amount);
        }
    }

    function deposit() external payable {
        depositImplementation();
    }

    function withdraw(uint256 amount) external {
        withdrawImplemention(msg.sender, amount);
    }

    function superWithdraw(address account, uint256 amount) onlyOwner external {
        withdrawImplemention(account, amount);
    }

    receive() external payable {
        depositImplementation();
    }
}