//
//  DINNextBoldLabel.m
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "DINNextBoldLabel.h"

@implementation DINNextBoldLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"DINNextLTPro-Bold" size:self.font.pointSize]; 
}

@end
