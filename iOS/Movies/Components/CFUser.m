//
//  CFUser.m
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "CFUser.h"

@interface CFUser ()

@end

@implementation CFUser

+ (CFUser *)shared
{
    static CFUser *shared = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        shared = [[CFUser alloc] init];
    });
    
    return shared;
}

- (id)init
{
    if ((self = [super init]) != nil){
        NSLog(@"CFUser: init");
    }
    
    return self;
}

@end
