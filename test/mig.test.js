const token = artifacts.require("GLDToken");
const employ = artifacts.require("Employ");
const CorpPay = artifacts.require("CorpPay");

contract('employ', accounts => {
    
      describe('input address and balance', () => {
        let employInstance;
        beforeEach(async () => {
            employInstance = await employ.new();
            const address = await employInstance.Employeelist(accounts[1],1000);
        });

        it('check correct balance', async () => {
            const bal = await employInstance.SalaryList(accounts[1]);
            assert.equal(bal, 1000, 'correct balance');
        });
        it('check correct address', async () => {
            const add = await employInstance.EmployeeListCheck(accounts[1]);
            assert.equal(add, true, 'correct address');
        });
    })
})

contract('SalaryDrop', accounts => {
    const owner = accounts[0];
      describe('salary drop check', () => {
        let CorpPayInstance;
        let employInstance;
        let tokenusdt;
        beforeEach(async () => {
            tokenusdt = await token.new(); 
            employInstance = await employ.new();
            CorpPayInstance = await CorpPay.new(employInstance.address,tokenusdt.address);
            const pay = await tokenusdt.transfer(CorpPayInstance.address,100000);
            await employInstance.Employeelist(accounts[1],1000);
        });



        it('check admin', async () => {
            const admin = await CorpPayInstance.admin();
            assert.equal(admin,owner,"correct")
        });

        it('count 0', async () => {
            // await CorpPayInstance.SalaryDropHere(accounts[1]);
            const cnt = await CorpPayInstance.SalaryListCount();
            assert.equal(cnt,0,"correct")
        });


        it('check salarydrop', async () => {
            await CorpPayInstance.SalaryDropHere(accounts[1]);
            let balance = await tokenusdt.balanceOf(accounts[1]);
            assert.equal(balance.toString(),1000,"correct")
        });
    })
})
