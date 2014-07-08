//
//  Genre.m
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "Genre.h"

@implementation Genre

+ (Genre *)parserGenre:(NSDictionary *)objGenre
{
    Genre *genre = [Genre new];
    
    genre.genreId = objGenre[@"id"] ? objGenre[@"id"] : nil;
    genre.name = objGenre[@"name"] ? objGenre[@"name"] : nil;
    
    return genre;
}

@end
