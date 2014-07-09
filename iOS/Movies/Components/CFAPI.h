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
#import "Genre.h"

@protocol CFAPIDelegate <NSObject>

@optional
- (void)apiFetchUsers:(NSArray *)users;

- (void)apiFetchUser:(User *)user;
- (void)apiPostUserSuccess:(User *)user;
- (void)apiDeleteUserSuccess;

- (void)apiFetchGenres:(NSArray *)genres;

- (void)apiFetchMovies:(NSArray *)movies;

- (void)apiPostMovieSuccess:(Movie *)movie;
- (void)apiDeleteMovieSuccess;
@end


@interface CFAPI : NSObject

@property (nonatomic, weak) id<CFAPIDelegate> delegate;

+ (CFAPI *)shared;

- (void)fetchMovies;
- (void)fetchUsers;
- (void)fetchGenres;

- (void)fetchUser:(User *)user;
- (void)fetchUserLikes:(User *)user;
- (void)fetchUserDislikes:(User *)user;
- (void)fetchUserWatched:(User *)user;
- (void)fetchUserWatchlist:(User *)user;

- (void)postMovie:(Movie *)movie Genre:(Genre *)genre;
- (void)deleteMovie:(Movie *)movie;

- (void)postUser:(User *)user;
- (void)deleteUser:(User *)user;

@end
