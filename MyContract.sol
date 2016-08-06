contract MyContract {

    address public role1; /*Un role dans l'organisation*/
    address public oldContract;/*L'ancien contrat qui ne servira plus*/
    address public newContract;/*Le nouveau contrat vers lequel on souhaite migrer. Le contrat newContract doit être créer de manière indépendante afin de permettre des mise à jour de son code*/ 
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
    
    /*Positionnement du contrat depuis lequel, ce contrat accepte les ordres*/
    function setOldContract(address _oldContract) role1Only{
        oldContract=_oldContract;
    }
    
    /*Positionnement du contrat vers lequel, ce contrat va migrer*/
    function setNewContract (address _newContract) role1Only{
        newContract=_newContract;
        myContract=MyContract(newContract);
    }
  
    /*Migration de contrat actuel vers le nouveau contrat*/
    function move() role1Only newContractExist{
    	/*Il faut tester ici s'il y a assez de gas pour réaliser le migration*/
    	/*TODO*/
        /*Migration du role1 vers le nouveau contrat*/
        /*le chiffre 5416 est le nombre de gas nécessaire pour l'exacution de la fonction setRole1*/
        myContract.setRole1.value(0).gas(tx.gasprice*5416)(role1);
        /*Envoie du solde du contrat vers le contrat cible*/
        myContract.send(this.balance);
        /*Ici on rend inutilisable le contrat actuel*/
        role1=0;
    }
}