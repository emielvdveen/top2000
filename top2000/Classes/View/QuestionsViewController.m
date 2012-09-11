//
//  QuestionsViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "QuestionsViewController.h"
#import "Doorvraag.h"

@interface QuestionsViewController ()

@end

@implementation QuestionsViewController

@synthesize doorvraag;

@synthesize vraag1TitleLabel;
@synthesize vraag2TitleLabel;
@synthesize vraag3TitleLabel;
@synthesize vraag4TitleLabel;

@synthesize vraag1Label;
@synthesize vraag2Label;
@synthesize vraag3Label;
@synthesize vraag4Label;

@synthesize antwoord1Label;
@synthesize antwoord2Label;
@synthesize antwoord3Label;
@synthesize antwoord4Label;

@synthesize antwoord1Btn;
@synthesize antwoord2Btn;
@synthesize antwoord3Btn;
@synthesize antwoord4Btn;

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
    
    antwoord2Btn.alpha = 0;
    vraag2Label.alpha = 0;
    vraag2TitleLabel.alpha = 0;

    antwoord3Btn.alpha = 0;
    vraag3Label.alpha = 0;
    vraag3TitleLabel.alpha = 0;

    antwoord4Btn.alpha = 0;
    vraag4Label.alpha = 0;
    vraag4TitleLabel.alpha = 0;

    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) showQuestion2;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord2Btn.alpha = 1;
        vraag2Label.alpha = 1;
        vraag2TitleLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

- (void) showQuestion3;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord3Btn.alpha = 1;
        vraag3Label.alpha = 1;
        vraag3TitleLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];    
}

- (void) showQuestion4;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord4Btn.alpha = 1;
        vraag4Label.alpha = 1;
        vraag4TitleLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

- (IBAction) showAnswer1;
{
    antwoord1Label.alpha = 0;
    antwoord1Label.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord1Btn.alpha = 0;
        antwoord1Label.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
    
    [self showQuestion2];
}

- (IBAction) showAnswer2;
{
    antwoord2Label.alpha = 0;
    antwoord2Label.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord2Btn.alpha = 0;
        antwoord2Label.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
    
    [self showQuestion3];
}

- (IBAction) showAnswer3;
{
    antwoord3Label.alpha = 0;
    antwoord3Label.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord3Btn.alpha = 0;
        antwoord3Label.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
    
    [self showQuestion4];
}

- (IBAction) showAnswer4;
{
    antwoord4Label.alpha = 0;
    antwoord4Label.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoord4Btn.alpha = 0;
        antwoord4Label.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

@end
