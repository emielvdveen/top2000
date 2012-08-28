//
//  HitFragment.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HitFragment : NSObject
{
    NSString* band;
    NSString* titel;
    NSNumber* jaartal;
}

@property(nonatomic, copy) NSString *band;
@property(nonatomic, copy) NSString *titel;
@property(nonatomic, strong) NSNumber *jaartal;

+ (HitFragment*) createFromJson:(NSDictionary*)jsonValues;

@end
