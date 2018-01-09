//
// Created by admin on 2017/5/10.
//

#ifndef RSADEMO_FINGERLOCKAPI_H
#define RSADEMO_FINGERLOCKAPI_H


#include <string>



class FingerLockApi {

public:

    static std::string paraseData(const char* data,int encodeType );
    static std::string deviceIdCmd(int uid,const char* imeiHex);
    static std::string resetCmd();
    static std::string setTimeCmd(const char* time);
    static std::string updateCmd();
    static std::string restartCmd();
    static std::string openWifiCmd();
    static std::string queryVersionCmd();
    static std::string queryPowerCmd();
    static std::string reuestSKeyCmd();
    static std::string queryTimeCmd();
    static std::string queryLockStateCmd();
    static std::string openLockCmd();
    static std::string alertAdminCmd(int uid,const char* imeiHex);
    static std::string addUserCmd(int uid,const char* imeiHex);
    static std::string deleteUserCmd(int uid);
    static std::string addTempUserCmd(int uid,const char* time,const char* imeiHex);
    static std::string deleteTempUserCmd(int uid);
    static std::string enterWifiSettingModeCmd();
    static std::string exitWifiSettingModeCmd();
    static std::string setRemoteServerMsgCmd(const char* ip,const char* port);
    static std::string setLockCheckCodeCmd(int checkcode);
    static std::string sendRandNumberCmd();
    static std::string sendCheckCodeCmd(const char* appid);
    static std::string setWifiSSIDCmd(const char* ssid);
    static std::string setWifiPwdCmd(const char* pwd);
    static std::string disConnectedCmd();
    static std::string closeBlueBroacast();
    static std::string changeLockName(const char* lockname);



    static std::string setFkeyMacRUID(const char* macadress,int ruid);
    static std::string enterFingerEditMode(int uid);
    static std::string inputFingerprint(const char* endtime);
    static std::string deleteOneFingerprint(const char* findgerprintId);
    static std::string deleteAllFingerprint(int uid);
    static std::string exitFingerEditMode(int uid);
    static std::string resetFkey(int uid);
    static std::string getFkeyState();
    static std::string getFingerprintIds(int uid);

    static std::string bytestoHexString(const char* bytes,int bytelength);
    static char*  hexstringToBytes(std::string s);
    static int hexCharToInt(char c);
    static std::string createNewCmd(char cmdbyte);
    static std::string createNewCmd(char encodetype,char cmdbyte,const char* cmdParams);
    static std::string createNewCmd(char encodetype,char cmdbyte,const char* cmdParams,const char* cmdParamsTwo,int secondCmdLen);
    static std::string createNewCmd(char cmdbyte,int encode);
    static std::string createUidCmd(char cmdbyte,int uid);
    static std::string createUidTimeCmd(char cmdbyte,int uid,const char* cmdParams);
    static std::string createUidImeiCmd(char cmdbyte,int uid,const char* imeiHex);
    static std::string createUidTimeImeiCmd(char cmdbyte,int uid,const char* cmdParams,const char* imeiHex);
    static unsigned short calCRC(unsigned  char *q ,int len);

    static  bool StrtoBCD(char *str,unsigned char *BCD);

    static std::string calMd5(unsigned char *input);
};


#endif //RSADEMO_FINGERLOCK_H
