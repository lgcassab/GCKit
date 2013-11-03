//
//  GCTableCell.h
//  GCKit
//
//  Created by Gustavo Cassab on 12/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GCTableCellBadgeView.h"

@class GCTableController;

@interface GCTableCell : UITableViewCell {

    NSString *dictionaryKey;
	BOOL lockCellSelection;
	
	id userObject;
    id userObject2;
    id userObject3;
    id userObject4;
    id userObject5;
    
    id userID;
    id userID2;
    id userID3;
    id userID4;
    id userID5;
	
	BOOL canEdit;
	UITableViewCellEditingStyle editingStyle;
	
	BOOL hideBackgroundView;
    
    NSIndexPath *indexPath;
}
@property(nonatomic, assign)GCTableController *tableController;
@property(nonatomic, readwrite) CGFloat height;
@property(nonatomic, readonly)GCTableCellBadgeView *badgeView;

@property(nonatomic, retain) NSString *dictionaryKey;
@property(nonatomic, readwrite)BOOL lockCellSelection;

@property(nonatomic, retain)id userObject;
@property(nonatomic, retain)id userObject2;
@property(nonatomic, retain)id userObject3;
@property(nonatomic, retain)id userObject4;
@property(nonatomic, retain)id userObject5;

@property(nonatomic, retain)id userID;
@property(nonatomic, retain)id userID2;
@property(nonatomic, retain)id userID3;
@property(nonatomic, retain)id userID4;
@property(nonatomic, retain)id userID5;

@property(nonatomic, readwrite)BOOL userFlag;
@property(nonatomic, readwrite)BOOL userFlag2;
@property(nonatomic, readwrite)BOOL userFlag3;
@property(nonatomic, readwrite)BOOL userFlag4;
@property(nonatomic, readwrite)BOOL userFlag5;

@property(nonatomic, readwrite)BOOL canEdit;
@property(nonatomic, readwrite)UITableViewCellEditingStyle editingStyle;

@property(nonatomic, readwrite)BOOL hideBackgroundView;

@property(nonatomic, copy) NSIndexPath *indexPath;

@end
