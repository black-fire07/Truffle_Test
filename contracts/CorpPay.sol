// SPDX-License-Identifier: MIT

/**
 *Submitted for verification at polygonscan.com on 2021-11-18
*/


pragma solidity ^0.8;

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


contract EmployeeList {

    // IERC20 public USDT;
  

    mapping(address=>bool) public EmployeeListCheck;
    mapping(address=>uint256) public SalaryList;
    uint public SalaryListCount;

    // constructor(address _USDT) {
    // IERC20 USDT = IERC20(address(0xDC90B0CAe2306B33156a6b46Cd243DE6effbA42F));
    // }

    function Employeelist(address _employee, uint _salary) external {
        require(EmployeeListCheck[_employee] == false, "Error: Wallet already listed");
        EmployeeListCheck[_employee] = true;
        SalaryList[_employee] = _salary;
        SalaryListCount += 1;
    }
}

pragma solidity ^0.8;


// 0xDC90B0CAe2306B33156a6b46Cd243DE6effbA42F
contract SalaryDrop is EmployeeList {


    EmployeeList public listedEmployee;
    uint SalaryDropCount;
    IERC20 public USDT;

  address public admin;
  modifier onlyOwner(address _admin){
      _admin = msg.sender;
      _;
  }

  constructor(address _employeeList,address usdt) {
    listedEmployee = EmployeeList(_employeeList);
    USDT = IERC20(usdt);
    admin = msg.sender;
  }


  function SalaryDropHere(address _employeeAddress) external onlyOwner(msg.sender){
    require(listedEmployee.EmployeeListCheck(_employeeAddress) == true,"this address is not listed");
    USDT.transfer(_employeeAddress,listedEmployee.SalaryList(_employeeAddress));
    SalaryDropCount++;
    // return(string(SalaryDropCount) + "Salary has been dropped");
  }
  
  


}