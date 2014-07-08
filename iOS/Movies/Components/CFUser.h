//
//  CFUser.h
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CFUser : NSObject

@property (nonatomic, strong) User *user;

+ (CFUser *)shared;

@end
