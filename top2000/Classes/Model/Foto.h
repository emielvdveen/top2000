//
//  Foto.h
//  top2000
//
//  Created by Emiel van der Veen on 9/9/12.
//  Copyright (c) 2012 Applike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foto : NSObject
{
    NSString* naam;
}

@property(nonatomic, copy) NSString *naam;

+ (Foto *) createFromJson:(NSDictionary*)jsonValues;

- (UIImage*) image;

@end
