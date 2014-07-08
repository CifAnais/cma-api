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


#pragma mark - Endpoints
- (void)fetchMovies
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/movies", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *movies = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objMovie, NSUInteger idx, BOOL *stop) {
                if([objMovie isKindOfClass:[NSDictionary class]]){
                    [movies addObject:[Movie parserMovie:objMovie]];
                }
            }];
            
            if([self.delegate respondsToSelector:@selector(apiFetchingMovies:)]){
                [self.delegate apiFetchingMovies:movies];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if([self.delegate respondsToSelector:@selector(apiFetchingMoviesFailedWithError:)]){
            [self.delegate apiFetchingMoviesFailedWithError:error];
        }
    }];
}

- (void)fetchUsers
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/users", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *users = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objUser, NSUInteger idx, BOOL *stop) {
                if([objUser isKindOfClass:[NSDictionary class]]){
                    [users addObject:[User parserUser:objUser]];
                }
            }];
            
            if([self.delegate respondsToSelector:@selector(apiFetchingUsers:)]){
                [self.delegate apiFetchingUsers:users];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if([self.delegate respondsToSelector:@selector(apiFetchingUsersFailedWithError:)]){
            [self.delegate apiFetchingUsersFailedWithError:error];
        }
    }];
}

- (void)fetchGenres
{
    NSDictionary *params;
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/genres", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            __block NSMutableArray *genres = [[NSMutableArray alloc] init];
            
            [(NSArray *)data[@"data"] enumerateObjectsUsingBlock:^(id objGenre, NSUInteger idx, BOOL *stop) {
                if([objGenre isKindOfClass:[NSDictionary class]]){
                    [genres addObject:[Genre parserGenre:objGenre]];
                }
            }];
            
            if([self.delegate respondsToSelector:@selector(apiFetchingGenres:)]){
                [self.delegate apiFetchingGenres:genres];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if([self.delegate respondsToSelector:@selector(apiFetchingGenresFailedWithError:)]){
            [self.delegate apiFetchingGenresFailedWithError:error];
        }
    }];
}

- (void)postMovie:(Movie *)movie Genre:(Genre *)genre
{
    NSDictionary *params = @{@"title": movie.title, @"cover" : movie.coverURL ? movie.coverURL : @"", @"genre":genre.genreId};
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/movies", kAPIUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = responseObject;
        
        if(data[@"data"]){
            
            Movie *movie = [Movie parserMovie:(NSDictionary *)data[@"data"]];
            
            if([self.delegate respondsToSelector:@selector(apiPostingMovieSuccess:)]){
                [self.delegate apiPostingMovieSuccess:movie];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if([self.delegate respondsToSelector:@selector(apiPostingMovieFailedWithError:)]){
            [self.delegate apiPostingMovieFailedWithError:error];
        }
    }];
}

@end
