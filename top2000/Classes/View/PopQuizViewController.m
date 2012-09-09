//
//  PopQuizViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "PopQuizViewController.h"
#import "PopQuizVraag.h"

@interface PopQuizViewController ()

@end

@implementation PopQuizViewController
@synthesize vraagLabel;
@synthesize antwoordLabel;
@synthesize antwoordBtn;
@synthesize vraag;


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
	vraagLabel.text = vraag.vraag;
    antwoordLabel.text = vraag.antwoord;
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

- (IBAction) showAnswer;
{
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
