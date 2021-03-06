//
//  MainViewController.h
//  top2000
//
//  Created by Emiel van der Veen on 8/27/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIView *content;
@property(nonatomic, strong) IBOutlet UIButton *previousBtn;

- (IBAction) previousBtnClicked;
- (IBAction) nextBtnClicked;
- (IBAction) stopBtnClicked;

@end
