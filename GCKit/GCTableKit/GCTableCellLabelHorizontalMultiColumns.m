//
//  GCTableCellLabelHorizontalMultiColumns.m
//  GCKit
//
//  Created by Gustavo Cassab on 30/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCTableCellLabelHorizontalMultiColumns.h"

@interface GCTableCellLabelHorizontalMultiColumns (Private)
-(id)init;
@end

@implementation GCTableCellLabelHorizontalMultiColumns
@synthesize arrayLabels;

+(id)cell {
    return [[self alloc]init];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
	
    return self;
}

-(id)init {
	
	if([self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil]) {
        
        NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
        self.arrayLabels = tmpArray;
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
	[super layoutSubviews];

}

-(UILabel *)labelInColumn:(NSUInteger)column {
    if (column > 0) column--;
    return [arrayLabels objectAtIndex:column];
}

-(void)addColumnWithText:(NSString *)text labelWidth:(NSUInteger)w {
    [self addColumnWithText:text 
                 labelWidth:w 
       labelBackgroundColor:[UIColor clearColor] 
             labelTextColor:[UIColor blackColor]
               textAligment:NSTextAlignmentLeft];
}

-(void)addColumnWithText:(NSString *)text labelWidth:(NSUInteger)w labelBackgroundColor:(UIColor *)backColor labelTextColor:(UIColor *)tColor textAligment:(NSTextAlignment)tAligment {

    CGSize contentViewSize = self.contentView.bounds.size;
    CGFloat h = contentViewSize.height;
    UILabel *lastLabel = [arrayLabels lastObject];
    CGFloat newLeft = 0;
    
    if (lastLabel != nil) {
        newLeft = (lastLabel.frame.origin.x + lastLabel.frame.size.width);
    }
    
    UILabel *tmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(newLeft, 0, w, h)];
    [tmpLabel setTag:([arrayLabels count] +1)];
    [tmpLabel setBackgroundColor:backColor];
    [tmpLabel setTextColor:tColor];
    [tmpLabel setTextAlignment:tAligment];
    [tmpLabel setText:text];
    
    [self.contentView addSubview:tmpLabel];
    
    [arrayLabels addObject:tmpLabel];
}

-(NSArray *)labels {
    return arrayLabels;
}

@end
