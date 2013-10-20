//
//  GCBlockAdditions.h
//  GCKit
//
//  Created by Gustavo Cassab on 24/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

typedef void (^GCVoidBlock)();

typedef void (^GCDismissBlock)(int buttonIndex);
typedef void (^GCCancelBlock)();
typedef void (^GCPhotoPickedBlock)(UIImage *chosenImage);
typedef void (^GCCompletion)();

#define kPhotoActionSheetTag 10000
