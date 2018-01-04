/*
admin goes to Manage Users page, types in First/Last name, email address, clicks invite user
the following are stored in an invitation table: first name, last name, email address, invite token, token expiration (now + 48h)
*/
EXEC dbo.InvitationINS @ClientID = 1
                      ,@LoginID = 'User3@gmail.com'
                      ,@FirstName = 'User'
                      ,@LastName = 'Three'
                      ,@Token = '0298r09283094823098402938092d092u0d92u0d9u0293jd0j20d9j0230u';

/*
email is sent to the email address with a link that includes the token to continue the registration process
Info is returned from INS SP. Or you can use this:
*/
EXEC dbo.InvitationStatusForTokenSEL @ClientID = 1
                                    ,@Token = '0298r09283094823098402938092d092u0d92u0d9u0293jd0j20d9j0230u';

/*
user clicks link, is taken to a page where they can fill out their info? (department, title?) once they hit register..
the user's account is now confirmed but not active; a note states they need to wait for admin to enable their account
copy data from invitation table into user table but Active = 0. Default to Read-only role:
*/
EXEC dbo.UserDetailINS @ClientID = @ClientID
                      ,@LoginID = @LoginID
                      ,@FirstName = @FirstName
                      ,@LastName = @Lastname
                      ,@EmailAddress = @LoginID
                      ,@PHash = @HashedPassword
                      ,@RoleID = 4
                      ,@IsActive = 0;

EXEC dbo.UserDetailUPD @ClientID = @ClientID
                      ,@UserID = @UserID
                      ,@FirstName = @FirstName
                      ,@LastName = @LastName
                      ,@Title = @Title
                      ,@Department = @Department;

/*
admin receives an email stating the user registered their account but it needs to be enabled
admin clicks link in an email that auto-enables them, or they go to manage users and enable them.
email gets sent to user saying their account is now usable.
*/
EXEC dbo.UserDetailIsActiveUPD @ClientID = 1
                              ,@UserID = 5
                              ,@IsActive = 1;

/*
Make sure the UserDetail activity is added as part of the UserDetailINS SP call
*/
EXEC dbo.ActivityINS @ClientID = 1
                    ,@UserID = 0
                    ,@EntityID = 6
                    ,@ActivityType = 1
                    ,@KeyValue = @NewUserID;