//
// Created by admin on 2017/5/10.
//

#include "FingerLockApi.h"
//#include "Log.hh"
#include <iostream>
#include <stdlib.h>
#include <openssl/md5.h>

const int CHECKID_ENCODE = 1;
const int GETSKEY_ENCODE = 2;
const int TRANS_ENCODE = 3;
std::string aes_key = "1234567812345678";
const int OPEN_ENCODE = 0;

static unsigned short ccitt_table[256] ={
        0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
        0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
        0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
        0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
        0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
        0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
        0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
        0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
        0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
        0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
        0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
        0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
        0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
        0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
        0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
        0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
        0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
        0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
        0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
        0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
        0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
        0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
        0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
        0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
        0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
        0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
        0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
        0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
        0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
        0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
        0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
        0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
};

static char sixCmdArray[6];

std::string FingerLockApi::paraseData(const char* data,int encodeType ) {
    std::string result = "";
    std::string msgC;
    msgC.assign(data);

    if(OPEN_ENCODE==1){
//        std::string base64 = LockBASE64::base64_decodestring(msgC);
//        if(encodeType==GETSKEY_ENCODE){
//            result = LockRSA::decryptRSA(data);
//        }else if(encodeType==CHECKID_ENCODE){
//            result = LockAES::decodeAES(aes_key,base64);
//        }else if(encodeType==TRANS_ENCODE){
//            result = LockAES::decodeAES(aes_key,base64);
//        }
//        result = bytestoHexString(result.c_str(),strlen(result.c_str()));
    }else{
        result = msgC;
    }
    return result;
}
std::string FingerLockApi:: deviceIdCmd(int uid, const char* imeihex){
    char cmdbyte = 0x7E;
    std::string cmdString = FingerLockApi::createUidImeiCmd(cmdbyte,uid,imeihex);
    return cmdString;
}

std::string FingerLockApi::resetCmd(){
    char cmdbyte = 0x02;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::setTimeCmd(const char* time){
    char cmdbyte = 0x03;
    unsigned  char *Bcd = new unsigned char[7] ;
    FingerLockApi::StrtoBCD((char *) time, Bcd);
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE, cmdbyte, (const char *) Bcd);
   printf("setTimeCmd,%s",cmdString.c_str());
    printf("...setTimeCmd,%s",cmdString.c_str());
    free(Bcd);
    return cmdString;
}

