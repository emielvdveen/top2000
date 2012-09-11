//
//  PictureViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "PictureViewController.h"
#import "Foto.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
{
    NSMutableArray* _imagesLeft;
    NSTimer* _timer;
}

@synthesize picture;
@synthesize vraagLabel;
@synthesize antwoordLabel;
@synthesize antwoordBtn;
@synthesize imageView;
@synthesize rasterView;

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
    
    imageView.image = [picture image];
    antwoordLabel.text = picture.naam;
    
    _imagesLeft = [[NSMutableArray alloc] init];
    [_imagesLeft addObjectsFromArray:rasterView.subviews];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideNextImage) userInfo:nil repeats:YES];
}

- (void) hideNextImage;
{
    @synchronized(self)
    {    
        if ([_imagesLeft count] == 0)
        {
            [self stopTimer];
        }

        int random = arc4random_uniform([_imagesLeft count]);
        UIImageView* image = [_imagesLeft objectAtIndex:random];
        [_imagesLeft removeObjectAtIndex:random];
        
        [UIView animateWithDuration:1 animations:^{
            image.alpha = 0;
        }];        
    }
}

- (void) hideAllImages;
{
    @synchronized(self)
    {        
        [self stopTimer];        

        for(UIImageView* image in _imagesLeft)
        {
            [UIView animateWithDuration:0.5 animations:^{
                image.alpha = 0;
            }];
        }
    }
}


- (void) stopTimer;
{
    @synchronized(self)
    {
        if (_timer)
        {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated; // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{
    [self stopTimer];
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
    [self hideAllImages];
    
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
