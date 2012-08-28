//
//  Hoes.m
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import "Hoes.h"

@implementation Hoes
@synthesize naam;
@synthesize vraag;
@synthesize antwoord;

+ (Hoes*) createFromJson:(NSDictionary*)jsonValues;
{
// {"hoes":"Zappa ","vraag":"Noem de artiest","antwoord":"Frank Zappa"},
    Hoes* result = [[Hoes alloc] init];
    result.naam = [jsonValues objectForKey:@"hoes"];
    result.vraag = [jsonValues objectForKey:@"vraag"];
    result.antwoord = [jsonValues objectForKey:@"antwoord"];
    return result;
}

@end