std::string FingerLockApi::updateCmd(){
    char cmdbyte = 0x04;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::restartCmd(){
    char cmdbyte = 0x05;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::openWifiCmd(){
    char cmdbyte = 0x06;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::queryVersionCmd(){
    char cmdbyte = 0x07;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::queryPowerCmd(){
    char cmdbyte = 0x08;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::reuestSKeyCmd(){
    char cmdbyte = 0x09;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte,GETSKEY_ENCODE);
    return cmdString;
}

std::string FingerLockApi::queryTimeCmd(){
    char cmdbyte = 0x0A;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::queryLockStateCmd(){
    char cmdbyte = 0x11;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::openLockCmd(){
    char cmdbyte = 0x12;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}

std::string FingerLockApi::alertAdminCmd(int uid,const char* imeiHex){
    char cmdbyte = 0x13;;
    std::string cmdString = FingerLockApi::createUidImeiCmd(cmdbyte,uid,imeiHex);
    return cmdString;
}

std::string FingerLockApi::addUserCmd(int uid,const char* imeiHex){
    char cmdbyte = 0x14;
    std::string cmdString = FingerLockApi::createUidImeiCmd(cmdbyte,uid,imeiHex);
    return cmdString;
}

std::string FingerLockApi::deleteUserCmd(int uid){
    char cmdbyte = 0x15;
    std::string cmdString = FingerLockApi::createUidCmd(cmdbyte,uid);
    return cmdString;
}

std::string FingerLockApi::addTempUserCmd(int uid,const char* time,const char* imeiHex){
    char cmdbyte = 0x16;
    unsigned  char *Bcd = new unsigned char[7];
    FingerLockApi::StrtoBCD((char *) time, Bcd);
    std::string cmdString = FingerLockApi::createUidTimeImeiCmd(cmdbyte, uid,
                                                            (const char *) Bcd,imeiHex);
    free(Bcd);
    return cmdString;
}

std::string FingerLockApi::deleteTempUserCmd(int uid){
    char cmdbyte = 0x17;
    std::string cmdString = FingerLockApi::createUidCmd(cmdbyte,uid);
    return cmdString;
}

std::string FingerLockApi::enterWifiSettingModeCmd(){
    char cmdbyte = 0x18;
    std::string cmdString =  FingerLockApi::createNewCmd(cmdbyte,TRANS_ENCODE);
    return cmdString;
}

std::string FingerLockApi::exitWifiSettingModeCmd(){
    char cmdbyte = 0x19;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte,TRANS_ENCODE);
    return cmdString;
}

std::string FingerLockApi::setRemoteServerMsgCmd(const char* ip,const char* port){
    char cmdbyte = 0x1A;
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE,cmdbyte,ip,port,strlen(port));
    return cmdString;
}

std::string FingerLockApi::setLockCheckCodeCmd(int checkcode){
    char cmdbyte = 0x1B;
    int len = 10;
    char cmdArray[len];
    cmdArray[0] = len;
    cmdArray[1] = 3;
    cmdArray[2] = cmdbyte;
    cmdArray[3] =checkcode >> 24;
    cmdArray[4] =checkcode >> 16;
    cmdArray[5] =checkcode >> 8;
    cmdArray[6] =checkcode;
     int randnum = (10000+rand() )% 31111;
    cmdArray[7] = randnum;
    char enccodear[len-2];
    for(int i=0;i<len-2;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[8]=((crc >> 8) & 0xff);
    cmdArray[9]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);
    return resultcmd;

}

std::string FingerLockApi::setWifiSSIDCmd(const char *ssid){
    char cmdbyte = 0x1C;
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE,cmdbyte,ssid);
    return cmdString;
}

std::string FingerLockApi::setWifiPwdCmd(const char *pwd){
    char cmdbyte = 0x1D;
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE,cmdbyte,pwd);
    return cmdString;
}

std::string FingerLockApi::disConnectedCmd(){
    char cmdbyte = 0x1E;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte,TRANS_ENCODE);
    return cmdString;
}

std::string FingerLockApi::closeBlueBroacast() {
    char cmdbyte = 0x1F;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte,TRANS_ENCODE);
    return cmdString;
}

std::string FingerLockApi::changeLockName(const char* lockname) {
    char cmdbyte = 0x20;
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE,cmdbyte,lockname);
    return cmdString;
}


std::string FingerLockApi::sendRandNumberCmd(){
    int len = 10;
    char cmdArray[len];
    cmdArray[0] =len;
    cmdArray[1] = 0x00;
    cmdArray[2] = 0x00;
    int randnumber = (rand() % (65535-10000))+ 10000;
    int randnumber2 = (rand() % (65535-10000))+ 10000;
    cmdArray[3] = randnumber >> 8;
    cmdArray[4] = randnumber;
    cmdArray[5] = randnumber2 >> 8;
    cmdArray[6] = randnumber2;
     int randnum = (10000+rand() )% 31111;
    cmdArray[7] = randnum;
    char enccodear[len-2];
    for(int i=0;i<8;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, 8);
    cmdArray[8]=((crc >> 8) & 0xff);
    cmdArray[9]=(crc & 0xff);
    std::string result = bytestoHexString(cmdArray,10);
    return result;
}

//std::string FingerLockApi::sendCheckCodeCmd(const char* appid){
//    char* primary = (char *) malloc(8);
//    primary[0] = 0x9f;
//    primary[1] = 0x32;
//    primary[6] = 0x52;
//    primary[7] = 0xed;
//    primary[2] =  1 + rand() % 253;
//    primary[3] =  1 + rand() % 253;
//    primary[4] = 1 + rand() % 253;
//    primary[5] = 1 + rand() % 253;
//
//    std::string priString = bytestoHexString(primary,8);
//    LOGD("md5pri,%s",priString.c_str());
//    std::string md5 = LockMD5::encryptMD5(primary,8);
//   LOGD("md5,%s",md5.c_str());
//    std::string codeString = appid;
//    codeString+="11121314";
//    codeString+=md5.c_str();
//    const char* codeArray = codeString.c_str();
//    LOGD("checkcode,%s",codeArray);
//    std::string cmdString = "1E0301";
//    cmdString+=codeString;
//    std::string result;
//    result = cmdString;
//    free(primary);
//    return result;
//}

