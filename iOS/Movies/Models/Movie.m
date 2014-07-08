//
//  Movie.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (Movie *)parserMovie:(NSDictionary *)objMovie
{
    Movie *movie = [Movie new];
    
    movie.movieId = objMovie[@"id"] ? objMovie[@"id"] : nil;
    movie.title = objMovie[@"title"] ? objMovie[@"title"] : nil;
    movie.coverURL = objMovie[@"cover"] ? objMovie[@"cover"] : nil;
    movie.genre = objMovie[@"genre"] ? objMovie[@"genre"] : nil;
    
    return movie;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"{\n    movieId: %@\n    title: %@\n    coverURL: %@\n    genre: %@\n}", [self.movieId stringValue], self.title, self.coverURL, [self.genre stringValue]];
}

@end
