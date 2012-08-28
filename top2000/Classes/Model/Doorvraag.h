//
//  Doorvraag.h
//  top2000
//
//  Created by Emiel van der Veen on 8/28/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doorvraag : NSObject

@property (nonatomic, strong) NSNumber* vraagId;
@property (nonatomic, strong) NSString* vraag;
@property (nonatomic, strong) NSString* antwoord;

+ (Doorvraag*) createFromJson:(NSDictionary*)jsonValues; 

@end
