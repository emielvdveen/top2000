//
//  DINNextMediumLabel.m
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "DINNextMediumLabel.h"

@implementation DINNextMediumLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"DINNextLTPro-Medium" size:self.font.pointSize]; 
}

@end
