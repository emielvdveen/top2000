//
//  DINNextMediumCondLabel.m
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "DINNextMediumCondLabel.h"

@implementation DINNextMediumCondLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"DINNextLTPro-MediumCond" size:self.font.pointSize]; 
}

@end
