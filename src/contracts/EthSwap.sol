pragma solidity >=0.6.0 <0.9.0;

import './Token.sol';

contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;

    event TokenPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

      event TokenSold(
        address account,
        address token,
        uint amount,
        uint rate
    );

    constructor(Token _token) public {
        token = _token;

    }

    function buyTokens () public payable  {
        //Redemption rate = n0. of tokens they recieve for 1 ether
        //Amount of etherium * Redemption rate
        uint tokenAmount = msg.value*rate;

        require(token.balanceOf(address(this)) >= tokenAmount);

        token.transfer(payable(msg.sender) , tokenAmount);

        emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
    }

    function sellTokens (uint _amount) public  {

      require(token.balanceOf(msg.sender) >= _amount);
 
        //calculate the amount of ether to redeem
    uint etherAmount = _amount / rate;

    //requirement

    require(address(this).balance >= etherAmount);

    token.transferFrom(msg.sender,address(this), _amount);
    payable(msg.sender).transfer(etherAmount);

    emit TokenSold(msg.sender, address(token),_amount, rate);

    }

}







