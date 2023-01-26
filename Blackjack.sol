//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
import "@openzeppelin/contracts/utils/Strings.sol";
contract abc{
    uint private MaxNumber = 13;
    function rand(uint8 range) private view returns(uint8) {
        return (uint8(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)))) % range)+1 ;
    }
    string[4] symbolArr=["h","d","s","c"];
    string[] myHand;
    string[] himHand;
    string private text;
    uint public sumHim;
    uint public sumMe;
    bool isCheck=true;
    bool himCheck=true;
    function getMeCard() public{
        require(isCheck==true);
        uint8 random=rand(uint8(MaxNumber));
        if(random==11 || random == 12 || random==13){
            random=10;
        }
        sumMe+=random;
        text=string.concat(Strings.toString(random),symbolArr[rand(3)]);
        myHand.push(text);
        if(sumMe>=21){
            stopMeCheck();
        }
    }function getHimCard() public{
        require(himCheck==true);
        if(isCheck==false){
            uint8 random=rand(uint8(MaxNumber));
            if(random==11 || random == 12 || random==13){
                random=10;
            }
            sumHim+=random;
            if(sumHim>=21){
                stopHimCheck();
            }
            text=string.concat(Strings.toString(random),symbolArr[rand(3)]);
            himHand.push(text);
        }
    }
    function viewMyHand() public view returns(string[] memory){
        return myHand;
    }function viewHimHand() public view returns(string[] memory){
        return himHand;
    }
    function stopMeCheck() public{
        isCheck=!isCheck;
    }
    function stopHimCheck() public{
        himCheck=!himCheck;
    }
    function whoWin() public view returns(string memory){
        require(isCheck==false && himCheck==false);
        if(sumMe<=21){
            if(sumMe>sumHim){
                return "Users win";
            }else if(sumHim>21){
                return "Users win";
            }else if(sumMe==sumHim){
                return "Draw";
            }
        }if(sumHim<=21){
            if(sumHim>sumMe){
                return "Dealer win";
            }else if(sumMe>21){
                return "Dealer Win";
            }else if(sumHim==sumMe){
                return "Draw";
            }
        }else if(sumMe>21 && sumHim>21){
            return "Both of them lose";
        }
    }
}
