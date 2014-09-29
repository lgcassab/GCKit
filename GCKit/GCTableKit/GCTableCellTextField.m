//
//  GCTableCellTextField.m
//  GCKit
//
//  Created by Gustavo Cassab on 16/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCellTextField.h"
#import "GCTableController.h"

@interface GCTableCellTextField (Private)
@end

@implementation GCTableCellTextField
@synthesize textField;

+(id)cellWithText:(NSString *)text {
    return [[self alloc]initWithText:text dictionaryKey:nil textFieldValue:nil placeholder:nil];
}

+(id)cellWithText:(NSString *)text textFieldValue:(NSString *)textFieldValue {
    return [[self alloc]initWithText:text dictionaryKey:nil textFieldValue:textFieldValue placeholder:nil];
}

+(id)cellWithText:(NSString *)text textFieldValue:(NSString *)textFieldValue placeholder:(NSString *)placeholder {
    return [[self alloc]initWithText:text dictionaryKey:nil textFieldValue:textFieldValue placeholder:placeholder];
}

+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey {
    return [[self alloc]initWithText:text dictionaryKey:dictKey textFieldValue:nil placeholder:nil];
}

+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey textFieldValue:(NSString *)textFieldValue {
    return [[self alloc]initWithText:text dictionaryKey:dictKey textFieldValue:textFieldValue placeholder:nil];
}

+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey textFieldValue:(NSString *)textFieldValue placeholder:(NSString *)placeholder {
    return [[self alloc]initWithText:text dictionaryKey:dictKey textFieldValue:textFieldValue placeholder:placeholder];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) 	{
	}
	return self;
}

- (id)initWithText:(NSString *)cellText dictionaryKey:(NSString *)dictKey textFieldValue:(NSString *)textFieldValue placeholder:(NSString *)placeholder {
    
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil])) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		lockCellSelection = YES;
		
		{
			UITextField *tmpTextField = [[UITextField alloc]init];
			[tmpTextField setDelegate:self];
			[tmpTextField addTarget:self action:@selector(textFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
			[tmpTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
			[tmpTextField setTextColor:[UIColor colorWithRed:50.0f/255 green:79.0f/255 blue:133.0f/255 alpha:1]];
			[tmpTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
			[tmpTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
			[tmpTextField setReturnKeyType:UIReturnKeyDone];
			self.textField = tmpTextField;
		}
		
		[self.contentView addSubview:textField];
		
        [self.textLabel setText:cellText];
		
        [textField setText:textFieldValue];
        [textField setPlaceholder:placeholder];
        
        self.dictionaryKey = dictKey;
        
    }
    
    return self;
}

- (BOOL)becomeFirstResponder {
	return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
	return [self.textField resignFirstResponder];
}

- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	self.textField.backgroundColor = color;
}

- (void)layoutSubviews {
    
    if (dictionaryKey != nil) {
        [self.tableController setValue:[self.textField text] toInternalDictionaryKey:dictionaryKey];
    }
    
	[super layoutSubviews];
    
    { 
        CGRect textLabelFrame = self.textLabel.frame;
        
        // Modify the textLabel frame to take only it's text width instead of the full cell width
        CGSize constraintSize = CGSizeMake(200, MAXFLOAT);
		
		#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
		textLabelFrame.size.width = [self.textLabel.text boundingRectWithSize:constraintSize
																	  options:NSStringDrawingUsesLineFragmentOrigin
																   attributes:@{NSFontAttributeName:self.textLabel.font}
																	  context:nil].size.width;
		#else
		textLabelFrame.size.width = [self.textLabel.text sizeWithFont:self.textLabel.font
													constrainedToSize:constraintSize
														lineBreakMode:self.textLabel.lineBreakMode].width;
		#endif
		
        self.textLabel.frame = textLabelFrame;
		
        // Layout the control next to self.textLabel, with it's same yCoord & height
        CGFloat indentation = 10;
        if(textLabelFrame.size.width == 0)
            indentation = 0;
        CGSize contentViewSize = self.contentView.bounds.size;
        CGFloat controlXCoord = textLabelFrame.origin.x+textLabelFrame.size.width + 10;
        if(controlXCoord < indentation)
            controlXCoord = indentation;
        CGRect controlFrame = CGRectMake(controlXCoord, 
                                         textLabelFrame.origin.y, 
                                         contentViewSize.width - controlXCoord - 10, 
                                         textLabelFrame.size.height);
        self.textField.frame = controlFrame;
    }
	
	CGRect textFieldFrame = self.textField.frame;
	textFieldFrame.origin.y = (self.contentView.frame.size.height - 31)/2;
	textFieldFrame.size.height = 31;
	self.textField.frame = textFieldFrame;
    
    [self.detailTextLabel setHidden:YES];
    [self.contentView bringSubviewToFront:self.textField];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)_textField {
    [self.tableController textFieldWillBecomeFirstResponder:_textField cell:self indexPath:self.indexPath];
	[self.tableController.tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
	return YES;
}

-(void)textFieldEditingChanged {
	
    if (dictionaryKey != nil) {
        [self.tableController.dictionaryKeyValues setValue:[textField text] forKey:dictionaryKey];
    }
    
    NSIndexPath *ip = [self.tableController indexPathForCell:self];
    if ([self.tableController respondsToSelector:@selector(valueChangedForCell:indexPath:object:)]) {
        [self.tableController valueChangedForCell:self indexPath:ip object:textField];    
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)_textField {
    [_textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)_textField {
    [self.tableController textFieldWillResignFirstResponder:_textField cell:self indexPath:self.indexPath];
    return YES;
}

- (BOOL) textField:(UITextField *)_textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self.tableController textField:_textField cell:self indexPath:self.indexPath shouldChangeCharactersInRange:range replacementString:string];
}

@end
