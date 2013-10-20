//
//  GCFileManager.h
//  GCKit
//
//  Created by Gustavo Cassab on 10/09/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCFileManager : NSObject {
    
}

+ (BOOL)fileOrDirectoryExistsAtPath:(NSString *)path;
+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath error:(NSError **)error;
+ (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError **)error;
+ (BOOL)removeFileAtPath:(NSString *)path error:(NSError **)error;
+ (NSString *)convertBytes:(unsigned long long)size;
+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath error:(NSError *__autoreleasing *)error;

@end
