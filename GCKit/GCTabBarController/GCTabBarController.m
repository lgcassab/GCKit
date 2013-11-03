//
//  GCTabBarController.m
//  GCKit
//
//  Created by Marcelo Queiroz on 25/08/2011
//  Copyright 2011 FingerTips. All rights reserved.
//
//  Func.: Classe responsavel por apresentar customizar a UITabBar de um UITabBarController
//  ----- Alter History -----
//  Autor - Alter Date (dd/MM/yy) - Log
//

#import "GCTabBarController.h"

/**************************************************************************\
 * Func.: Metodos privados
 \**************************************************************************/
@interface GCTabBarController (PrivateMethods)
- (void) customizeTabBar;
@end

@implementation GCTabBarController

@synthesize dataSource = _dataSource;

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        //Initialize TabBar Background
        _backgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
        _backgroudView.backgroundColor = [UIColor clearColor];
        _backgroudView.userInteractionEnabled = NO;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self customizeTabBar];
    [self selectTabBarItemAtIndex:self.selectedIndex];
}

#pragma mark - Public Methods

- (void) selectTabBarItemAtIndex: (int)tabBarItemIndex {
    BOOL shouldSelect = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        shouldSelect = [self.delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:tabBarItemIndex]];
    }
    
    if (shouldSelect) {
        // Select the tab button
        for (UIButton *tabButton in _tabBarButtons) {
            if (tabButton.tag == tabBarItemIndex) {
                [tabButton setSelected:YES];
            } else {
                [tabButton setSelected:NO];
            }
        }
    
        if (self.selectedIndex == tabBarItemIndex) {
            UINavigationController *navController = (UINavigationController *)[self selectedViewController];
            [navController popToRootViewControllerAnimated:YES];
        } else {
            self.selectedIndex = tabBarItemIndex;
        }
    }
}

- (void)buttonClicked:(UIButton *)sender {
    [self selectTabBarItemAtIndex:[sender tag]];
}

#pragma mark - PrivateMethods

/**************************************************************************\
 * Func.: Customiza a tab bar recuperando informações do data source.
 * In: N/A
 * Out: Texto do cancel conforme idioma
 \**************************************************************************/
- (void) customizeTabBar {
    if (_dataSource) {
        // Check for customized background color
        if ([_dataSource respondsToSelector:@selector(gcTabBarControllerBackgroundColor:)]) {
            _backgroudView.backgroundColor = [_dataSource gcTabBarControllerBackgroundColor:self];
        }
        
        // Check for customized background image
        if ([_dataSource respondsToSelector:@selector(gcTabBarControllerBackgroundImage:)]) {
            UIImageView *backgroundImage = [[UIImageView alloc] initWithImage: [_dataSource gcTabBarControllerBackgroundImage:self] ];
            [_backgroudView addSubview:backgroundImage];
        }
    }
    
    // Adds the backgroundView
    [self.tabBar addSubview:_backgroudView];
    
    // Populate the custom tabBar buttons
    if (_dataSource) {
        _tabBarButtons = [[NSMutableArray alloc] init];
        
        // Retrieve the number of tab bar itens
        NSInteger numberOfItens = [_dataSource gcTabBarControllerNumberOfTabBarItens:self];
        
        // Calculate the button width;
        CGFloat buttonsWidth = 320.0 / numberOfItens;
        
        // Ask for the data source for the buttons
        for (int i = 0; i < numberOfItens; i++) {
            UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [tabButton setBackgroundColor: [UIColor clearColor]];
            
            // Set the button size
            CGRect frm;
            frm.size = [_dataSource gcTabBarController:self sizeForButtonAtIndex:i];
            tabButton.frame = frm;
            
            
            // Set the button images
            [tabButton setImage: [_dataSource gcTabBarController:self normalImageAtIndex:i]    forState:UIControlStateNormal];
            [tabButton setImage: [_dataSource gcTabBarController:self selectedImageAtIndex:i]  forState:UIControlStateSelected];
            
            // Update button frame
            CGRect buttonFrame = tabButton.frame;
            buttonFrame.origin = CGPointMake(i * buttonsWidth , 0);
            buttonFrame.size.width = buttonsWidth;
            tabButton.frame = buttonFrame;
            
            tabButton.contentMode = UIViewContentModeCenter;
            
            // Set button tag
            tabButton.tag = i;
            
            // Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
            [tabButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // Add button to arrat
            [_tabBarButtons addObject:tabButton];
            
            // Add button to view
            [self.tabBar addSubview:tabButton];   
        } }
        
        // Select the first button
        [[_tabBarButtons objectAtIndex:0] setSelected:YES];
}

@end