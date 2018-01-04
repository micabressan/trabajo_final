/*
 *YSA : 04/12/2017
 * les classes testées : - ALS_Generate_Tmp_Link
 * 						 - ALS_Batch_Generate_Tmp_Link
 * 					     - ALS_Batch_Generate_Tmp_Link_Sched
 * 
 */
@isTest
public class ALS_Generate_Tmp_Link_Test {
    
    /*
     * Tester si lien privé et temporaire n'est généré que pour les contacts qui ont une adresse mail 
     */
    public static testMethod void generateTmpLink_Test(){
        //Créer deux contacts 
        
        //Contact avec Email
        Contact ctc1 = new Contact(LastName = 'LastName1', FirstName = 'FirstName1', Email = 'myriam.du@l214.com');
        
        //Contact sans Email
        Contact ctc2 = new Contact(LastName = 'LastName2', FirstName = 'FirstName2');
        
        //Insérer les deux contacts
        List<Contact> listContact = new List<Contact>{ctc1, ctc2};
        Insert listContact;
        
        //Instance for custom settings TemporaryLink
        Temporary_link__c cs = new Temporary_link__c(Encrypt_Key__c = '2534c41377ca89414f40161840feef66d6dfc73d',
                                                     URL__c = 'https://espadon.l214.ovh/d/');
        Insert cs;
        
        Test.startTest();
        	ALS_Batch_Generate_Tmp_Link obj = new ALS_Batch_Generate_Tmp_Link();
			DataBase.executeBatch(obj);
        Test.stopTest();
        
        //Tester si le lien a bien été généré pour le contact1 qui a une adresse mail
        ctc1 = [Select id, Lien_prive_et_temporaire__c from contact where id =: ctc1.id];
        System.assertEquals(false, String.isBlank(ctc1.Lien_prive_et_temporaire__c));
        
        //Tester si le lien n'a pas été généré pour le contact qui n'a pas d'adresse mail
        ctc2 = [Select id, Lien_prive_et_temporaire__c from contact where id =: ctc2.id];
        System.assertEquals(true, String.isBlank(ctc2.Lien_prive_et_temporaire__c));        
    }
    
    /*
     * Tester la méthode de génération de lien privé et temporaire 
     */
    static testMethod void generateTmpLinkPure_Test(){
        //Id du contact
        String ctcId 	= '0035E00000LDcWNQA1';
        //email du contact
        String ctcEmail = 'myriam.du@l214.com';
        
        //Instance for custom settings TemporaryLink
        Temporary_link__c cs = new Temporary_link__c(Encrypt_Key__c = '2534c41377ca89414f40161840feef66d6dfc73d');
        Insert cs;        
        //Get key
        String secret = cs.Encrypt_Key__c;
        
        Test.startTest();
        	String linkPure = ALS_Generate_Tmp_Link.generateTmpLinkPure(ctcEmail, ctcId, 1513177342, secret);
        Test.stopTest();
        
        //Test the value returned by getHashedId
        System.assertEquals(false, String.isBlank(linkPure)); 
        System.assertEquals('eyJlbWFpbCI6Im15cmlhbS5kdUBsMjE0LmNvbSIsInNpZ24iOiJiQW03bjBsQmdaOW11UG9ZOThoVl9oekZ0N1lHZUNWQkJnQnJrOF9JUW1vKiIsInRpbWUiOjE1MTMxNzczNDJ9-qqny00OgFBQp7IqX2WwxBnmJjWU0NPlfLAXT1wNAMiQ*', linkPure);        
    
    }
    
