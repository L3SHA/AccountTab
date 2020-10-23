public class AccountController {
    
    private List<SelectOption> accountsSelect = new List<SelectOption>();
    private List<Account> accounts;
    
    public String accountId {get; set;}
    public Account account {get; set;}
    public boolean isCreateAccount {get; set;}
    public boolean isCreateContact {get; set;}
    public Account newAccount {get; set;}
    public Contact newContact {get; set;}

	public Integer size{get;set;}

	public List<Contact> contacts { get; set;}

    public AccountController(){
        isCreateAccount = false;
        iscreateContact = false;
        
        newAccount = new Account();
        newContact = new Contact();
        
       	RefreshAccounts(); 
        
        System.debug(accountId);
        
        getAccount();
    }
    
    private void RefreshAccounts(){
        accounts = [SELECT Id, Name FROM Account ORDER BY Name ASC];
        
        for(Account acc : accounts){
           accountsSelect.Add(new SelectOption(acc.Id, acc.Name)); 
        }
        
        accountId = accounts[0].Id;
    }
    
    public void openAccForm(){
        isCreateAccount = true;
    }
    
    public void closeAccForm(){
        isCreateAccount = false;
    }
    
    public void saveAccount(){
        insert newAccount;
        RefreshAccounts();
    }
    
    public void openContactForm(){
        isCreateContact = true;
    }
    
    public void closeContactForm(){
        isCreateContact = false;
    }
    
    public void saveContact(){
        insert newContact;
        
    }
    
    public ApexPages.StandardSetController pageContent {
		get{
				size = 10;
                Id accId = account.Id;
                String queryString =  'SELECT Id, Name, Title, Phone, AccountId FROM Contact WHERE AccountId =: accId';
				pageContent = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
				pageContent.setPageSize(size);
                contacts = (List<Contact>)pageContent.getRecords();
				return pageContent;
		}
        set;
	}
    
	public List<SelectOption> getAccounts() {    
    	return accountsSelect;
	}
    
    public void getAccount(){
        account = [SELECT Id, Name, AccountNumber, 	Type,
                          SLAExpirationDate__c, Phone, Industry, AnnualRevenue,
                          Rating, Fax, NumberOfEmployees 
                          FROM Account WHERE Id =: accountId LIMIT 1];
    }
    
}