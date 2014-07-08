//
//  Movie.h
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSNumber *movieId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *coverURL;
@property (nonatomic, strong) NSNumber *genre;

+ (Movie *)parserMovie:(NSDictionary *)objMovie;

@end
