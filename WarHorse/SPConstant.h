//
//  SPConstant.h
//  mywinners
//
//  Created by EnterPi on 10/09/13.
//  Copyright (c) 2013 Zytrix Labs. All rights reserved.
//

#ifndef WarHorse_SPConstant_h
#define WarHorse_SPConstant_h


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define Aleart_Title @"MyWinners"
#define Aleart_Title_New @"MyWinners"


#define QRCode_Text @"WithDrawl:\n    To withdraw funds or cash voucher.\nTerminal:\n     Access your One Day Pass on terminal."

#define TextviewMes_One @"On Hold will be deposited to your wagering when it clears the banking network. Additional requests will be deposited when they clear the banking network."
#define TextviewMes_Two @"Click here to learn how to have your immediate deposit limit increased."
#define TextviewMes_Third @"Note: Nassau OTB charges a "
#define TextviewMes_Four @"transaction fee for each ACH transaction."

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


// DevDl API's

//#define kDownLoadedBaseCMSUrl @"http://g4qc.spodemo.com/mywinnerscms/file/"
//#define kDownLoadedBaseCMSUrl @"https://m.mywinners.com/mywinnerscms/file/"

#define kDownLoadedBaseCMSUrl @"http://devdl.sparity.com:7070/mywinnerscms/file/"

#define kGetMyBets @"mywinners/services/v1/myBets"
#define myBets1 @"mywinners/services/v1/myBets1"
#define getResultsWithDate @"mywinners/services/v1/getResultsWithDate"



//Register APIs

#define createOneDayPassAccount @"mywinners/services/v3/createOneDayPassAccount"
#define kGetSendVerificationCodeForPassword @"mywinners/services/v3/sendVerificationCodeForPassword"
#define kGetresetAccountPassword @"mywinners/services/v3/resetAccountPassword"
#define kGetresetPassword @"mywinners/services/v1/resetPassword"

#define registerAnonymousUsers @"mywinners/services/v3/registerAnonymousUsers"

//New Registation API's

//#define validateAccount @"mywinners/services/v4/validateAccount"

//#define getIdology @"mywinners/services/v2/getIdology"

//#define kGetRegisterUser @"mywinners/services/v4/registerUser"

//New Registation API's

#define validateAccount @"mywinners/services/v5/validateAccount"

#define getIdology @"mywinners/services/v3/getIdology"

#define kGetRegisterUser @"mywinners/services/v5/registerUser"
// Final Registation Promo code validation

#define kPromoCodeValidation @"mywinners/services/v3/validatePromocode"


//Registration AppConfig

#define kGetRegistrationConfig @"mywinners/services/v3/getRegistrationConfig"

// ADW - NO

#define kGetValidateExistingAccount @"mywinners/services/v3/validateExistingAccount"
#define kGetRegisterExistingUser @"mywinners/services/v4/registerExistingUser"

//Old Registation API's
/*
 #define validateAccount @"mywinners/services/v3/validateAccount"
 
 #define getIdology @"mywinners/services/v1/getIdology"
 
 #define kGetRegisterUser @"mywinners/services/v3/registerUser"
 */



#define digitalVoucherRegister @"mywinners/services/v3/createTempAccount"

//LOGIN, LOGOUT API
#define Login @"mywinners/services/Login"
#define logout @"mywinners/services/v1/logout"
#define getActiveAccountIdForDevice @"mywinners/services/v3/getActiveAccountIdForDevice"


#define isAccountClosedForDevice  @"mywinners/services/v3/isAccountClosedForDevice"


//Dash Board API
#define getNumberOfInplayBets @"mywinners/services/v1/getNumberOfInplayBets"
//#define UserPreferences @"%@mywinners/services/UserPreferences"
#define UserPreferences @"mywinners/services/GetUserPreferences"


//#define SaveUserPreferences @"mywinners/services/SaveUserPreferences"
#define SaveUserPreferences @"mywinners/services/v1/saveUserPreferencesIng4"
#define nickNameInfo @"mywinners/services/v1/getNickName"



//Wager
#define kGetCards @"mywinners/services/v3/getCards"
#define getCardDetail @"mywinners/services/v3/getCardDetail"
#define isBetAmtValid @"mywinners/services/v1/isBetAmtValid"
#define placeBet @"mywinners/services/v3/placeBet"

//MyBets
#define myBets2 @"mywinners/services/v1/myBets2"
//#define myBets2 @"mywinners/services/v1/myBets3"

#define CancelBet @"mywinners/services/v3/CancelBet"

//Wallet
#define kGetPaymentServiceChargeInfo @"mywinners/services/v3/getPaymentServiceChargeInfo"
#define getAccountActivityWithPagination @"mywinners/services/getAccountActivityWithPagination"
#define Deposit @"mywinners/services/v3/Deposit"
#define withdrawal @"mywinners/services/v1/withdrawal"
#define encryptAndGenerateQR @"mywinners/services/v1/encryptAndGenerateQR"
#define redeemRewards @"mywinners/services/v3/redeemRewards"
#define getOntAndCplQRcode @"mywinners/services/v1/encryptAndGenerateQRForTransaction"



//RESULT API
#define loadCardsArray @"mywinners/services/v3/loadCardsArray"
#define getResultsWithMeetAndPerf @"mywinners/services/v1/getResultsWithMeetAndPerfFromG4" //VVH

//ODDS BOARD
#define getQueryResult @"mywinners/services/getQueryResult"

#define getAccountBalance @"mywinners/services/v1/getAccountBalance"
#define AvailableBalance @"mywinners/services/v1/AvailableBalance"
#define getRewardsSummary @"mywinners/services/v1/getRewardsSummary"

//Live Video
#define loadStreamUrl @"mywinners/services/loadStreamUrl"

//APP Config API
#define kAppConfig @"mywinners/services/v1/ReadAPI?screenId=MyWinnersCT"

#define saveAdwUser @"mywinners/services/v1/saveAdwUser"
#define RegisterAdwUser @"mywinners/services/v1/RegisterAdwUser"
#define kGetSaveAnonymousUser @"mywinners/services/v1/saveAnonymousUser"

#define getRewardPointsSummary @"mywinners/services/getRewardPointsSummary"
#define saveCustomerInfo @"mywinners/services/v1/saveCustomerInfo"

#define getCreditCardDepositUrl @"mywinners/services/v3/getCreditCardDepositUrl"



#endif