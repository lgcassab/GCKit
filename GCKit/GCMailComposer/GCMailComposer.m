//
//  GCMailComposer.m
//  GCKit
//
//  Created by Gustavo Cassab on 11/04/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "GCMailComposer.h"
#import "GCKit.h"

@interface GCMailComposer ( )

@property (nonatomic, strong) NSArray *to;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSArray *attachment;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, readwrite) BOOL bodyIsHtml;
@property (nonatomic, copy) GCMailComposerCompletionBlock completitionBlock;
@property (nonatomic, strong) MFMailComposeViewController *mailComposer;
@property (nonatomic, weak) UIViewController *viewController;
@end

@implementation GCMailComposer

+ (void)mailTo:(NSArray *)nTo completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    [GCMailComposer mailTo:nTo subject:nil body:nil bodyIsHtml:YES attachment:nil completitionBlock:nCompletitionBlock];
}

+ (void)mailTo:(NSArray *)nTo
	   subject:(NSString *)nSubject
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
	
    [GCMailComposer mailTo:nTo
				   subject:nSubject
					  body:nil
				bodyIsHtml:YES
				attachment:nil
		 completitionBlock:nCompletitionBlock];
}

+ (void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    [GCMailComposer mailTo:nTo
				   subject:nSubject
					  body:nil
				bodyIsHtml:YES
				attachment:nAttachment
		 completitionBlock:nCompletitionBlock];
}

+ (void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsText:(NSString *)nBodyText
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    [GCMailComposer mailTo:nTo
				   subject:nSubject
					  body:nBodyText
				bodyIsHtml:NO
				attachment:nil
		 completitionBlock:nCompletitionBlock];
}

+ (void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsText:(NSString *)nBodyText
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    [GCMailComposer mailTo:nTo
				   subject:nSubject
					  body:nBodyText
				bodyIsHtml:NO
				attachment:nAttachment
		 completitionBlock:nCompletitionBlock];
}

+ (void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsHtml:(NSString *)nBodyHtml
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    [GCMailComposer mailTo:nTo
				   subject:nSubject
					  body:nBodyHtml
				bodyIsHtml:YES
				attachment:nil
		 completitionBlock:nCompletitionBlock];
}

+ (void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
   bodyAsHtml:(NSString *)nBodyHtml
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    [GCMailComposer mailTo:nTo
				   subject:nSubject
					  body:nBodyHtml
				bodyIsHtml:YES
				attachment:nAttachment
		 completitionBlock:nCompletitionBlock];
}

#pragma mark - Private

+ (void)mailTo:(NSArray *)nTo
      subject:(NSString *)nSubject
         body:(NSString *)nBody
   bodyIsHtml:(BOOL)nBodyIsHtml
   attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {
    
    GCMailComposer *mailComposer = [[GCMailComposer alloc] initWithTo:nTo
                                                              subject:nSubject
                                                                 body:nBody
                                                           bodyIsHtml:nBodyIsHtml
                                                           attachment:nAttachment
                                                    completitionBlock:nCompletitionBlock];
    [[GCKit sharedKit] setGcMailComposer:mailComposer];
    [mailComposer presentModalController];
}

#pragma mark - Class Methods

- (id)initWithTo:(NSArray *)nTo
        subject:(NSString *)nSubject
           body:(NSString *)nBody
     bodyIsHtml:(BOOL)nBodyIsHtml
     attachment:(NSArray *)nAttachment
completitionBlock:(GCMailComposerCompletionBlock)nCompletitionBlock {

    if ((self = [super init])) {
        
        _to = nTo;
        _subject = nSubject;
        _body = nBody;
        _bodyIsHtml = nBodyIsHtml;
        _attachment = nAttachment;
        _completitionBlock = nCompletitionBlock;
        
        _mailComposer = [MFMailComposeViewController new];
        [_mailComposer setMailComposeDelegate:self];
        [_mailComposer setModalPresentationStyle:UIModalPresentationPageSheet];
        
        if (_to) {
            if ([_to count] > 0) {
                [_mailComposer setToRecipients:_to];
            }
        }
        
        if (_subject) {
            [_mailComposer setSubject:_subject];
        }

        if (_body) {
            [_mailComposer setMessageBody:_body isHTML:_bodyIsHtml];
        }
        
        if (_attachment) {
            if ([_attachment count] > 0) {
                for (NSDictionary *fileDictionary in _attachment) {
                    [self addAttachment:fileDictionary];
                }
            }
        }
    
    }

    return self;
}

