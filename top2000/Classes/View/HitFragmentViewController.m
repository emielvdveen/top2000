//
//  HitFragmentViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "HitFragmentViewController.h"
#import "HitFragment.h"
#import <AVFoundation/AVFoundation.h>

@interface HitFragmentViewController ()

@end

@implementation HitFragmentViewController
{
    AVAudioPlayer *_audioPlayer;
    NSTimer* _timer;
}

@synthesize hitFragment;
@synthesize progressView;
@synthesize playBtn;
@synthesize playLabel;
@synthesize antwoord1Label;
@synthesize antwoord2Label;
@synthesize antwoord1Btn;
@synthesize antwoord2Btn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) hideProgressView;
{
    [UIView animateWithDuration:0.25 animations:^{
        progressView.alpha = 0;
    } completion:^(BOOL finished) {
    }];

    [UIView animateWithDuration:0.5 animations:^{
        playBtn.alpha = 1;
        playLabel.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void) showProgressView;
{
    [UIView animateWithDuration:0.25 animations:^{
        playBtn.alpha = 0;
        playLabel.alpha = 0;
    } completion:^(BOOL finished) {
    }];

    [UIView animateWithDuration:0.5 animations:^{
        progressView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void) updateProgress
{
    if ([_audioPlayer isPlaying])
    {
        float duration = _audioPlayer.duration;
        if (duration > 10)
        {
            duration = 10;
        }
        
        float newProgress = _audioPlayer.currentTime / duration;
        [progressView setProgress:newProgress animated:YES];
        
        if (newProgress >= 1)
        {
            [self stopPlayback];
            progressView.progress = 0;
            [self hideProgressView];    
        }
    }
}

- (void) playFragment
{   
    progressView.progress = 0;

    NSError *error;
    
    NSString *newAudioFile = [[NSBundle mainBundle] pathForResource:hitFragment.mp3Filename ofType:@"mp3"];
    _audioPlayer =  [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:newAudioFile] error:&error];
    _audioPlayer.delegate = self;
    
	if (_audioPlayer == nil)
    {
		NSLog(@"%@",[error description]);				
    }
	else 
    {
        [self showProgressView];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
		[_audioPlayer play];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    antwoord1Label.alpha = 0;
    antwoord2Label.alpha = 0;
    
    antwoord1Label.text = [NSString stringWithFormat:@"%@ - %@",  hitFragment.band,  hitFragment.titel];
    antwoord2Label.text = [NSString stringWithFormat:@"%@",  hitFragment.jaartal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewDidAppear:(BOOL)animated;
{
    progressView.progress = 0;
    playBtn.alpha = 0;
    playLabel.alpha = 0;

    [self performSelector:@selector(playFragment) withObject:nil afterDelay:1];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [self stopPlayback];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) showAnswer1;
{
    antwoord1Label.alpha = 0;
    antwoord1Label.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord1Btn.alpha = 0;
        antwoord1Label.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

- (void) showAnswer2;
{
    antwoord2Label.alpha = 0;
    antwoord2Label.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord2Btn.alpha = 0;
        antwoord2Label.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

-(void)doVolumeFade
{  
    if (_audioPlayer.volume > 0.1) {
        _audioPlayer.volume = _audioPlayer.volume - 0.1;
        [self performSelector:@selector(doVolumeFade) withObject:nil afterDelay:0.1];           
    } else {
        // Stop and get the sound ready for playing again
        [_audioPlayer stop];
        _audioPlayer.currentTime = 0;
        [_audioPlayer prepareToPlay];
        _audioPlayer.volume = 1.0;
    }
}

- (void) stopPlayback;
{
    [self doVolumeFade];
    [_timer invalidate];
}

#pragma mark - Button clicks

- (IBAction) playBtnClicked:(id)sender;
{
    [self playFragment];
}

- (IBAction) antwoord1BtnClicked:(id)sender;
{
    [self showAnswer1];
}

- (IBAction) antwoord2BtnClicked:(id)sender;
{
    [self showAnswer2];
}

#pragma mark - AVAudioPlayerDelegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    [self stopPlayback];
    progressView.progress = 0;
    [self hideProgressView];    
}

@end
