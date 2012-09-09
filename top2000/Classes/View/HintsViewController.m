//
//  HintsViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "HintsViewController.h"
#import "Hint.h"

@interface HintsViewController ()

@end

@implementation HintsViewController
{
    NSTimer *_timer;
    UILabel *_currentHintLabel;
}
@synthesize hint;
@synthesize vraagLabel;
@synthesize hint1Label;
@synthesize hint2Label;
@synthesize hint3Label;
@synthesize hint4Label;
@synthesize antwoordLabel;
@synthesize antwoordBtn;

#define DELAY 4

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
    vraagLabel.text = hint.vraag;
    hint1Label.text = hint.hint1;
    hint2Label.text = hint.hint2;
    hint3Label.text = hint.hint3;
    hint4Label.text = hint.hint4;
    antwoordLabel.text = hint.antwoord;

    _currentHintLabel = hint1Label;

    _timer = [NSTimer scheduledTimerWithTimeInterval:DELAY target:self selector:@selector(showNextHint) userInfo:nil repeats:YES];
}

- (void) showNextHint;
{
    if (_currentHintLabel == hint1Label)
    {
        _currentHintLabel = hint2Label;
    }
    else if (_currentHintLabel == hint2Label)
    {
        _currentHintLabel = hint3Label;
    }
    else if (_currentHintLabel == hint3Label)
    {
        _currentHintLabel = hint4Label;
    }
    else if (_currentHintLabel == hint4Label)
    {
        [_timer invalidate];
        return;
    }

    [self showHint:_currentHintLabel];
}

- (void) showHint:(UILabel*)hintLabel;
{
    if (!hintLabel.hidden)
    {
        return;
    }

    hintLabel.alpha = 0;
    hintLabel.hidden = NO;

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        hintLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction) showAnswer;
{
    [_timer invalidate];

    [self showHint:hint2Label];
    [self showHint:hint3Label];
    [self showHint:hint4Label];

    antwoordLabel.alpha = 0;
    antwoordLabel.hidden = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoordBtn.alpha = 0;
        antwoordLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}


@end
