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
- (void) resizeLabel:(UILabel*)label;
- (void) repositionHint1;
- (void) repositionHint2;
- (void) repositionHint3;
- (void) repositionHint4;
- (void) showHint:(UILabel*)hintLabel title:(UILabel*)titleLabel indicator1:(UIActivityIndicatorView*)indicator1 indicator2:(UIActivityIndicatorView*)indicator2;


@end

@implementation HintsViewController
{
    NSTimer *_timer;
    UILabel *_currentHintLabel;
    UILabel *_currentHintTitleLabel;
    UIActivityIndicatorView *_oldHintIndicator;
    UIActivityIndicatorView *_currentHintIndicator;
}
@synthesize hint;
@synthesize vraagLabel;
@synthesize hint1Label;
@synthesize hint2Label;
@synthesize hint3Label;
@synthesize hint4Label;
@synthesize hint1TitleLabel;
@synthesize hint2TitleLabel;
@synthesize hint3TitleLabel;
@synthesize hint4TitleLabel;
@synthesize hint2Indicator;
@synthesize hint3Indicator;
@synthesize hint4Indicator;
@synthesize antwoordLabel;
@synthesize antwoordBtn;

#define DELAY 4
#define SPACE 10

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
    
    [self resizeLabel:hint1Label];
    [self resizeLabel:hint2Label];
    [self resizeLabel:hint3Label];
    [self resizeLabel:hint4Label];
    
    [self resizeLabel:hint1TitleLabel];
    [self resizeLabel:hint2TitleLabel];
    [self resizeLabel:hint3TitleLabel];
    [self resizeLabel:hint4TitleLabel];

    [self repositionHint1];
    [self repositionHint2];
    [self repositionHint3];
    [self repositionHint4];
    
    hint2TitleLabel.alpha = 0;
    hint3TitleLabel.alpha = 0;
    hint4TitleLabel.alpha = 0;
    
    _currentHintLabel = hint1Label;
    _currentHintIndicator = hint2Indicator;
    [_currentHintIndicator startAnimating];

}

- (void) viewDidAppear:(BOOL)animated
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:DELAY target:self selector:@selector(showNextHint) userInfo:nil repeats:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
}

- (void) resizeLabel:(UILabel*)label
{
    label.numberOfLines = 2;
    label.textAlignment = UITextAlignmentCenter;
    
    UIFont* font = label.font;
    CGSize constraintSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
    CGSize labelSize = [label.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, labelSize.width, labelSize.height);
}

- (float) width;
{
    return (IPAD ? 1024 : 320);
}

- (void) repositionHint1
{
    float totalWidth = hint1Label.frame.size.width + hint1TitleLabel.frame.size.width + SPACE;
    float startX = ([self width] - totalWidth) / 2;
    
    CGRect frame = hint1TitleLabel.frame;
    frame.origin.x = startX;
    hint1TitleLabel.frame = frame;
    
    frame = hint1Label.frame;
    frame.origin.x = startX+hint1TitleLabel.frame.size.width + SPACE;
    frame.origin.y = hint1TitleLabel.frame.origin.y;
    hint1Label.frame = frame;
}

- (void) repositionHint2
{
    float totalWidth = hint2Label.frame.size.width + hint2TitleLabel.frame.size.width + SPACE;
    float startX = ([self width] - totalWidth) / 2;
    
    CGRect frame = hint2TitleLabel.frame;
    frame.origin.x = startX;
    hint2TitleLabel.frame = frame;
    
    frame = hint2Label.frame;
    frame.origin.x = startX+hint2TitleLabel.frame.size.width + SPACE;
    frame.origin.y = hint2TitleLabel.frame.origin.y;
    hint2Label.frame = frame;
}

- (void) repositionHint3
{
    float totalWidth = hint3Label.frame.size.width + hint3TitleLabel.frame.size.width + SPACE;
    float startX = ([self width] - totalWidth) / 2;
    
    CGRect frame = hint3TitleLabel.frame;
    frame.origin.x = startX;
    hint3TitleLabel.frame = frame;
    
    frame = hint3Label.frame;
    frame.origin.x = startX+hint3TitleLabel.frame.size.width + SPACE;
    frame.origin.y = hint3TitleLabel.frame.origin.y;
    hint3Label.frame = frame;
}

- (void) repositionHint4
{
    float totalWidth = hint4Label.frame.size.width + hint4TitleLabel.frame.size.width + SPACE;
    float startX = ([self width] - totalWidth) / 2;
    
    CGRect frame = hint4TitleLabel.frame;
    frame.origin.x = startX;
    hint4TitleLabel.frame = frame;
    
    frame = hint4Label.frame;
    frame.origin.x = startX+hint4TitleLabel.frame.size.width + SPACE;
    frame.origin.y = hint4TitleLabel.frame.origin.y;
    hint4Label.frame = frame;
}

- (void) showNextHint;
{
    _oldHintIndicator = _currentHintIndicator;
    
    if (_currentHintLabel == hint1Label)
    {
        _currentHintLabel = hint2Label;
        _currentHintTitleLabel = hint2TitleLabel;
        _currentHintIndicator = hint3Indicator;
        [_currentHintIndicator startAnimating];
    }
    else if (_currentHintLabel == hint2Label)
    {
        _currentHintLabel = hint3Label;
        _currentHintTitleLabel = hint3TitleLabel;
        _currentHintIndicator = hint4Indicator;
        [_currentHintIndicator startAnimating];
    }
    else if (_currentHintLabel == hint3Label)
    {
        _currentHintLabel = hint4Label;
        _currentHintTitleLabel = hint4TitleLabel;
        _currentHintIndicator = nil;
    }
    else if (_currentHintLabel == hint4Label)
    {
        [_timer invalidate];
        return;
    }

    [self showHint:_currentHintLabel title:_currentHintTitleLabel indicator1:_oldHintIndicator indicator2:_currentHintIndicator];
}

- (void) showHint:(UILabel*)hintLabel title:(UILabel*)titleLabel indicator1:(UIActivityIndicatorView*)indicator1 indicator2:(UIActivityIndicatorView*)indicator2;
{
    if (!hintLabel.hidden)
    {
        return;
    }

    hintLabel.alpha = 0;
    hintLabel.hidden = NO;
    titleLabel.alpha = 0;
    titleLabel.hidden = NO;
    
    indicator2.alpha = 0;
    [indicator2 startAnimating];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        hintLabel.alpha = 1;
        titleLabel.alpha = 1;
        indicator2.alpha = 1;
        indicator1.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
            indicator2.alpha = 1;
        } completion:^(BOOL finished) {
            // nothing
        }];
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

    [self showHint:hint2Label title:hint2TitleLabel indicator1:nil indicator2:nil];
    [self showHint:hint3Label title:hint3TitleLabel indicator1:nil indicator2:nil];
    [self showHint:hint4Label title:hint4TitleLabel indicator1:nil indicator2:nil];

    [_currentHintIndicator stopAnimating];
    
    antwoordLabel.alpha = 0;
    antwoordLabel.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        antwoordBtn.alpha = 0;
        antwoordLabel.alpha = 1;
    } completion:^(BOOL finished) {
        // nothing
    }];
}

@end
