// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./mERC20.sol";


contract IECTOKEN is ERC20, Ownable {

    constructor() ERC20("IECTOKEN", "IEC") {}


    uint256 public tokenPrice = 1 ether;

    event tokenPurchase(address indexed seller,address indexed buyer,uint256 noOfToken);
    event priceChanged(uint256 oldPrice,uint256 newPrice);

    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }


    function changeTokenPrice(uint256 _price)public onlyOwner{
        emit priceChanged(tokenPrice,_price);
        tokenPrice=_price;
    }

   

    function BuyToken(address _from,uint256 _noOfToken)public payable {

        require(msg.sender!=owner(),"Owner of this Contract cannot buy Tokens");
        require(msg.sender!=_from,"You cannot buy token from your account");
        require(balanceOf(_from)>=_noOfToken,"The seller does not enough tokens");
        require(msg.value==_noOfToken*tokenPrice,"Please pay the exact token price");

        payable(_from).transfer(msg.value);

        buy(_from,msg.sender,_noOfToken);

        emit tokenPurchase(_from,msg.sender,_noOfToken);

    }




}
