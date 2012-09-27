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
#import "Globals.h"

@interface MainViewController ()
- (void) showNextRound;
- (void) showNewView;
@end

@implementation MainViewController
{
    UIViewController * _previousVC;
    UIViewController *_currentVC;
    UIViewController * _newVC;
    
    BOOL _showNewView;
}

@synthesize content = _content;
@synthesize previousBtn = _previousBtn;


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
    _previousBtn.alpha = 0;
    
    if (IPHONE5)
    {
        CGRect frame = self.view.frame;
        frame.size.height = 568;
        self.view.frame = frame;
    }
    
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
    NSString* postfix = IPAD ? @"~ipad" : @"~iphone";
    
    if (!_newVC)
    {
        id vraag = [[GameController sharedInstance] nextRound];

        if ([vraag isKindOfClass:[NSArray class]])
        {
            NSString *nibName = [NSString stringWithFormat:@"QuestionsView%@", postfix];
            QuestionsViewController *doorvraagVC = [[QuestionsViewController alloc] initWithNibName:nibName bundle:nil];
            doorvraagVC.doorvragen = vraag;
            _newVC = doorvraagVC;
        }
        else if ([vraag isKindOfClass:[PopQuizVraag class]])
        {
            NSString *nibName = [NSString stringWithFormat:@"PopQuizView%@", postfix];
            PopQuizViewController *popQuizVC = [[PopQuizViewController alloc] initWithNibName:nibName bundle:nil];
            popQuizVC.vraag = vraag;
            _newVC = popQuizVC;
        }
        else if ([vraag isKindOfClass:[Hint class]])
        {
            NSString *nibName = [NSString stringWithFormat:@"HintsView%@", postfix];
            HintsViewController *hintsVC = [[HintsViewController alloc] initWithNibName:nibName bundle:nil];
            hintsVC.hint = vraag;
            _newVC = hintsVC;
        }
        else if ([vraag isKindOfClass:[HitFragment class]])
        {
            NSString *nibName = [NSString stringWithFormat:@"HitFragmentView%@", postfix];
            HitFragmentViewController *hitFragmentVC = [[HitFragmentViewController alloc] initWithNibName:nibName bundle:nil];
            hitFragmentVC.hitFragment = vraag;
            _newVC = hitFragmentVC;
        }
        else if ([vraag isKindOfClass:[Hoes class]])
        {
            NSString *nibName = [NSString stringWithFormat:@"CoverView%@", postfix];
            CoverViewController *coverVC = [[CoverViewController alloc] initWithNibName:nibName bundle:nil];
            coverVC.hoes = vraag;
            _newVC = coverVC;
        }
        else if ([vraag isKindOfClass:[Foto class]])
        {
            NSString *nibName = [NSString stringWithFormat:@"PictureView%@", postfix];
            PictureViewController *pictureVC = [[PictureViewController alloc] initWithNibName:nibName bundle:nil];
            pictureVC.picture = vraag;
            _newVC = pictureVC;
        }
    }

    [self showNewView];
}

- (void) showNewView;
{
    _previousVC = _currentVC;
    _newVC.view.alpha = 0;
    [_content addSubview:_newVC.view];
    
    UIViewController* vcToRemove = _currentVC;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        vcToRemove.view.alpha = 0;
        _newVC.view.alpha = 1;
        if (_previousVC)
        {
            _previousBtn.alpha = 1;
        }
    } completion:^(BOOL finished) {
        [vcToRemove.view removeFromSuperview];
        _currentVC = _newVC;
        _newVC = nil;
        _showNewView = YES;
    }];
}

- (void) showPreviousView;
{
    _newVC = _currentVC; 
    _previousVC.view.alpha = 0;
    [_content addSubview:_previousVC.view];
    
    UIViewController* vcToRemove = _currentVC;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        vcToRemove.view.alpha = 0;
        _previousVC.view.alpha = 1;
        _previousBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [vcToRemove.view removeFromSuperview];
        _currentVC = _previousVC;
        _previousVC = nil;
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

- (IBAction) previousBtnClicked;
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
            [self showPreviousView];
        }
    }
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
