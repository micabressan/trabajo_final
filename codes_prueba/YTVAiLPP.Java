// create soap
MetadataService.MetadataPort service = new MetadataService.MetadataPort(
	URL.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/m/29.0', 
	UserInfo.getSessionId()
);

// create package members
MetadataService.PackageTypeMembers[] members = new MetadataService.PackageTypeMembers[] {};

/// BEGIN: Package XML	

	// Custom Object
	MetadataService.PackageTypeMembers m1 = new MetadataService.PackageTypeMembers();
	m1.name = 'CustomObject';
	m1.members = new String[] { 'Account' };
	members.add(m1);

	// Profiles
	MetadataService.PackageTypeMembers m2 = new MetadataService.PackageTypeMembers();
	m2.name = 'Profile';
	m2.members = new String[] { 'Admin' };
	members.add(m2);
	
	MetadataService.RetrieveRequest d = new MetadataService.RetrieveRequest();
	d.apiVersion = 29.0;
	d.singlePackage = true;

	d.unpackaged = new MetadataService.Package_x();
	d.unpackaged.types = members;
	d.unpackaged.version = '29.0';
/// END: Package XML

// get callout
MetadataService.AsyncResult result = service.retrieve(d);
System.debug(result.Id);

// wait some times
Long start = System.currentTimeMillis();
while(System.currentTimeMillis() < start + 3000){}

// create attachment - zip file
MetadataService.RetrieveResult response = service.checkRetrieveStatus(result.Id);
Blob b = EncodingUtil.base64Decode(response.zipFile);

Attachment attachment = new Attachment();
attachment.Body = b;
attachment.Name = String.valueOf('test.zip');
attachment.ParentId = [SELECT Id FROM Account LIMIT 1].Id; 
insert attachment;

System.debug(attachment.Id);