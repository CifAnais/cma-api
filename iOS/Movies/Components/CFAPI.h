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
- (void)apiFetchGenres:(NSArray *)genres;
- (void)apiFetchMovies:(NSArray *)movies;

- (void)apiFetchUser:(User *)user;
- (void)apiFetchUserLikes:(NSArray *)movies;
- (void)apiFetchUserDislikes:(NSArray *)movies;
- (void)apiFetchUserWatched:(NSArray *)movies;
- (void)apiFetchUserWatchlist:(NSArray *)movies;
- (void)apiFetchUserMoviesError;

- (void)apiPostUserSuccess:(User *)user;
- (void)apiDeleteUserSuccess;

- (void)apiPostMovieSuccess:(Movie *)movie;
- (void)apiDeleteMovieSuccess;

- (void)apiPostUserLikeSuccess;
- (void)apiDeleteUserLikeSuccess;

- (void)apiPostUserDislikeSuccess;
- (void)apiDeleteUserDislikeSuccess;

- (void)apiPostUserWatchedSuccess;
- (void)apiDeleteUserWatchedSuccess;

- (void)apiPostUserWatchlistSuccess;
- (void)apiDeleteUserWatchlistSuccess;
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

- (void)postUserLike:(User *)user movie:(Movie *)movie;
- (void)deleteUserLike:(User *)user movie:(Movie *)movie;

- (void)postUserDislike:(User *)user movie:(Movie *)movie;
- (void)deleteUserDislike:(User *)user movie:(Movie *)movie;

- (void)postUserWatched:(User *)user movie:(Movie *)movie;
- (void)deleteUserWatched:(User *)user movie:(Movie *)movie;

- (void)postUserWatchlist:(User *)user movie:(Movie *)movie;
- (void)deleteUserWatchlist:(User *)user movie:(Movie *)movie;

- (void)postMovie:(Movie *)movie Genre:(Genre *)genre;
- (void)deleteMovie:(Movie *)movie;

- (void)postUser:(User *)user;
- (void)deleteUser:(User *)user;
@end
