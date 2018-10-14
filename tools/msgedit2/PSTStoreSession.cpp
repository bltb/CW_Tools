#include <sstream>
#include <cassert>
#include "PSTStoreSession.h"

using namespace std;

PSTStoreSession::PSTStoreSession()
	:m_pSession(NULL)
{
	m_pLogger = Logger::getLogger("PSTSTORESESSION");
}

PSTStoreSession::~PSTStoreSession()
{
}

string
PSTStoreSession::convertHRESULTtoHex(HRESULT hRes)
{
	stringstream ss;
	ss << std::hex << hRes;
	return ss.str();
}

string
PSTStoreSession::GetLastError(HRESULT hRes)
{
	string		sErr("unknown");
	LPMAPIERROR pErr = NULL;
	
	assert(m_pSession != NULL);
	
	if (S_OK == m_pSession->GetLastError(hRes, 0, &pErr))
	{
		sErr = string(pErr->lpszError);
		MAPIFreeBuffer((LPVOID)pErr);
	}
	
	return sErr;
}
