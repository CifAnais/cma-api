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


@end
