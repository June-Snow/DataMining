/* ********************************************
* http://www.codeproject.com/Articles/1075/A-set-of-ADO-classes-version
------------------Map Type---------------------

Sample with Connection string for SQL Server

CADODatabase* pAdoDb = new CADODatabase();
CString strConnection = _T("");

strConnection = _T("Provider=MSDASQL;PersistSecurityInfo=False;"
	"Trusted_Connection=Yes;"
	"Data Source=Access Sql Server;catalog=sampledb");
pAdoDb->SetConnectionString(strConnection);

if(pAdoDb->Open())
	DoSomething();
.
	.
	.

	//Sample with Connection String for Access database

	CADODatabase* pAdoDb = new CADODatabase();
CString strConnection = _T("");

strConnection = _T("Provider=Microsoft.Jet.OLEDB.4.0;"
	"Data Source=C:\\VCProjects\\ADO\\Test\\dbTest.mdb");
pAdoDb->SetConnectionString(strConnection);

if(pAdoDb->Open())
{
	DoSomething();
	.
		.
		.
		pAdoDb->Close();
}

delete pAdoDb;

*/



/* ********************************************
------------------Map Type---------------------
if(prs->Open("Clients", CADORecordset::openTable))
{
CADOFieldInfo pInfo;

prs->GetFieldInfo("Description", &pInfo);

if(pInfo.m_nType == CADORecordset::typeVarChar)
AfxMessageBox("The type Description Field Is VarChar");
}


if(prs->Open("TestTable", CADORecordset::openTable))
{
CADOFieldInfo* fInfo = new CADOFieldInfo;

prs.GetFieldInfo(0, fInfo);
CString strFieldName = fInfo->m_strName;
prs->Close();
}

***************************************************/