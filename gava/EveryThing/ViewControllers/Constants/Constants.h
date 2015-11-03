//
//  Constants.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#ifndef gava_Constants_h
#define gava_Constants_h

//General constants
#define DISPLAYSCALE [[UIScreen mainScreen] scale]


//#define server @"http://192.168.2.128:8000/apiv1/"
//#define Url_pics @"http://localhost:8000/apiv1/photos/thumb/"

#define server @"http://54.149.202.171/apiv1/"
#define Url_pics @"http://54.149.202.171/apiv1/photos/thumb/"

#define ApiKey @"AIzaSyD3CGQNumujn0doCHNCLO4nyU8rxpHmjL4"

////  api
#define Url_Login [NSString stringWithFormat:@"%@%@",server,@"login"]
#define Url_Signup [NSString stringWithFormat:@"%@%@",server,@"signup"]
#define Url_fbSignUp [NSString stringWithFormat:@"%@%@",server,@"fbsignup"]
#define Url_forgotpswd [NSString stringWithFormat:@"%@%@",server,@"forgotPassword"]
#define Url_fbSignUp [NSString stringWithFormat:@"%@%@",server,@"fbsignup"]
#define Url_myCards [NSString stringWithFormat:@"%@%@",server,@"mycards"]
#define Url_myBrands [NSString stringWithFormat:@"%@%@",server,@"brands"]
#define Url_saveCard [NSString stringWithFormat:@"%@%@",server,@"savecard"]
#define Url_logout [NSString stringWithFormat:@"%@%@",server,@"logout"]
#define Url_Redemp [NSString stringWithFormat:@"%@%@",server,@"redemption"]
#define Url_TermCon [NSString stringWithFormat:@"%@%@",server,@"term"]
#define Url_Refresh [NSString stringWithFormat:@"%@%@",server,@"refresh"]
#define Url_delCard [NSString stringWithFormat:@"%@%@",server,@"deletecard"]
#define Url_SyncCard [NSString stringWithFormat:@"%@%@",server,@"sync"]
#define Url_UpdateBal [NSString stringWithFormat:@"%@%@",server,@"updateBalance"]
#define Url_GetSyncUsers [NSString stringWithFormat:@"%@%@",server,@"getSyncUsers"]
#define Url_UnsyncUsers [NSString stringWithFormat:@"%@%@",server,@"unsync"]
#define Url_syncBack [NSString stringWithFormat:@"%@%@",server,@"syncBack"]


////  cell identifiers




#endif
