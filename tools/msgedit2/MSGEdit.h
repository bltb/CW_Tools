#ifndef MSGEDIT_H
#define MSGEDIT_H

#include "CSVReader.h"
#include "Logger.h"
#include "Session.h"

typedef std::vector<string>	msgcommand;
typedef std::vector<string>::iterator msgiter;

class MSGEdit
{
private:
	CSVReader 	m_csvReader;
	Session*	m_pSession;
	
	Logger* m_pLogger;
	
public:
	MSGEdit(CSVReader& csvReader, Session* session);
	~MSGEdit();	
	
	bool getNextCommand(msgcommand& cmd);
	bool processCommand(msgcommand);
	bool processUpdateCommand(msgcommand cmd);
	bool processUpdateSubjectCommand(msgcommand cmd);
	bool processUpdateRecipientsCommand(msgcommand cmd);
	void processAllCommands();
	bool processAddCommand(msgcommand cmd);
	bool processAddAttachment(msgcommand cmd);
	bool processDelete_PR_RTF_COMPRESSED(msgcommand cmd);
	bool processUpdateBodyCommand(msgcommand cmd);
};

#endif