contract MyContract {

    address public role1;
    address public oldContract;
    address public newContract;
    MyContract public myContract;
    
    function MyContract(){
        role1=msg.sender;
    }
    
    modifier role1Only() {
        if(msg.sender != role1) return;
        _
    }
    
    modifier newContractExist() { 
        if(newContract == 0) return;
        _
    }
    
    modifier role1OrOldContract(){
        if(msg.sender != role1 && msg.sender != oldContract) return;
        _
    }
    
    function setRole1(address _role1) role1OrOldContract{
        role1=_role1;
    }
    
    function setOldContract(address _oldContract) role1Only{
        oldContract=_oldContract;
    }
        
    function setNewContract (address _newContract) role1Only{
        newContract=_newContract;
        myContract=MyContract(newContract);
    }
  
    function move() role1Only newContractExist{
        myContract.setRole1.value(0).gas(0/*a définir*/)(role1);
        myContract.send(this.balance);
        role1=0;
        oldContract=0;
        
    }
}