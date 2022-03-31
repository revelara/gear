// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//This implementation uses IERC20 interface
import "./IERC20.sol";

/**
 * @title ERC20 ReveCoin Token 
 * @author Luis Alberto Ramirez Albino
**/

contract ReveCoin is IERC20 {
    
    //Amount of tokens in existence
    uint public totalSupply;
    //Amount of tokens owned by account
    mapping(address => uint) public balanceOf;
    //Number of tokens that spender will be allowed to spend on behalf of owner
    mapping(address => mapping(address => uint)) public allowance;
    //Name of our ERC20 token
    string public name = "ReveCOIN";
    //Symbol token representation
    string public symbol = "RVE";
    //Number of decimals used to get its user representation 
    uint8 public decimals = 18;

    /**
     * @dev Move balance between one account to another
     * @param recipient Target account
     * @param amount Amount to transfer
     */

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

   /**
     * @dev Set amount as the allowance of spender over the caller's token
     * @param spender Destiny account
     * @param amount Amount to transfer
     */
    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev Move balance from sender to recipient
     * @param sender Source account
     * @param recipient Target account
     * @param amount Amount to transfer
     */
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    /**
     * @dev Creates amount tokens and assign to account
     * @param amount Amount to create
     */
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    /**
     * @dev Destroy amount tokens from account
     * @param amount Amount to destroy
     */
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