std::string FingerLockApi::sendCheckCodeCmd(const char* appid){
    std::string result;
    unsigned char *primary = new unsigned char[8];
    primary[0] = 0x9f;
    primary[1] = 0x32;
    primary[6] = 0x52;
    primary[7] = 0xed;
    int randnumber = (rand() % (65535-10000))+ 10000;
    int randnumber2 = (rand() % (65535-10000))+ 10000;
    primary[2] =  randnumber >> 8;
    primary[3] =  randnumber;
    primary[4] = randnumber2 >> 8;
    primary[5] = randnumber2;

   printf("md5pridata,%s",bytestoHexString((const char *)primary,8).c_str());
    std::string calMD5Reuslt = FingerLockApi::calMd5(primary);
   printf("calmd5Resut,%s",calMD5Reuslt.c_str());
    std::string appidHexString = appid;
    char* appidarray = hexstringToBytes(appidHexString);
    char randarray[4];
    char* md5array = hexstringToBytes(calMD5Reuslt);
    randarray[0] = primary[2];
    randarray[1] = primary[3];
    randarray[2] = primary[4];
    randarray[3] = primary[5];
    char checkcodeArray[24];
    int i=0;
    for(;i<4;i++){
        checkcodeArray[i] = appidarray[i];
    }
    for(;i<8;i++){
        checkcodeArray[i] = randarray[i-4];
    }
    for(;i<24;i++){
        checkcodeArray[i] = md5array[i-8];
    }
    free(appidarray);
    free(primary);
    int len = 30;
    char cmdArray[len];
    cmdArray[0] = 30;
    cmdArray[1] = 3;
    cmdArray[2] = 1;
    for (int i = 0; i <24 ; i++) {
        cmdArray[3+i] = checkcodeArray[i];
    }
    int randnum = (10000+rand() )% 31111;
    cmdArray[27] = randnum;
    char enccodear[len-2];
    for(int i=0;i<28;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, 28);
    cmdArray[28]=((crc >> 8) & 0xff);
    cmdArray[29]=(crc & 0xff);
    result = bytestoHexString(cmdArray,30);
   printf("c++ sendAuthCode ,%s",result.c_str());
    return result;
}

std::string FingerLockApi::createUidCmd(char cmdbyte,int uid){
    int len = 11;
    char cmdArray[len];
    cmdArray[0] = 11;
    cmdArray[1] = 3;
    cmdArray[2] = cmdbyte;
    cmdArray[3] = 00;
    cmdArray[4] =uid >> 24;
    cmdArray[5] =uid >> 16;
    cmdArray[6] =uid >> 8;
    cmdArray[7] =uid;
     int randnum = (10000+rand() )% 31111;
    cmdArray[8] = randnum;
    char enccodear[len-2];
    for(int i=0;i<9;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[9]=((crc >> 8) & 0xff);
    cmdArray[10]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);

    return resultcmd;

}

std::string FingerLockApi::createUidTimeCmd(char cmdbyte,int uid,const char* bcd){
    int len = 18;
    char cmdArray[len];
    cmdArray[0] = len;
    cmdArray[1] = 3;
    cmdArray[2] = cmdbyte;
    cmdArray[3] = 00;
    cmdArray[4] =uid >> 24;
    cmdArray[5] =uid >> 16;
    cmdArray[6] =uid >> 8;
    cmdArray[7] =uid;
    cmdArray[8] = bcd[0];
    cmdArray[9] = bcd[1];
    cmdArray[10] = bcd[2];
    cmdArray[11] = bcd[3];
    cmdArray[12] = bcd[4];
    cmdArray[12] = bcd[5];
    cmdArray[14] = bcd[6];
     int randnum = (10000+rand() )% 31111;
    cmdArray[15] = randnum;
    int encodelen = len-2;
    char enccodear[encodelen];
    for(int i=0;i<encodelen;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[16]=((crc >> 8) & 0xff);
    cmdArray[17]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);
    return resultcmd;
}


