//
//  GCTableCellLabelHorizontal4Columns.m
//  GCKit
//
//  Created by Gustavo Cassab on 30/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCTableCellLabelHorizontal4Columns.h"

@interface GCTableCellLabelHorizontal4Columns (Private)
-(id)initWithColumn1Text:(NSString *)text1 column2Text:(NSString *)text2 column3Text:(NSString *)text3 column4Text:(NSString *)text4;
@end

@implementation GCTableCellLabelHorizontal4Columns
@synthesize column1Label, column2Label, column3Label, column4Label;
@synthesize column1Width, column2Width, column3Width, column4Width;

+(id)cellWithColumn1Text:(NSString *)text1 column2Text:(NSString *)text2 column3Text:(NSString *)text3 column4Text:(NSString *)text4 {
    return [[self alloc]initWithColumn1Text:text1 column2Text:text2 column3Text:text3 column4Text:text4];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		{
			UILabel *tmpLabel = [[UILabel alloc]init];
			[tmpLabel setBackgroundColor:[UIColor clearColor]];
			self.column1Label = tmpLabel;
			
			[self.contentView addSubview:column1Label];
		}
		
		{
			UILabel *tmpLabel = [[UILabel alloc]init];
			[tmpLabel setBackgroundColor:[UIColor clearColor]];
			self.column2Label = tmpLabel;
			
			[self.contentView addSubview:column2Label];
		}
		
		{
			UILabel *tmpLabel = [[UILabel alloc]init];
			[tmpLabel setBackgroundColor:[UIColor clearColor]];
			self.column3Label = tmpLabel;
			
			[self.contentView addSubview:column3Label];
		}
        
        {
			UILabel *tmpLabel = [[UILabel alloc]init];
			[tmpLabel setBackgroundColor:[UIColor clearColor]];
			self.column4Label = tmpLabel;
			
			[self.contentView addSubview:column4Label];
		}
		
		self.column1Width = 0;
		self.column2Width = 0;
		self.column3Width = 0;
        self.column4Width = 0;
    }
	
    return self;
}

-(id)initWithColumn1Text:(NSString *)text1 column2Text:(NSString *)text2 column3Text:(NSString *)text3 column4Text:(NSString *)text4 {
	
	if([self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil]) {
		[self.column1Label setText:text1];
		[self.column2Label setText:text2];
		[self.column3Label setText:text3];
        [self.column4Label setText:text4];
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGSize contentViewSize = self.contentView.bounds.size;
	CGFloat w = (contentViewSize.width / 4);
	CGFloat h = contentViewSize.height;
	
	if (column1Width == 0) column1Width = w;
	if (column2Width == 0) column2Width = w;
	if (column3Width == 0) column3Width = w;	
    if (column4Width == 0) column4Width = w;	
	
	[column1Label setFrame:CGRectMake(0, 0, column1Width, h)];
	[column2Label setFrame:CGRectMake( (column1Label.frame.origin.x + column1Label.frame.size.width), 0, column2Width, h)];
	[column3Label setFrame:CGRectMake( (column2Label.frame.origin.x + column2Label.frame.size.width), 0, column3Width, h)];
    [column4Label setFrame:CGRectMake( (column3Label.frame.origin.x + column3Label.frame.size.width), 0, column4Width, h)];
}

@end
