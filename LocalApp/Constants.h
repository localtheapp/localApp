//
//  Constants.h
//  LocalApp
//
//  Created by Nitin Sharma on 10/17/15.
//  Copyright © 2015 LocalApp. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// iOS and Device specific

#define IS_IOS_8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define IS_IOS_7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

#define IS_IPHONE_5  ([[UIScreen mainScreen] bounds].size.width >= 568 || [[UIScreen mainScreen] bounds].size.height >= 568)?YES:NO

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


// Server

#define kServerAddressDev @"https://192.168.0.101"
#define kServerAddressProd @"https://192.168.0.101"

#define kServerPortDev @"61613"
#define kServerPortProd @"61613"

// Appdelegate

#define appdelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// Model Manager
#define modelManager  ((ModelManager *)[ModelManager sharedManager])

// Notifications

#define kNotificationConversationsArrayUpdated @"ConversationArrayUpdated"

// HelpDesk Constants
#define kHelpDeskID @"HelpDesk"
#define kHelpDeskName @"Help Desk"

#endif /* Constants_h */