std::string FingerLockApi::createUidImeiCmd(char cmdbyte,int uid,const char* imeiHex){
    char* imei = hexstringToBytes(imeiHex);
    int imeiHexLen = strlen(imeiHex)/2;
    int len = 11+imeiHexLen;
    char cmdArray[len];
    cmdArray[0] = len;
    cmdArray[1] = 3;
    cmdArray[2] = cmdbyte;
    cmdArray[3] = 00;
    cmdArray[4] =uid >> 24;
    cmdArray[5] =uid >> 16;
    cmdArray[6] =uid >> 8;
    cmdArray[7] =uid;
    for(int i=0;i<imeiHexLen;i++){
        cmdArray[8+i] = imei[i];
    }

    int randnum = (10000+rand() )% 31111;
    cmdArray[8+imeiHexLen] = randnum;
    int encodelen = len-2;
    char enccodear[encodelen];
    for(int i=0;i<encodelen;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[9+imeiHexLen]=((crc >> 8) & 0xff);
    cmdArray[10+imeiHexLen]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);

    return resultcmd;

}

std::string FingerLockApi::createUidTimeImeiCmd(char cmdbyte,int uid,const char* bcd,const char* imeiHex){
    char* imei = hexstringToBytes(imeiHex);
    int imeiHexLen = strlen(imeiHex)/2;
    int len = 18+imeiHexLen;
    char cmdArray[len];
    cmdArray[0] = len;
    cmdArray[1] = 3;
    cmdArray[2] = cmdbyte;
    cmdArray[3] = 00;
    cmdArray[4] =uid >> 24;
    cmdArray[5] =uid >> 16;
    cmdArray[6] =uid >> 8;
    cmdArray[7] =uid;
    cmdArray[8] = bcd[0];
    cmdArray[9] = bcd[1];
    cmdArray[10] = bcd[2];
    cmdArray[11] = bcd[3];
    cmdArray[12] = bcd[4];
    cmdArray[12] = bcd[5];
    cmdArray[14] = bcd[6];
    for(int i=0;i<imeiHexLen;i++){
        cmdArray[15+i] = imei[i];
    }
    int randnum = (10000+rand() )% 31111;
    cmdArray[15+imeiHexLen] = randnum;
    int encodelen = len-2;
    char enccodear[encodelen];
    for(int i=0;i<encodelen;i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[16+imeiHexLen]=((crc >> 8) & 0xff);
    cmdArray[17+imeiHexLen]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);
    return resultcmd;
}






std::string FingerLockApi::setFkeyMacRUID(const char* macaddress,int uid){
    char cmdbyte = 0x81;
    int maclen = strlen(macaddress);
    int len = 11+maclen;
    char cmdArray[len];
    cmdArray[0] = len;
    cmdArray[1] = 3;
    cmdArray[2] = cmdbyte;
    for(int i=0;i<maclen;i++){
        cmdArray[3+i] = macaddress[i];
    }
    cmdArray[3+maclen] = 00;
    cmdArray[4+maclen] = uid >> 24;
    cmdArray[5+maclen] = uid >> 16;
    cmdArray[6+maclen] = uid >> 8;
    cmdArray[7+maclen] = uid;
     int randnum = (10000+rand() )% 31111;
    cmdArray[8+maclen] = randnum;
    char enccodear[len-2];
    for(int i=0;i<(len-2);i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[len-2]=((crc >> 8) & 0xff);
    cmdArray[len-1]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);
    return resultcmd;

}

std::string FingerLockApi::enterFingerEditMode(int uid){
    char cmdbyte = 0x86;
    std::string cmdString = FingerLockApi::createUidCmd(cmdbyte, uid);
    return cmdString;
}


