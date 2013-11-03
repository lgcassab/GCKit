//
//  GCTableCellLabelHorizontal6Columns.h
//  GCKit
//
//  Created by Gustavo Cassab on 30/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableCell.h"

@interface GCTableCellLabelHorizontal6Columns : GCTableCell {
	UILabel *column1Label;
	UILabel *column2Label;
	UILabel *column3Label;
    UILabel *column4Label;
    UILabel *column5Label;
    UILabel *column6Label;
	
	CGFloat column1Width;
	CGFloat column2Width;
	CGFloat column3Width;
    CGFloat column4Width;
    CGFloat column5Width;
    CGFloat column6Width;
}
@property(nonatomic, retain)UILabel *column1Label;
@property(nonatomic, retain)UILabel *column2Label;
@property(nonatomic, retain)UILabel *column3Label;
@property(nonatomic, retain)UILabel *column4Label;
@property(nonatomic, retain)UILabel *column5Label;
@property(nonatomic, retain)UILabel *column6Label;

@property(nonatomic, readwrite)CGFloat column1Width;
@property(nonatomic, readwrite)CGFloat column2Width;
@property(nonatomic, readwrite)CGFloat column3Width;
@property(nonatomic, readwrite)CGFloat column4Width;
@property(nonatomic, readwrite)CGFloat column5Width;
@property(nonatomic, readwrite)CGFloat column6Width;

+(id)cellWithColumn1Text:(NSString *)text1 column2Text:(NSString *)text2 column3Text:(NSString *)text3 column4Text:(NSString *)text4 column5Text:(NSString *)text5 column6Text:(NSString *)text6;

@end
