//
//  QuestionsViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "QuestionsViewController.h"
#import "Doorvraag.h"
#import "Globals.h"
#import "UIImage+iPhone5.h"

@interface QuestionsViewController ()

@end

@implementation QuestionsViewController

#define DELTA_Y (IPAD ? 200 : 150)

@synthesize doorvragen;

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

- (void) dealloc
{
    NSLog(@"QuestionsViewController dealloc");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) resizeLabel:(UILabel*)label below:(UIView*)view
{
    label.numberOfLines = 0;
    label.textAlignment = UITextAlignmentCenter;
    
    UIFont* font = label.font;
    CGSize constraintSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
    CGSize labelSize = [label.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = label.frame;
    frame.size.height = labelSize.height;
    if (view)
    {
        frame.origin.y = CGRectGetMaxY(view.frame) + (IPAD ? 8 : 4);
    }
    label.frame = frame;
}

- (void) repositionBtn:(UIButton*)btn below:(UIView*)view
{
    CGRect frame = btn.frame;
    frame.origin.y = CGRectGetMaxY(view.frame) + (IPAD ? 8 : 4);
    btn.frame = frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IPHONE5)
    {
        background.image = [UIImage imageNamedForDevice:@"doorvraag_background_iphone"];
        CGRect frame = self.view.frame;
        frame.size.height = 568;
        self.view.frame = frame;
    }
    
    vraag1Label.text = ((Doorvraag*)[doorvragen objectAtIndex:0]).vraag;
    antwoord1Label.text = ((Doorvraag*)[doorvragen objectAtIndex:0]).antwoord;

    vraag2Label.text = ((Doorvraag*)[doorvragen objectAtIndex:1]).vraag;
    antwoord2Label.text = ((Doorvraag*)[doorvragen objectAtIndex:1]).antwoord;

    vraag3Label.text = ((Doorvraag*)[doorvragen objectAtIndex:2]).vraag;
    antwoord3Label.text = ((Doorvraag*)[doorvragen objectAtIndex:2]).antwoord;

    vraag4Label.text = ((Doorvraag*)[doorvragen objectAtIndex:3]).vraag;
    antwoord4Label.text = ((Doorvraag*)[doorvragen objectAtIndex:3]).antwoord;

    antwoord2Btn.alpha = 0;
    vraag2Label.alpha = 0;
    vraag2TitleLabel.alpha = 0;

    antwoord3Btn.alpha = 0;
    vraag3Label.alpha = 0;
    vraag3TitleLabel.alpha = 0;

    antwoord4Btn.alpha = 0;
    vraag4Label.alpha = 0;
    vraag4TitleLabel.alpha = 0;

    [self resizeLabel:vraag1Label below:nil];
    [self resizeLabel:antwoord1Label below:vraag1Label];
    [self repositionBtn:antwoord1Btn below:vraag1Label];

    [self resizeLabel:vraag2Label below:nil];
    [self resizeLabel:antwoord2Label below:vraag2Label];
    [self repositionBtn:antwoord2Btn below:vraag2Label];
    
    [self resizeLabel:vraag3Label below:nil];
    [self resizeLabel:antwoord3Label below:vraag3Label];
    [self repositionBtn:antwoord3Btn below:vraag3Label];

    [self resizeLabel:vraag4Label below:nil];
    [self resizeLabel:antwoord4Label below:vraag4Label];
    [self repositionBtn:antwoord4Btn below:vraag4Label];
}

- (void) viewWillDisappear:(BOOL)animated
{
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

    [self moveAnswer1];
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
    
    [self hideAnswer1];
    [self moveAnswer2];
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
    
    [self hideAnswer2];
    [self moveAnswer3];
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
    
    [self hideAnswer3];
}

-(void) moveAnswer1;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        vraag1TitleLabel.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
        vraag1Label.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
        antwoord1Label.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
    } completion:^(BOOL finished) {
        // nothing
    }];
}

-(void) moveAnswer2;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        vraag2TitleLabel.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
        vraag2Label.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
        antwoord2Label.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
    } completion:^(BOOL finished) {
        // nothing
    }];
}

-(void) moveAnswer3;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        vraag3TitleLabel.transform = CGAffineTransformMakeTranslation(0,DELTA_Y);
        vraag3Label.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
        antwoord3Label.transform = CGAffineTransformMakeTranslation(0, DELTA_Y);
    } completion:^(BOOL finished) {
        // nothing
    }];
}

-(void) hideAnswer1;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        vraag1TitleLabel.alpha = 0;
        vraag1Label.alpha = 0;
        antwoord1Label.alpha = 0;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

-(void) hideAnswer2;
{
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationCurveEaseOut animations:^{
        vraag2TitleLabel.alpha = 0;
        vraag2Label.alpha = 0;
        antwoord2Label.alpha = 0;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

-(void) hideAnswer3;
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        vraag3TitleLabel.alpha = 0;
        vraag3Label.alpha = 0;
        antwoord3Label.alpha = 0;
    } completion:^(BOOL finished) {
        // nothing
    }];
}


@end
