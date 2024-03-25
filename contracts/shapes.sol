// SPDX-// SPDX-License-Identifier: MIT
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
    modifier isPositive3(int side1, int side2, int side3){
        require(side1 >0 && side2 > 0 && side3 > 0, "Invalid Input");
        _;
    }

    modifier isPositive4(int side1, int side2, int side3, int side4){
        require(side1 > 0 && side2 > 0 && side3 > 0 && side4 > 0, "Invalid Input");
        _;
    }
    function number_of_sides(string calldata s) external view check(s) returns (uint){
        return shape_number[s];
    }

    function isTriangle(int side1, int side2, int side3) public pure isPositive3(side1, side2, side3) returns (bool) {
        return (((side1 + side2 > side3) && (side1 + side3 > side2) && (side2 + side3 > side1))) ? true : false;
        }

    function isRectangle(int side1, int side2, int side3, int side4) public pure isPositive4(side1, side2, side3, side4) returns (bool){

    }

    function isSquare(int side1, int side2, int side3, int side4) public pure isPositive4(side1, side2, side3, side4) returns (bool){
       require(isRectangle(side1, side2, side3, side4), "not even a rectangle");
       return (side1 == side2 && side2 == side3 && side3 == side4) ? true : false;
    }
}
