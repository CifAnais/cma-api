//
//  User.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)parserUser:(NSDictionary *)objUser
{
    User *user = [User new];
    
    user.userId = objUser[@"id"] ? objUser[@"id"] : nil;
    user.username = objUser[@"username"] ? objUser[@"username"] : nil;
    
    user.likes = objUser[@"likes"] ? objUser[@"likes"] : nil;
    user.dislikes = objUser[@"dislikes"] ? objUser[@"dislikes"] : nil;
    user.watched = objUser[@"watched"] ? objUser[@"watched"] : nil;
    user.watchlist = objUser[@"watchlist"] ? objUser[@"watchlist"] : nil;

    return user;
}

@end