std::string FingerLockApi::inputFingerprint(const char* time){
    char cmdbyte = 0x87;
    unsigned  char *Bcd = new unsigned char[7];
    FingerLockApi::StrtoBCD((char *) time, Bcd);
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE,cmdbyte ,(const char *)Bcd);
    return cmdString;
}

std::string FingerLockApi::deleteOneFingerprint(const char* id){
    char cmdbyte = 0x88;
    std::string cmdString = FingerLockApi::createNewCmd(TRANS_ENCODE,cmdbyte, id);
    return cmdString;
}




std::string FingerLockApi::exitFingerEditMode(int uid){
    char cmdbyte = 0x8A;
    std::string cmdString = FingerLockApi::createUidCmd(cmdbyte, uid);
    return cmdString;
}


std::string FingerLockApi::resetFkey(int uid){
    char cmdbyte = 0x8B;
    std::string cmdString = FingerLockApi::createUidCmd(cmdbyte, uid);
    return cmdString;
}

std::string FingerLockApi::getFkeyState(){
    char cmdbyte = 0x8C;
    std::string cmdString = FingerLockApi::createNewCmd(cmdbyte);
    return cmdString;
}



std::string  FingerLockApi::createNewCmd(char encodetype, char cmd, const char *cmdParams) {
    int paramsLen = strlen(cmdParams);
    int len =6+paramsLen;
    char cmdArray[len];
    cmdArray[0] = len;
    cmdArray[1] = encodetype;
    cmdArray[2] = cmd;
    for(int i=0;i<paramsLen;i++){
        cmdArray[3+i] = cmdParams[i];
    }
     int randnum = (10000+rand() )% 31111;
    cmdArray[len-3] = randnum;
    char enccodear[len-2];
    for(int i=0;i<(len-2);i++){
        enccodear[i] = cmdArray[i];
    }
    unsigned  short crc = calCRC((unsigned char *) enccodear, len-2);
    cmdArray[len-2]=((crc >> 8) & 0xff);
    cmdArray[len-1]=(crc & 0xff);
    std::string resultcmd =  bytestoHexString(cmdArray,len);
    return resultcmd;

}

std::string  FingerLockApi::createNewCmd(char encodetype, char cmd, const char *cmdParams,const char *cmdParamsTwo,int secondCmdLen) {
    std::string cmdstr = "";
    int length =6+strlen(cmdParams)+secondCmdLen;
    cmdstr+=length;
    cmdstr+=encodetype;
    cmdstr+=cmd;
    for( int i=0;i<strlen(cmdParams);i++){
        cmdstr+= cmdParams[i];
    }
    for(int j=0;j<secondCmdLen;j++){
        cmdstr+= cmdParamsTwo[j];
    }

     int randnum = (10000+rand() )% 31111;
//    int randnum = 255;
    cmdstr+= randnum;
    unsigned  short crc = calCRC((unsigned char *) cmdstr.data(), strlen(cmdstr.data()));
    cmdstr+=((crc >> 8) & 0xff);
    cmdstr+=(crc & 0xff);
    std::string base64;
    if(OPEN_ENCODE==1){
//        std::string encodeCmdString;
//        if(encodetype==GETSKEY_ENCODE){
//            encodeCmdString = LockRSA::encryptRSA(cmdstr,NULL);
//        }else{
//            encodeCmdString = LockAES::encodeAES(aes_key,cmdstr);
//        }
//        base64 = LockBASE64::base64_encodestring(encodeCmdString);
    }else{
//        base64 = bytestoHexString(cmdstr.c_str(),strlen(cmdstr.c_str()));
        base64 = bytestoHexString(cmdstr.c_str(),strlen(cmdstr.c_str()));
    }
    return base64;

}


std::string  FingerLockApi::createNewCmd( char cmd) {

    return createNewCmd(cmd,TRANS_ENCODE);

}


