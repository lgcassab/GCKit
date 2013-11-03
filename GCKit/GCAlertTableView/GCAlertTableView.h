//
//  GCAlertTableView.h
//  GCKit
//
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^ATVCancelBlock)();
typedef void (^ATVSelectionBlock)(int selectedRow);

@interface GCAlertTableView : UIAlertView <UITableViewDelegate, UITableViewDataSource> {
	UITableView *_tableView;
    UIImageView *_overlayImageView;
}
@property (nonatomic, retain, readonly) UITableView *tableView;
@property (nonatomic, retain) NSArray *arrayDatasource;

+ (UIAlertView*) alertViewWithTitle:(NSString *)title                    
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                        arrayOfRows:(NSArray  *)arrayOfRows
                           onCancel:(ATVCancelBlock)cancelled
                        onSelectRow:(ATVSelectionBlock)selectedRow;

@end
