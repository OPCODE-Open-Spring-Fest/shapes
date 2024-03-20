// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract shapes{
    // 1<=n<=10
    // If you want to compare two strings simply use the function compareStrings() which is already created which returns bool 

    mapping(string => uint ) shape_number;
    string [] name=["point","line","triangle","quadrilateral","pentagon","hexagon","heptagon","octagon","nonagon","decagon"];
    
    
    constructor(){
         shape_number["point"]=1;
         shape_number["line"]=2;
         shape_number["triangle"]=3;
         shape_number["quadrilateral"]=4;
         shape_number["pentagon"]=5;
         shape_number["hexagon"]=6;
         shape_number["heptagon"]=7;
         shape_number["octagon"]=8;
         shape_number["nonagon"]=9;
         shape_number["decagon"]=10;
    }


     // this function compareStrings is used to compare two strings
    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
    return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    modifier check(string calldata s){
        int found=0;
        for(uint i=0;i<9;i++)
        {
            if(compareStrings(name[i],s))
            {
                found++;
                break;
            }
        }
         require(found!=0,"Invalid shape");
        _;
    }
    function number_of_sides(string calldata s) external check(s) returns (uint){
        return shape_number[s];
    }
}
