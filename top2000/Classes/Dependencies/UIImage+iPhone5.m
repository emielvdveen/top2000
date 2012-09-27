//
//  UIImage+iPhone5.m
//  top2000
//
//  Created by Emiel on 27-09-12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "UIImage+iPhone5.h"

@implementation UIImage (iPhone5)

+ (UIImage*)imageNamedForDevice:(NSString*)name {
    
    UIImage *returnImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", name]];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale) >=1136)
        {
            return [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h@2x", name]];
        }
    }
    
    return returnImage;
}

@end
