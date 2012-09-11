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
#import "Hoes.h"
#import "PictureViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController ()

@end

@implementation MainViewController
{
    QuestionsViewController *_doorvraagVC;
    PopQuizViewController *_popQuizVC;
    HintsViewController *_hintsVC;
    CoverViewController *_coverVC;
    PictureViewController* _pictureVC;
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

- (void) enableSpeaker;
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self enableSpeaker];
    
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
    else if ([vraag isKindOfClass:[PopQuizVraag class]])
    {
        _popQuizVC = [[PopQuizViewController alloc] initWithNibName:@"PopQuizView~ipad" bundle:nil];
        _popQuizVC.vraag = vraag;
        _newView = _popQuizVC.view;
    }
    else if ([vraag isKindOfClass:[Hint class]])
    {
        _hintsVC = [[HintsViewController alloc] initWithNibName:@"HintsView~ipad" bundle:nil];
        _hintsVC.hint = vraag;
        _newView = _hintsVC.view;
    }
    else if ([vraag isKindOfClass:[HitFragment class]])
    {
        _hitFragmentVC = [[HitFragmentViewController alloc] initWithNibName:@"HitFragmentView~ipad" bundle:nil];
        _hitFragmentVC.hitFragment = vraag;
        _newView = _hitFragmentVC.view;
    }
    else if ([vraag isKindOfClass:[Hoes class]])
    {
        _coverVC = [[CoverViewController alloc] initWithNibName:@"CoverView~ipad" bundle:nil];
        _coverVC.hoes = vraag;
        _newView = _coverVC.view;
    }
    else if ([vraag isKindOfClass:[Hoes class]])
    {
        _pictureVC = [[PictureViewController alloc] initWithNibName:@"PictureView~ipad" bundle:nil];
        _newView = _pictureVC.view;
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
    if (_hitFragmentVC)
    {
        [_hitFragmentVC stopPlayback];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) nextBtnClicked;
{
    if (_hitFragmentVC)
    {
        [_hitFragmentVC stopPlayback];
    }
    
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
