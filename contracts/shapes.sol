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

    modifier isPositive1(uint side){
        require(side>0, "Invalid Input");
        _;
    }

    modifier isPositive2(uint side1, uint side2){
        require(side1 >0 && side2 > 0, "Invalid Input");
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

    modifier sidesLimit(uint sides){
        require(sides>0 && sides<11, "Input should lie in (0, 10]");
        _;
    }

     modifier shapeArrayLimit(string[] memory shapeArray){
        require(shapeArray.length > 0 && shapeArray.length <= 10, "Number of shapes must lie in [1,10]");
        _;
    }   

    modifier sidesLimitAngle(uint sides){
        require(sides>2 && sides<11, "Input should lie in (2, 10]");
        _;
    }
    
    modifier shapeChecker(string memory shape){
        bool isPresent = (shape_number[shape] == 0)? false:true;
        require(isPresent, "Input valid shape with 10 or less sides");
        _;
    }

    modifier shapeArrayChecker(string[] memory shapeArray){
        bool areAllPresent = true;
        for(uint i=0; i<shapeArray.length; i++){
            areAllPresent = (shape_number[shapeArray[i]] == 0)? false:true;
            if(!areAllPresent) break;
        }
        require(areAllPresent, "Invalid shape");
        _;
    }

    function number_of_sides(string calldata s) external view check(s) returns (uint){
        return shape_number[s];
    }

    function isTriangle(int side1, int side2, int side3) public pure isPositive3(side1, side2, side3) returns (bool) {
        return (((side1 + side2 > side3) && (side1 + side3 > side2) && (side2 + side3 > side1))) ? true : false;
    }

    function isRectangle(int side1, int side2, int side3, int side4) public pure isPositive4(side1, side2, side3, side4) returns(bool){
        return (side1 == side3 && side2 == side4)||(side1 == side2 && side3 == side4)||(side1 == side4 && side2 == side3);
    }

    function isSquare(int side1, int side2, int side3, int side4) public pure isPositive4(side1, side2, side3, side4) returns (bool){
       return (side1 == side2 && side2 == side3 && side3 == side4) ? true : false;
    }
    
    function whichTriangle(int side1, int side2, int side3) public pure returns(string memory){
        require(isTriangle(side1, side2, side3), "not a triangle");
        if(side1 == side2 && side2 == side3) return "Equilateral";
        else if(side1 != side2 && side2 != side3 && side1 != side3) return "Scalene";
        else return "Isosceles";
    }

    function interiorAngle(uint sides) public pure sidesLimitAngle(sides) returns(uint){
        return (sides - 2) * 180 / sides;
    }

    function checkShape(uint sides) public view sidesLimit(sides) returns(string memory){
        return name[sides-1];
    }

    function equal(uint sides, string memory shape) public view sidesLimit(sides) shapeChecker(shape) returns (bool){
        return (sides == shape_number[shape])? true:false;
    }



    function interiorAngle(uint sides) public pure sidesLimitAngle(sides) returns(uint){
        return (sides - 2) * 180 / sides;
    }


    function areaTriangle(uint base, uint height)public pure isPositive2(base, height) returns(uint){
        return base * height * 1 / 2;
    }

    

    function areaRectangle(uint base, uint height)public pure isPositive2(base, height) returns(uint){
        return base * height;
    }

    function areaSquare(uint side)public pure isPositive1(side) returns(uint){
        return uint(side ** 2);
    }      

  

    function sortShapes(string[] memory inputShapes) public view shapeArrayChecker(inputShapes) shapeArrayLimit(inputShapes) returns(string[] memory){
        uint[] memory sortedShapeSides = new uint[](inputShapes.length);
        string[] memory sortedShapes = new string[](inputShapes.length);

        for(uint i=0; i<inputShapes.length; ++i){
            sortedShapeSides[i] = shape_number[inputShapes[i]];
        }    
        for(uint i=0; i<=sortedShapeSides.length; ++i){
            uint maxIndex = i;
            for(uint j=i; j<sortedShapeSides.length; ++j){
                if(sortedShapeSides[j]>sortedShapeSides[maxIndex]){
                    uint store = sortedShapeSides[maxIndex];
                    sortedShapeSides[maxIndex] = sortedShapeSides[j];
                    sortedShapeSides[j] = store;
                }
            }
        
        }
        for(uint i=0; i<sortedShapeSides.length; ++i){
            sortedShapes[i] = name[sortedShapeSides[i] -1];
        }
        return sortedShapes;
    }
}

