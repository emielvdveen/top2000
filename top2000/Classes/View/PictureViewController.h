//
//  PictureViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Foto;

@interface PictureViewController : UIViewController
{
    IBOutlet UIImageView* background;    
}

@property (nonatomic, strong) Foto *picture;

@property (nonatomic, strong) IBOutlet UILabel *vraagLabel;
@property (nonatomic, strong) IBOutlet UILabel *antwoordLabel;
@property (nonatomic, strong) IBOutlet UIButton *antwoordBtn;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *rasterView;


- (IBAction) showAnswer;

@end
