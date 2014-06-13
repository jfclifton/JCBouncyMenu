//
//  JCViewController.m
//  JCBouncyMenu
//
//  Created by JFClifton on 5/30/14.
//  Copyright (c) 2014 Jordan Clifton. All rights reserved.
//

#import "JCViewController.h"
#import "JCBouncyMenu.h"

@interface JCViewController () <JCBouncyMenuDelegate>

@end

@implementation JCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *buttonImages = [NSArray arrayWithObjects:@"1.png", @"2.png", @"3.png", @"4.png", @"arrow.png", nil];
    
    // Add the menu
    JCBouncyMenu *menu = [[JCBouncyMenu alloc] initOriginPoint:CGPointMake(50, 50) andButtonImages:buttonImages];
    menu.delegate = self;
    [self.view addSubview:menu];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JCBouncyMenu Delegate Methods

- (void)bouncyMenu:(JCBouncyMenu *)menu didSelectButton:(UIButton *)button
{
    NSLog(@"tag of button: %d", button.tag);
}

- (void)bouncyMenuDidOpen:(JCBouncyMenu *)menu
{
    NSLog(@"Menu Open");
}

- (void)bouncyMenuDidClose:(JCBouncyMenu *)menu
{
    NSLog(@"Menu Closed");
}

@end
