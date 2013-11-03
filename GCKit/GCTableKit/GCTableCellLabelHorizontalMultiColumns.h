//
//  GCTableCellLabelHorizontalMultiColumns.h
//  GCKit
//
//  Created by Gustavo Cassab on 30/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GCTableCell.h"

@interface GCTableCellLabelHorizontalMultiColumns : GCTableCell {
    NSMutableArray *arrayLabels;
}
@property(nonatomic, retain)NSMutableArray *arrayLabels;

+(id)cell;

-(void)addColumnWithText:(NSString *)text labelWidth:(NSUInteger)w;
-(void)addColumnWithText:(NSString *)text labelWidth:(NSUInteger)w labelBackgroundColor:(UIColor *)backColor labelTextColor:(UIColor *)tColor textAligment:(UITextAlignment)tAligment;
-(UILabel *)labelInColumn:(NSUInteger)column;

-(NSArray *)labels;

@end
