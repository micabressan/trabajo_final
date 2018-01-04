Index: DPSrvr.cpp
===================================================================
--- DPSrvr.cpp	(revision 633)
+++ DPSrvr.cpp	(revision 634)
@@ -10961,6 +10961,10 @@
 
 	ar.ReadString( sendstr, 1024 );
 	CString infostr = sendstr;
+
+	CUser* pUser = g_UserMng.GetUser(dpidCache, dpidUser);
+	if (!IsValidObj(pUser))
+		return;
 	
 	int strlen = infostr.GetLength();
 	j = 0;
@@ -10984,6 +10988,13 @@
 				if(k <= 20)
 				{
 					itemset[k].extracount = atoi(tempstr);
+
+					if (itemset[k].extracount < 0)
+					{
+						Error("CDPSrvr::OnCreateAngel() Negative item count sent by player %s[%07d]", pUser->GetName(), pUser->m_idPlayer);
+						return;
+					}
+
 					memset(tempchr, 0, sizeof(TCHAR)*10);
 					k++;
 					i++;
@@ -11009,10 +11020,6 @@
 	
 	nOrichalcum = 0;
 	nMoonstone = 0;
-
-	CUser* pUser = g_UserMng.GetUser( dpidCache, dpidUser );
-	if( !IsValidObj( pUser ) )
-		return;
 	
 	for(int i=0; i<itemcount; i++)
 	{
@@ -11029,6 +11036,9 @@
 				case II_GEN_MAT_MOONSTONE_1:
 					nMoonstone += itemset[i].extracount;
 					break;
+				default:
+					Error("CDPSrvr::OnCreateAngel() %s[%07d] sent invalid item id [%d]", pUser->GetName(), pUser->m_idPlayer, itemset[i].itemid);	
+					return;
 			};
 		}
 		else