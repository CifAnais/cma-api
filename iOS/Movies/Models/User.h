//
//  User.h
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *username;

+ (User *)parserUser:(NSDictionary *)objUser;

@end
