// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Memecoin is ERC20 ,Ownable {

    constructor()
     ERC20("Memecoin", "MEME") 
     Ownable(msg.sender) {
        _mint(msg.sender, 1_000_000_000_000* (10 ** uint256(decimals())));
         
    }
   
     mapping (address=> uint256)  _balances;
     mapping (address => mapping(address=>uint256))  _allowances;

     function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    
    function showMint(address _onlyOwner) public view returns (uint256){
        _onlyOwner = msg.sender;
        return showMint(_onlyOwner);
    }

   
    function transfer(address to, uint256 value) public override returns(bool success){
        //require that the value is greater or equal to the amount that is being transfered
        require(_balances[msg.sender] >= value , 'Insufficient Balance');
        _balances[msg.sender] =  _balances[msg.sender] - value;
        _balances[to] += value;
        emit Transfer(msg.sender,to,value);
        return true;
    }
    function approve(address spender , uint256 value) public override returns (bool success){
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender,spender,value);
        return true;
    }


    function transferFrom (address from, address to, uint256 value) public override returns (bool success){
        require(value <=  _balances[from]);
        require(value <= _allowances[from][msg.sender]);
         _balances[to] += value;
         _balances[from] -= value;
        _allowances[msg.sender][from] -= value;
        emit Transfer(from,to,value);
        return true;
    }
}



