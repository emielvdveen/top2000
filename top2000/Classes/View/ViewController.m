//
//  ViewController.m
//  top2000_ipad
//
//  Created by Emiel van der Veen on 23-08-12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "ViewController.h"
#import "DataController.h"
#import "GameController.h"
#import "MainViewController.h"

@implementation ViewController
{
    MainViewController *_mainVC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[DataController sharedInstance] performSelectorInBackground:@selector(loadAll) withObject:nil];
    [[DataController sharedInstance] loadAll];
//    [[GameController sharedInstance] startGame:100];
//    while ([[GameController sharedInstance] hasNextRound])
//    {
//        [[GameController sharedInstance] nextRound];
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction) startGame;
{
    [[GameController sharedInstance] startGame:25];

    _mainVC = [[MainViewController alloc] initWithNibName:(IPAD ? @"MainView~ipad" : @"MainView~iphone") bundle:nil];
    [self presentModalViewController:_mainVC animated:YES];
}

@end
