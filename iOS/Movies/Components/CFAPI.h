//
//  CFAPI.h
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "User.h"

@protocol CFAPIDelegate <NSObject>

@optional
- (void)apiFetchingMovies:(NSArray *)movies;
- (void)apiFetchingMoviesFailedWithError:(NSError *)error;

- (void)apiFetchingUsers:(NSArray *)users;
- (void)apiFetchingUsersFailedWithError:(NSError *)error;
@end


@interface CFAPI : NSObject

@property (nonatomic, weak) id<CFAPIDelegate> delegate;

+ (CFAPI *)shared;

- (void)fetchMovies;
- (void)fetchUsers;
@end
