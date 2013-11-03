//
//  UITableViewAlertViewTableViewCell.m
//  GCKit
//
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.

#import "GCAlertTableViewCell.h"

@implementation GCAlertTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
       _topSeperatorView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _topSeperatorView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
        [self.backgroundView addSubview:_topSeperatorView];
        
        
        _bottomSeperatorView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _bottomSeperatorView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
        [self.backgroundView addSubview:_bottomSeperatorView];
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
	}
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
    static CGFloat seperatorHeight = 1.0f;
    _topSeperatorView.frame = CGRectMake(0.0f, -seperatorHeight/2.0f, CGRectGetWidth(self.backgroundView.bounds), seperatorHeight);
    _bottomSeperatorView.frame = CGRectMake(0.0f, CGRectGetHeight(self.backgroundView.bounds) - seperatorHeight/2.0f, CGRectGetWidth(self.backgroundView.bounds), seperatorHeight);
    
    self.imageView.frame = CGRectInset(self.imageView.frame, 4.0f, 4.0f);
}

@end
