//
//  GCTableCellSegmentedControl.h
//  GCKit
//
//  Created by Gustavo Cassab on 14/05/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCell.h"
#import "GCTableCell.h"

@interface GCTableCellSegmentedControl : GCTableCell {
    UISegmentedControl *segmentedControl;
}
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

+(id)cellWithItems:(NSArray *)items dictionaryKey:(NSString *)dictKey;
+(id)cellWithItems:(NSArray *)items dictionaryKey:(NSString *)dictKey defaultItem:(NSUInteger )defaultItem;

@end
