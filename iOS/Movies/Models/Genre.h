//
//  Genre.h
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject

@property (nonatomic, strong) NSNumber *genreId;
@property (nonatomic, strong) NSString *name;

+ (Genre *)parserGenre:(NSDictionary *)objGenre;

@end
