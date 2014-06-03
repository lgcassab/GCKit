//
// Copyright (c) 2011 Five-technology Co.,Ltd.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>

#define FBENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define FBENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES256

@interface GCEncrypt : NSObject {
    
}

#pragma mark - MD5

+ (NSString*)encryptStringWithMD5:(NSString *)string;

#pragma mark - AES256

+ (NSData*)generateAES256Iv;
+ (NSData*)encryptAES256Data:(NSData*)data key:(NSData*)key iv:(NSData*)iv;
+ (NSData*)decryptAES256Data:(NSData*)data key:(NSData*)key iv:(NSData*)iv;

+ (NSString*)encryptAES256Base64String:(NSString*)string keyString:(NSString*)keyString separateLines:(BOOL)separateLines;
+ (NSString*)decryptAES256Base64String:(NSString*)encryptedBase64String keyString:(NSString*)keyString;

+ (NSString*)hexStringForData:(NSData*)data;
+ (NSData*)dataForHexString:(NSString*)hexString;


@end
