//
//  MainViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "MainViewController.h"
#import "GameController.h"
#import "PopQuizVraag.h"
#import "Hint.h"
#import "Hoes.h"
#import "HitFragment.h"
#import "QuestionsViewController.h"
#import "PopQuizViewController.h"
#import "HintsViewController.h"
#import "CoverViewController.h"
#import "HitFragmentViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    QuestionsViewController *_doorvraagVC;
    PopQuizViewController *_popQuizVC;
    HintsViewController *_hintsVC;
    CoverViewController *_coverVC;
    HitFragmentViewController *_hitFragmentVC;

    UIView *_currentView;
    UIView* _newView;
}

@synthesize content = _content;


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

    if ([[GameController sharedInstance] hasNextRound])
    {
        [self showNextRound];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

- (void) showNextRound;
{
    id vraag = [[GameController sharedInstance] nextRound];

    if ([vraag isKindOfClass:[NSArray class]])
    {
        // Doorvraag
        _doorvraagVC = [[QuestionsViewController alloc] initWithNibName:@"QuestionsView~ipad" bundle:nil];
        _newView = _doorvraagVC.view;
    }
    else
    if ([vraag isKindOfClass:[PopQuizVraag class]])
    {
        _popQuizVC = [[PopQuizViewController alloc] initWithNibName:@"PopQuizView~ipad" bundle:nil];
        _popQuizVC.vraag = vraag;
        _newView = _popQuizVC.view;
    }
    if ([vraag isKindOfClass:[Hint class]])
    {
        _hintsVC = [[HintsViewController alloc] initWithNibName:@"HintsView~ipad" bundle:nil];
        _hintsVC.hint = vraag;
        _newView = _hintsVC.view;
    }
    if ([vraag isKindOfClass:[Hoes class]])
    {
        _coverVC = [[CoverViewController alloc] initWithNibName:@"CoverView" bundle:nil];
        _newView = _coverVC.view;
    }
    if ([vraag isKindOfClass:[HitFragment class]])
    {
        _hitFragmentVC = [[HitFragmentViewController alloc] initWithNibName:@"HitFragmentView~ipad" bundle:nil];
        _newView = _hitFragmentVC.view;
    }

    [self showNewView];
}

- (void) showNewView;
{
    _newView.alpha = 0;
    [_content addSubview:_newView];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        _currentView.alpha = 0;
        _newView.alpha = 1;
    } completion:^(BOOL finished) {
        [_currentView removeFromSuperview];
        _currentView = _newView;
        _newView = nil;
    }];
}

#pragma mark - Button clicks

- (IBAction) stopBtnClicked;
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) nextBtnClicked;
{
    if ([[GameController sharedInstance] hasNextRound])
    {
        [self showNextRound];
    }
    else
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
