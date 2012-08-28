//
//  Hoes.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hoes : NSObject
{
    NSString* naam;
    NSString* vraag;
    NSString* antwoord;
}

@property(nonatomic, copy) NSString *naam;
@property(nonatomic, copy) NSString *vraag;
@property(nonatomic, copy) NSString *antwoord;

+ (Hoes*) createFromJson:(NSDictionary*)jsonValues;

@end
