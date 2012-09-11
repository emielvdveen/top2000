//
//  HitFragment.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "HitFragment.h"

@implementation HitFragment

@synthesize band;
@synthesize titel;
@synthesize jaartal;
@synthesize mp3Filename;

+ (HitFragment*) createFromJson:(NSDictionary*)jsonValues;
{
    //{"band":"Sheena Easton ","titel":"The Lover in Me","jaartal":1989},
    HitFragment* result = [[HitFragment alloc] init];
    result.band = [jsonValues objectForKey:@"band"];
    result.titel = [jsonValues objectForKey:@"titel"];
    result.jaartal = [jsonValues objectForKey:@"jaartal"];
    return result;
}

@end
