//
//  GCAuthenticationDialog.h
//  Part of GCHTTPRequest -> http://allseeing-i.com/GCHTTPRequest
//
//  Created by Ben Copsey on 21/08/2009.
//  Copyright 2009 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GCHTTPRequest;

typedef enum _GCAuthenticationType {
	GCStandardAuthenticationType = 0,
    GCProxyAuthenticationType = 1
} GCAuthenticationType;

@interface GCAutorotatingViewController : UIViewController
@end

@interface GCAuthenticationDialog : GCAutorotatingViewController <UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource> {
	GCHTTPRequest *request;
	GCAuthenticationType type;
	UITableView *tableView;
	UIViewController *presentingController;
	BOOL didEnableRotationNotifications;
}
+ (void)presentAuthenticationDialogForRequest:(GCHTTPRequest *)request;
+ (void)dismiss;

@property (retain) GCHTTPRequest *request;
@property (assign) GCAuthenticationType type;
@property (assign) BOOL didEnableRotationNotifications;
@property (retain, nonatomic) UIViewController *presentingController;
@end
