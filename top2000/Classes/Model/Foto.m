//
//  Foto.m
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "Foto.h"

@implementation Foto
@synthesize naam;

+ (Foto *) createFromJson:(NSDictionary*)jsonValues;
{
    Foto * result = [[Foto alloc] init];
    result.naam = [jsonValues objectForKey:@"artist"];
    return result;
}

- (UIImage*) image;
{
    UIImage *result = [UIImage imageNamed:[NSString stringWithFormat:@"%@", naam]];
    return result;
}

@end
