//
//  GCTableCellSwitch.m
//  GCKit
//
//  Created by Gustavo Cassab on 15/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCellSwitch.h"
#import "GCTableController.h"

@interface GCTableCellSwitch (Private)
- (void)switchControlChanged;
@end

@implementation GCTableCellSwitch
@synthesize switchControl;

+ (id)cellWithText:(NSString *)text {
    return [[self alloc]initWithText:text dictionaryKey:nil switchIsOn:NO];
}

+ (id)cellWithText:(NSString *)text switchIsOn:(BOOL)switchIsOn {
    return [[self alloc]initWithText:text dictionaryKey:nil switchIsOn:switchIsOn];
}

+ (id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey {
    return [[self alloc]initWithText:text dictionaryKey:dictKey switchIsOn:NO];
}

+ (id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey switchIsOn:(BOOL)switchIsOn {
    return [[self alloc]initWithText:text dictionaryKey:dictKey switchIsOn:switchIsOn];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if( (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) ) 	{
	}
	return self;
}

- (id)initWithText:(NSString *)cellText dictionaryKey:(NSString *)dictKey switchIsOn:(BOOL)switchIsOn {
    
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (self) {
		
		{
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			lockCellSelection = YES;
			
			{
				UISwitch *tmpSwitch = [[UISwitch alloc] init];
				[tmpSwitch addTarget:self action:@selector(switchControlChanged) forControlEvents:UIControlEventValueChanged];
				self.switchControl = tmpSwitch;
			}
			
//			[self.contentView addSubview:switchControl];
			[self setAccessoryView:switchControl];
		}
        
        [self.textLabel setText:cellText];
        
        self.dictionaryKey = dictKey;        
        [self.switchControl setOn:switchIsOn];
        if (dictionaryKey != nil) {
            [self.tableController.dictionaryKeyValues setValue:[NSNumber numberWithBool:switchIsOn] forKey:dictionaryKey];
        }
    }
    
    return self;
}

//- (void)layoutSubviews {
//    
//	[super layoutSubviews];
//	
//	CGSize contentViewSize = self.contentView.bounds.size;
//	CGRect switchFrame = self.switchControl.frame;
//	switchFrame.origin.x = contentViewSize.width - switchFrame.size.width - 10;
//	switchFrame.origin.y = (contentViewSize.height-switchFrame.size.height)/2;
//	self.switchControl.frame = switchFrame;
//    
//    [self.detailTextLabel setHidden:YES];
//    [self.contentView bringSubviewToFront:self.switchControl];
//}

- (void)switchControlChanged {
    
    if (dictionaryKey != nil) {
        [self.tableController.dictionaryKeyValues setValue:[NSNumber numberWithBool:[switchControl isOn]] forKey:dictionaryKey];
    }
    
    NSIndexPath *ip = [self.tableController indexPathForCell:self];
    if ([self.tableController respondsToSelector:@selector(valueChangedForCell:indexPath:object:)]) {
        [self.tableController valueChangedForCell:self indexPath:ip object:switchControl];    
    }
}

@end
