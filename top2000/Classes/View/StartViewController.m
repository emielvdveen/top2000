//
//  StartViewControllerViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "StartViewController.h"
#import "MainViewController.h"
#import "GameController.h"
#import "DataController.h"

@interface StartViewController()

@end

@implementation StartViewController
{
    MainViewController *_mainVC;    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DataController sharedInstance] loadAll];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (IPAD)
    {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
    else {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }
}

- (IBAction) startGame;
{
    [[GameController sharedInstance] startGame:25];
    
    _mainVC = [[MainViewController alloc] initWithNibName:(IPAD ? @"MainView~ipad" : @"MainView~iphone") bundle:nil];
    [self presentModalViewController:_mainVC animated:YES];
}


@end
