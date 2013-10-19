//
//  GCMailComposer.h
//  GCKit
//
//  Created by Gustavo Cassab on 11/04/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

typedef void (^GCMailComposerCompletionBlock)(MFMailComposeResult result, NSError *error);

@interface GCMailComposer : NSObject <MFMailComposeViewControllerDelegate> {
    
}

+(void)mailTo:(NSArray *)nTo completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;
+(void)mailTo:(NSArray *)nTo subject:(NSString *)nSubject completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;

+(void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;

+(void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsText:(NSString *)nBodyText
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;

+(void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsText:(NSString *)nBodyText
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;

+(void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsHtml:(NSString *)nBodyHtml
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;

+(void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsHtml:(NSString *)nBodyHtml
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock;

#pragma mark - Public Methods

+(NSDictionary *)imageName:(NSString *)nImageName png:(UIImage *)nImage;
+(NSDictionary *)imageName:(NSString *)nImageName jpg:(UIImage *)nImage;
+(NSDictionary *)imageName:(NSString *)nImageName jpeg:(UIImage *)nImage;

@end