    /*
     * Test Signature the content by a random factor 
     */
    Static testMethod void signContent_Test(){
        
        string content = '{"email":"myriam.du@l214.com","sign":"bAm7n0lBgZ9muPoY98hV_hzFt7YGeCVBBgBrk8_IQmo*","time":1513177342}';
        
        //Instance for custom settings TemporaryLink
        Temporary_link__c cs = new Temporary_link__c(Encrypt_Key__c = '2534c41377ca89414f40161840feef66d6dfc73d');
        Insert cs;        
        //Get key
        String secret = cs.Encrypt_Key__c;
        
        test.startTest();
        	String signature = ALS_Generate_Tmp_Link.signContent(content, secret);
        test.stopTest();
        
        System.assertEquals('eyJlbWFpbCI6Im15cmlhbS5kdUBsMjE0LmNvbSIsInNpZ24iOiJiQW03bjBsQmdaOW11UG9ZOThoVl9oekZ0N1lHZUNWQkJnQnJrOF9JUW1vKiIsInRpbWUiOjE1MTMxNzczNDJ9-qqny00OgFBQp7IqX2WwxBnmJjWU0NPlfLAXT1wNAMiQ*', signature);
    }
    
    /*
     * Tester la génération de la signature à partir de l'id du contact
     */
    Static testMethod void signature_Test(){
        //Id du contact
        String ctcId 	= '0035E00000LDcWNQA1';
        
        //Instance for custom settings TemporaryLink
        Temporary_link__c cs = new Temporary_link__c(Encrypt_Key__c = '2534c41377ca89414f40161840feef66d6dfc73d');
        Insert cs;
        
        //Get key
        String secret = cs.Encrypt_Key__c;
        
        Test.startTest();
        	String signature = ALS_Generate_Tmp_Link.signature(ctcId, cs.Encrypt_Key__c);
        Test.stopTest();
        
        //Test the value returned by getHashedId
        System.assertEquals(false, 	String.isBlank(signature)); 
        System.assertEquals('bAm7n0lBgZ9muPoY98hV_hzFt7YGeCVBBgBrk8_IQmo*', signature);
    }
    
    /*
     * Tester la methode de codage en base64
     */
    public static testMethod void base64UrlEncode_Test(){
        String content = '{"email":"myriam.du@l214.com","sign":"bAm7n0lBgZ9muPoY98hV_hzFt7YGeCVBBgBrk8_IQmo*","time":1513177342}';
        Test.startTest();
        	content = ALS_Generate_Tmp_Link.base64UrlEncode(Blob.valueOf(content));
        Test.stopTest();
        
        System.assertEquals('eyJlbWFpbCI6Im15cmlhbS5kdUBsMjE0LmNvbSIsInNpZ24iOiJiQW03bjBsQmdaOW11UG9ZOThoVl9oekZ0N1lHZUNWQkJnQnJrOF9JUW1vKiIsInRpbWUiOjE1MTMxNzczNDJ9', content);
    }
    
    /*
     * Tester la méthode qui décode en base64
     */
    public static testMethod void base64UrlDecode_Test(){
        test.startTest();
        	String inputDecode = ALS_Generate_Tmp_Link.base64UrlDecode('TDIxNA==');//.*_
        test.stopTest();
        
        System.assertEquals(inputDecode, 'L214');
    }
    
    /*
     * Tester la méthode qui remplace les caractères dans le cas de codage
     */
    public static testMethod void replaceCaractere_Encode_Test(){
        String input = '/Chaîne + de cara=ctère/';
        
        Test.startTest();
        	input = ALS_Generate_Tmp_Link.replaceCaractere(input, true);
        Test.stopTest();
        
        System.assertEquals('*Chaîne + de cara_ctère*', input);
    }
    
    /*
     * Tester la méthode qui remplace les caractères dans le cas de décodage
     */
    public static testMethod void replaceCaractere_Decode_Test(){
        String input = '*Chaîne + de cara_ctère*';
        
        Test.startTest();
        	input = ALS_Generate_Tmp_Link.replaceCaractere(input, false);
        Test.stopTest();
        
        System.assertEquals('/Chaîne + de cara=ctère/', input);
    }
    
    //On teste la planification
    static testMethod void ALS_Batch_Generate_Tmp_Link_Sched_Test() {
        Test.startTest();
            //Planification du batch
            ALS_Batch_Generate_Tmp_Link_Sched.schedule('Générer les liens','0 0 2 * * ?');
            
            CronTrigger[] ct = [SELECT Id, CronExpression, TimesTriggered,NextFireTime
                                FROM CronTrigger ];
             System.assert( ct.size() > 0 );              
             System.assertNotEquals('', ct[0].CronExpression);

        Test.stopTest();

    }

}