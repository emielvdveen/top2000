//
//  PictureViewController.m
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PictureViewController.h"
#import "Foto.h"
#import "UIImage+iPhone5.h"
#import "Globals.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
{
    NSMutableArray* _imagesLeft;
    NSTimer* _timer;
}

@synthesize picture = _picture;
@synthesize vraagLabel;
@synthesize antwoordLabel;
@synthesize antwoordBtn;
@synthesize imageView;
@synthesize rasterView;

- (void) dealloc
{
    NSLog(@"PictureViewController dealloc");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) showImage;
{
    imageView.alpha = 0;
    imageView.image = [_picture image];
    [UIView animateWithDuration:1 animations:^{
        imageView.alpha = 1;
    }];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(hideNextImage) userInfo:nil repeats:YES];
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


- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IPHONE5)
    {
        background.image = [UIImage imageNamedForDevice:@"picture_background_iphone"];
        CGRect frame = self.view.frame;
        frame.size.height = 568;
        self.view.frame = frame;
    }
    
    antwoordLabel.text = [_picture.naam substringToIndex:[_picture.naam length]-4];
    
    _imagesLeft = [[NSMutableArray alloc] init];
    [_imagesLeft addObjectsFromArray:rasterView.subviews];
    rasterView.layer.masksToBounds = YES;
    
    //[self performSelector:@selector(showImage) withObject:nil afterDelay:0];
    //[self showImage];
}

- (void) viewDidAppear:(BOOL)animated;
{
    [self showImage];
}

- (void) viewWillDisappear:(BOOL)animated
{
//    _picture = nil;
    imageView.alpha = 0;
//    _imagesLeft = nil;
    
//    for(UIImageView* view in rasterView.subviews)
//    {
//        view.image = nil;
//    }
    
    [self stopTimer];
}

- (void) hideNextImage;
{
    @synchronized(self)
    {    
        if ([_imagesLeft count] == 0)
        {
            [self stopTimer];
            return;
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
