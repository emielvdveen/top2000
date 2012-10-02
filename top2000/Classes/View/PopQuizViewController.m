//
//  PopQuizViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "PopQuizViewController.h"
#import "PopQuizVraag.h"
#import "Globals.h"
#import "UIImage+iPhone5.h"

@interface PopQuizViewController ()

@end

@implementation PopQuizViewController
@synthesize vraagLabel;
@synthesize antwoordLabel;
@synthesize antwoordBtn;
@synthesize vraag;

- (void) dealloc
{
    NSLog(@"PopQuizViewController dealloc");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (float) maxNiceWidth
{
    return (IPAD ? 681 : 300);
}

- (float) width
{
    return (IPAD ? 1024 : 320);
}

- (float) calculateNiceWidth:(UILabel*)label;
{
    UIFont* font = label.font;
    CGSize constraintSize = CGSizeMake(MAXFLOAT, 10);
    CGSize labelSize = [label.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    NSLog(@"##### labelSize.width = %f", labelSize.width);
    float niceWidth = labelSize.width;
    
    if (niceWidth > [self maxNiceWidth])
    {
        niceWidth = roundf(niceWidth / 1.5);
        if (niceWidth > [self maxNiceWidth])
        {
            niceWidth = [self maxNiceWidth];
        }
    }
    
    NSLog(@"##### niceWidth = %f", niceWidth);
    return niceWidth;
}

- (void) resizeLabel:(UILabel*)label below:(UIView*)view
{
    label.numberOfLines = 0;
    label.textAlignment = UITextAlignmentCenter;
    
    float niceWidth = label.frame.size.width;

    if (IPAD)
    {
        niceWidth = [self calculateNiceWidth:label];
    }
    
    UIFont* font = label.font;
    CGSize constraintSize = CGSizeMake(niceWidth, MAXFLOAT);
    CGSize labelSize = [label.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = label.frame;
    frame.size.width = niceWidth;
    frame.size.height = labelSize.height;
    
    if (view)
    {
        frame.origin.y = CGRectGetMaxY(view.frame) + (IPAD ? 8 : 4);
    }
    label.frame = frame;
    
    CGPoint center = label.center;
    center.x = [self width] / 2;
    label.center = center;
}

- (void) repositionBtn:(UIButton*)btn below:(UIView*)view
{
    CGRect frame = btn.frame;
    frame.origin.y = CGRectGetMaxY(view.frame) + (IPAD ? 14 : 7);
    btn.frame = frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IPHONE5)
    {
        background.image = [UIImage imageNamedForDevice:@"popquiz_background_iphone"];
        CGRect frame = self.view.frame;
        frame.size.height = 568;
        self.view.frame = frame;
    }
    
	vraagLabel.text = vraag.vraag;
    antwoordLabel.text = vraag.antwoord;
    
    [self resizeLabel:vraagLabel below:nil];
    [self resizeLabel:antwoordLabel below:vraagLabel];
    [self repositionBtn:antwoordBtn below:vraagLabel];
}

- (void) viewWillDisappear:(BOOL)animated
{
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) showAnswer;
{
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
