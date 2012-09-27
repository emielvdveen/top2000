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
