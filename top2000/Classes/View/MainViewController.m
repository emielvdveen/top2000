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
#import "Foto.h"
#import "PictureViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController ()
- (void) showNextRound;
- (void) showNewView;
@end

@implementation MainViewController
{
    QuestionsViewController *_doorvraagVC;
    PopQuizViewController *_popQuizVC;
    HintsViewController *_hintsVC;
    CoverViewController *_coverVC;
    PictureViewController* _pictureVC;
    HitFragmentViewController *_hitFragmentVC;

    UIViewController *_currentVC;
    UIViewController * _newVC;
    BOOL _showNewView;
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
    _showNewView = YES;
    
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
        _doorvraagVC = [[QuestionsViewController alloc] initWithNibName:@"QuestionsView~ipad" bundle:nil];
        _doorvraagVC.doorvragen = vraag;
        _newVC = _doorvraagVC;
    }
    else if ([vraag isKindOfClass:[PopQuizVraag class]])
    {
        _popQuizVC = [[PopQuizViewController alloc] initWithNibName:@"PopQuizView~ipad" bundle:nil];
        _popQuizVC.vraag = vraag;
        _newVC = _popQuizVC;
    }
    else if ([vraag isKindOfClass:[Hint class]])
    {
        _hintsVC = [[HintsViewController alloc] initWithNibName:@"HintsView~ipad" bundle:nil];
        _hintsVC.hint = vraag;
        _newVC = _hintsVC;
    }
    else if ([vraag isKindOfClass:[HitFragment class]])
    {
        _hitFragmentVC = [[HitFragmentViewController alloc] initWithNibName:@"HitFragmentView~ipad" bundle:nil];
        _hitFragmentVC.hitFragment = vraag;
        _newVC = _hitFragmentVC;
    }
    else if ([vraag isKindOfClass:[Hoes class]])
    {
        _coverVC = [[CoverViewController alloc] initWithNibName:@"CoverView~ipad" bundle:nil];
        _coverVC.hoes = vraag;
        _newVC = _coverVC;
    }
    else if ([vraag isKindOfClass:[Foto class]])
    {
        _pictureVC = [[PictureViewController alloc] initWithNibName:@"PictureView~ipad" bundle:nil];
        _pictureVC.picture = vraag;
        _newVC = _pictureVC;
    }

    [self showNewView];
}

- (void) showNewView;
{
    _newVC.view.alpha = 0;
    [_content addSubview:_newVC.view];
    
    UIViewController* vcToRemove = _currentVC;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        vcToRemove.view.alpha = 0;
        _newVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [vcToRemove.view removeFromSuperview];
        _currentVC = _newVC;
        _newVC = nil;
        _showNewView = YES;
    }];
}

#pragma mark - Button clicks

- (IBAction) stopBtnClicked;
{
    if (_currentVC)
    {
        [_currentVC viewWillDisappear:NO];
    }

    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) nextBtnClicked;
{
    if (_currentVC)
    {
        [_currentVC viewWillDisappear:NO];
    }
    
    @synchronized(self)
    {
        if (_showNewView)
        {
            _showNewView = NO;
            if ([[GameController sharedInstance] hasNextRound])
            {
                [self showNextRound];
            }
            else
            {
                [self dismissModalViewControllerAnimated:YES];
            }
        }
    }
}

@end