std::string  FingerLockApi::createNewCmd( char cmd,int encode) {
    std::string cmdstr = "";
    int length = 6;
    cmdstr+=length;
    cmdstr+=encode;
    cmdstr+=cmd;
    int randnum = (10000+rand() )% 31111;
    cmdstr+= randnum;
    unsigned  short crc = calCRC((unsigned char *) cmdstr.data(), strlen(cmdstr.data()));
    cmdstr+=((crc >> 8) & 0xff);
    cmdstr+=(crc & 0xff);
    std::string base64;
    if(OPEN_ENCODE==1){
//        std::string encodeCmdString = LockAES::encodeAES(aes_key,cmdstr);
//        base64 = LockBASE64::base64_encodestring(encodeCmdString);
    }else{
        base64 = bytestoHexString(cmdstr.c_str(),strlen(cmdstr.c_str()));
    }

    return base64;
}



char*FingerLockApi::hexstringToBytes(std::string s)
{
    int sz = s.length();
    char *ret = new char[sz/2];
    for (int i=0 ; i <sz ; i+=2) {
        ret[i/2] = (char) ((hexCharToInt(s.at(i)) << 4)
                           | hexCharToInt(s.at(i+1)));
    }
    return ret;
}

int FingerLockApi::hexCharToInt(char c)
{
    if (c >= '0' && c <= '9') return (c - '0');
    if (c >= 'A' && c <= 'F') return (c - 'A' + 10);
    if (c >= 'a' && c <= 'f') return (c - 'a' + 10);
    return 0;
}


std::string FingerLockApi:: bytestoHexString(const char* bytes,int bytelength) {
    std::string  str("");
    std::string  str2("0123456789abcdef");
    for (int i=0;i<bytelength;i++) {
        int b;
        b = 0x0f&(bytes[i]>>4);
        char s1 = str2.at(b);
        str.append(1,str2.at(b));
        b = 0x0f & bytes[i];
        str.append(1,str2.at(b));
        char s2 = str2.at(b);
    }
    return str;
}

unsigned  short FingerLockApi::calCRC(unsigned  char *ptr, int len) {
    unsigned int crc = 0;
    unsigned short crc_reg = 0x0000;

    while (len--)
        crc_reg = (crc_reg >> 8) ^ ccitt_table[(crc_reg ^ *ptr++) & 0xff];

    return crc_reg;

}

bool FingerLockApi::StrtoBCD(char *str,unsigned char *BCD)
{
    if(str==0) return false;
    int tmp=strlen(str);
    tmp-=tmp%2;
    if(tmp==0) return false;
    int i,j;
    for(i=0;i<tmp;i++)
    {
        if(str==0 ||
           !(str[i]>='0' && str[i]<='9' || str[i]>='a' && str[i]<='f' || str[i]>='A' && str[i]<='F')
                )
            return false;
    }

    for(i=0,j=0;i<tmp/2;i++,j+=2)
    {
        str[j]>'9' ?
        (str[j]>'F' ? BCD[i]=str[j]-'a'+10 : BCD[i]=str[j]-'A'+10)
                   : BCD[i]=str[j]-'0';
        str[j+1]>'9' ?
        (str[j+1]>'F' ? BCD[i]=(BCD[i]<<4)+str[j+1]-'a'+10 : BCD[i]=(BCD[i]<<4)+str[j+1]-'A'+10)
                     : BCD[i]=(BCD[i]<<4)+str[j+1]-'0';
    }
    return true;
}

std::string FingerLockApi::calMd5(unsigned char* input){
//    MD5_CTX md5;
//    MD5Init(&md5);
//    MD5Update(&md5,input,8);
//    MD5Final(&md5);
//    MDPrint(&md5);
//    int  i;
//    char  tmp[3]={ '\0' },buf[33]={ '\0' };
//    for  (i = 0; i < 16; i++){
//        sprintf (tmp, "%02x" ,md5.digest[i]);
//        strcat (buf,tmp);
//    }
//    printf ( "%s\n" ,buf);
//    return buf;
    MD5_CTX md5;
    MD5_Init(&md5);
    MD5_Update(&md5,input,8);
    unsigned  char* md = (unsigned char *) malloc(16);
    MD5_Final(md,&md5);
    std::string result = bytestoHexString((const char *) md, 16);
    free(md);
    return result;

}






