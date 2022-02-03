pragma solidity ^0.8;

// interface IERC20 {
//     function totalSupply() external view returns (uint);

//     function balanceOf(address account) external view returns (uint);

//     function transfer(address recipient, uint amount) external returns (bool);

//     function allowance(address owner, address spender) external view returns (uint);

//     function approve(address spender, uint amount) external returns (bool);

//     function transferFrom(
//         address sender,
//         address recipient,
//         uint amount
//     ) external returns (bool);

//     event Transfer(address indexed from, address indexed to, uint value);
//     event Approval(address indexed owner, address indexed spender, uint value);
// }


contract EmployeeList {

    // IERC20 USDT;
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