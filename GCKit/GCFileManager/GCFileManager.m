//
//  GCFileManager.m
//  GCKit
//
//  Created by Gustavo Cassab on 10/09/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import "GCFileManager.h"

@implementation GCFileManager

+ (BOOL)fileOrDirectoryExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError **)error {
    return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:error];
}

+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] copyItemAtPath:atPath toPath:toPath error:error];
}

+ (BOOL)removeFileAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}

+ (NSString *)convertBytes:(unsigned long long)size {
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] moveItemAtPath:atPath toPath:toPath error:error];
}

@end
