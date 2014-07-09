//
//  CFAPI.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "CFAPI.h"
#import <AFNetworking/AFNetworking.h>

@implementation CFAPI

+ (CFAPI *)shared
{
    static CFAPI *shared = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        shared = [[CFAPI alloc] init];
    });
    
    return shared;
}

- (id)init
{
    if ((self = [super init]) != nil){
        NSLog(@"CFAPI: init");
    }
    
    return self;
}


#pragma mark - Movie Endpoints
- (void)fetchMovies
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/movies", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *movies = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objMovie, NSUInteger idx, BOOL *stop) {
                if([objMovie isKindOfClass:[NSDictionary class]]){
                    [movies addObject:[Movie parserMovie:objMovie]];
                }
            }];
            
            if([self.delegate respondsToSelector:@selector(apiFetchMovies:)]){
                [self.delegate apiFetchMovies:movies];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)postMovie:(Movie *)movie Genre:(Genre *)genre
{
    NSDictionary *params = @{@"title": movie.title, @"cover" : movie.coverURL ? movie.coverURL : @"", @"genre":genre.genreId};
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/movies", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            Movie *movie = [Movie parserMovie:(NSDictionary *)data[@"data"]];
            
            if([self.delegate respondsToSelector:@selector(apiPostMovieSuccess:)]){
                [self.delegate apiPostMovieSuccess:movie];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)deleteMovie:(Movie *)movie
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/movies/%@", kAPIUrl, [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiDeleteMovieSuccess)]){
            [self.delegate apiDeleteMovieSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}


#pragma mark - User Endpoints
- (void)fetchUsers
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *users = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objUser, NSUInteger idx, BOOL *stop) {
                if([objUser isKindOfClass:[NSDictionary class]]){
                    [users addObject:[User parserUser:objUser]];
                }
            }];
            
            if([self.delegate respondsToSelector:@selector(apiFetchUsers:)]){
                [self.delegate apiFetchUsers:users];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)postUser:(User *)user
{
    NSDictionary *params = @{@"username": user.username};
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            User *user = [User parserUser:(NSDictionary *)data[@"data"]];
            
            if([self.delegate respondsToSelector:@selector(apiPostUserSuccess:)]){
                [self.delegate apiPostUserSuccess:user];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)deleteUser:(User *)user
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@", kAPIUrl, [user.userId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiDeleteUserSuccess)]){
            [self.delegate apiDeleteUserSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];

}

- (void)fetchUser:(User *)user
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@", kAPIUrl, [user.userId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            User *user = [User parserUser:(NSDictionary *)data[@"data"]];
            
            if([self.delegate respondsToSelector:@selector(apiFetchUser:)]){
                [self.delegate apiFetchUser:user];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}


#pragma mark - User Like Endpoints
- (void)fetchUserLikes:(User *)user
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/likes", kAPIUrl, [user.userId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *movies = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objMovie, NSUInteger idx, BOOL *stop) {
                if([objMovie isKindOfClass:[NSDictionary class]]){
                    [movies addObject:[Movie parserMovie:objMovie]];
                }
            }];
            
            
            if([self.delegate respondsToSelector:@selector(apiFetchUserLikes:)]){
                [self.delegate apiFetchUserLikes:movies];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        if([self.delegate respondsToSelector:@selector(apiFetchUserMoviesError)]){
            [self.delegate apiFetchUserMoviesError];
        }
    }];
}

- (void)postUserLike:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/likes/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiPostUserLikeSuccess)]){
            [self.delegate apiPostUserLikeSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)deleteUserLike:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/likes/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiDeleteUserLikeSuccess)]){
            [self.delegate apiDeleteUserLikeSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}


#pragma mark - User Dislike Endpoints
- (void)fetchUserDislikes:(User *)user
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/dislikes", kAPIUrl, [user.userId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *movies = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objMovie, NSUInteger idx, BOOL *stop) {
                if([objMovie isKindOfClass:[NSDictionary class]]){
                    [movies addObject:[Movie parserMovie:objMovie]];
                }
            }];
            
            
            if([self.delegate respondsToSelector:@selector(apiFetchUserDislikes:)]){
                [self.delegate apiFetchUserDislikes:movies];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        if([self.delegate respondsToSelector:@selector(apiFetchUserMoviesError)]){
            [self.delegate apiFetchUserMoviesError];
        }
    }];
}

- (void)postUserDislike:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/dislikes/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiPostUserDislikeSuccess)]){
            [self.delegate apiPostUserDislikeSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)deleteUserDislike:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/dislikes/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiDeleteUserDislikeSuccess)]){
            [self.delegate apiDeleteUserDislikeSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}


#pragma mark - User Watched Endpoints
- (void)fetchUserWatched:(User *)user
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/watched", kAPIUrl, [user.userId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *movies = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objMovie, NSUInteger idx, BOOL *stop) {
                if([objMovie isKindOfClass:[NSDictionary class]]){
                    [movies addObject:[Movie parserMovie:objMovie]];
                }
            }];
            
            
            if([self.delegate respondsToSelector:@selector(apiFetchUserWatched:)]){
                [self.delegate apiFetchUserWatched:movies];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        if([self.delegate respondsToSelector:@selector(apiFetchUserMoviesError)]){
            [self.delegate apiFetchUserMoviesError];
        }
    }];
}

- (void)postUserWatched:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/watched/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiPostUserWatchedSuccess)]){
            [self.delegate apiPostUserWatchedSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

- (void)deleteUserWatched:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/watched/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiDeleteUserWatchedSuccess)]){
            [self.delegate apiDeleteUserWatchedSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}


#pragma mark - User Watchlist Endpoints
- (void)fetchUserWatchlist:(User *)user
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/watchlist", kAPIUrl, [user.userId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *movies = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objMovie, NSUInteger idx, BOOL *stop) {
                if([objMovie isKindOfClass:[NSDictionary class]]){
                    [movies addObject:[Movie parserMovie:objMovie]];
                }
            }];
            
            
            if([self.delegate respondsToSelector:@selector(apiFetchUserWatchlist:)]){
                [self.delegate apiFetchUserWatchlist:movies];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        if([self.delegate respondsToSelector:@selector(apiFetchUserMoviesError)]){
            [self.delegate apiFetchUserMoviesError];
        }
    }];
}

- (void)postUserWatchlist:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/watchlist/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiPostUserWatchlistSuccess)]){
            [self.delegate apiPostUserWatchlistSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];

}

- (void)deleteUserWatchlist:(User *)user movie:(Movie *)movie
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/users/%@/watchlist/%@", kAPIUrl, [user.userId stringValue], [movie.movieId stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:endpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([self.delegate respondsToSelector:@selector(apiDeleteUserWatchlistSuccess)]){
            [self.delegate apiDeleteUserWatchlistSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}


#pragma mark - Genre Endpoints
- (void)fetchGenres
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/genres", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *genres = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objGenre, NSUInteger idx, BOOL *stop) {
                if([objGenre isKindOfClass:[NSDictionary class]]){
                    [genres addObject:[Genre parserGenre:objGenre]];
                }
            }];
            
            if([self.delegate respondsToSelector:@selector(apiFetchGenres:)]){
                [self.delegate apiFetchGenres:genres];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }];
}

@end
