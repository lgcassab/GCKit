//
//  GCPickerComponentRow.h
//  GCKit
//
//  Created by Gustavo Cassab on 22/01/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//



@interface GCPickerComponentRow : NSObject {
	NSString *title;
	NSInteger tag;
    
    id userObject;
    id userObject2;
    id userObject3;
    id userObject4;
    id userObject5;
}
@property(nonatomic, retain)NSString *title;
@property(nonatomic, readwrite)NSInteger tag;

@property(nonatomic, retain)id userObject;
@property(nonatomic, retain)id userObject2;
@property(nonatomic, retain)id userObject3;
@property(nonatomic, retain)id userObject4;
@property(nonatomic, retain)id userObject5;

+(id)componentWithTitle:(NSString *)_title;
+(id)componentWithTitle:(NSString *)_title userObject:(id)userObject;
+(id)componentWithTitle:(NSString *)_title tag:(NSInteger)_tag;
+(id)componentWithTitle:(NSString *)_title tag:(NSInteger)_tag userObject:(id)userObject;

-(id)initWithTitle:(NSString *)_title tag:(NSInteger)_tag;

@end