- (void)presentModalController {
    
    if (![MFMailComposeViewController canSendMail]) {
        if (_completitionBlock) {
            NSError *error = [NSError errorWithDomain:@"GCMailComposer"
                                                 code:MFMailComposeResultFailed
                                             userInfo:@{ NSLocalizedDescriptionKey : @"Não existe uma conta de email configurada neste dispositivo." }];
            _completitionBlock(MFMailComposeResultFailed, error);
            [[GCKit sharedKit] setGcMailComposer:nil];
            return;
        }
    }

    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UIViewController *topController = [window rootViewController];
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)topController;
        _viewController = navController.visibleViewController;
    } else if ([topController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBar = (UITabBarController *)topController;
        _viewController = tabBar.selectedViewController;
    } else {
        _viewController = topController;
    }
    
    [_viewController presentViewController:_mailComposer animated:YES completion:^{}];
}

#pragma mark - Public Methods

+ (NSDictionary *)imageName:(NSString *)nImageName png:(UIImage *)nImage {
    
    NSData *imageData = UIImagePNGRepresentation(nImage);
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:nImageName forKey:@"fileName"];
    [dictionary setObject:@"png"     forKey:@"fileType"];
    [dictionary setObject:imageData  forKey:@"fileData"];
    
    return dictionary;
}

+ (NSDictionary *)imageName:(NSString *)nImageName jpg:(UIImage *)nImage {
    
    NSData *imageData = UIImageJPEGRepresentation(nImage, 1.0);
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:nImageName forKey:@"fileName"];
    [dictionary setObject:@"jpg"     forKey:@"fileType"];
    [dictionary setObject:imageData  forKey:@"fileData"];
    
    return dictionary;
}

+ (NSDictionary *)imageName:(NSString *)nImageName jpeg:(UIImage *)nImage {

    NSData *imageData = UIImageJPEGRepresentation(nImage, 1.0);
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:nImageName forKey:@"fileName"];
    [dictionary setObject:@"jpeg"    forKey:@"fileType"];
    [dictionary setObject:imageData  forKey:@"fileData"];
    
    return dictionary;
}

#pragma mark - Private Methods

- (NSDictionary *)mimeTypeDictionary {
    
	NSMutableDictionary *mimeDictionary = [NSMutableDictionary new];
	[mimeDictionary setObject: @"image/jpeg"        forKey: @"jpg"];
	[mimeDictionary setObject: @"image/jpeg"        forKey: @"jpeg"];
	[mimeDictionary setObject: @"image/png"         forKey: @"png"];
    
//	[mimeDictionary setObject: @"image/gif"         forKey: @"gif"];    
//	[mimeDictionary setObject: @"application/pdf"   forKey: @"pdf"];
    
    return (NSDictionary *)mimeDictionary;
}

- (void)addAttachment:(NSDictionary *)fileDictionary {
    
    NSString *fileType = [fileDictionary objectForKey:@"fileType"];
    NSString *fileName = [fileDictionary objectForKey:@"fileName"];
    NSData *fileData   = [fileDictionary objectForKey:@"fileData"];
    
    [_mailComposer addAttachmentData:fileData
                            mimeType:[[self mimeTypeDictionary] objectForKey:fileType]
                            fileName:fileName];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    if (_completitionBlock)
        _completitionBlock(result, error);
    
    if (_viewController) {
        [_viewController dismissViewControllerAnimated:YES completion:^{
            _viewController = nil;
        }];
    }
    
    [[GCKit sharedKit] setGcMailComposer:nil];
}

@end
