// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

import "remix_accounts.sol";
import "hardhat/console.sol";

import "../contracts/6_ERC20.sol";

contract CanTokenTest {

    CanToken canToken;

    address ownerAcc;
    address acc1;
    address acc2;
    address acc3;

    function beforeAll() public {
        ownerAcc = TestsAccounts.getAccount(0); 
        acc1 = TestsAccounts.getAccount(1); 
        acc2 = TestsAccounts.getAccount(2); 
        acc3 = TestsAccounts.getAccount(3); 

        canToken = new CanToken(ownerAcc, ownerAcc);
    }

    function tokenCreated() public {
        Assert.equal(canToken.decimals(), 2, "Incorrect decimals()");
        Assert.equal(canToken.name(), "CanToken", "Incorrect name()");
        Assert.equal(canToken.symbol(), "CAN", "Incorrect symbol()");
        Assert.equal(canToken.balanceOf(ownerAcc), 100000, "Incorrect initial owner balance");
        Assert.equal(canToken.balanceOf(acc1), 0, "Incorrect initial balance of acc1");
    }

    function transfer() public {
        console.log("Message sender ", msg.sender);
        console.log("Owner token balance ", msg.sender);
        console.log("Owner native balance ", canToken.balanceOf(ownerAcc));
        canToken.transfer(acc1, 100);
        Assert.equal(canToken.balanceOf(ownerAcc), 99000, "Incorrect owner balance");
        Assert.equal(canToken.balanceOf(acc1), 100, "Incorrect balance of acc1");
    }
    
}
    