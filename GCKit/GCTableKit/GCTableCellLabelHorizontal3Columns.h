//
//  GCTableCellLabelHorizontal3Fields.h
//  GCKit
//
//  Created by Gustavo Cassab on 15/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "GCTableCell.h"

@interface GCTableCellLabelHorizontal3Columns : GCTableCell {
	UILabel *column1Label;
	UILabel *column2Label;
	UILabel *column3Label;
	
	CGFloat column1Width;
	CGFloat column2Width;
	CGFloat column3Width;
}
@property(nonatomic, retain)UILabel *column1Label;
@property(nonatomic, retain)UILabel *column2Label;
@property(nonatomic, retain)UILabel *column3Label;

@property(nonatomic, readwrite)CGFloat column1Width;
@property(nonatomic, readwrite)CGFloat column2Width;
@property(nonatomic, readwrite)CGFloat column3Width;

+(id)cellWithColumn1Text:(NSString *)text1 column2Text:(NSString *)text2 column3Text:(NSString *)text3;

@end
