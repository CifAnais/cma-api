//
//  UserMoviesViewController.h
//  Movies
//
//  Created by Aymeric Gallissot on 09/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef NS_ENUM(NSInteger, MoviesType) {
    MoviesTypeLikes,
    MoviesTypeDislikes,
    MoviesTypeWatched,
    MoviesTypeWishlist
};

@interface UserMoviesViewController : UIViewController

- (id)initWithUser:(User *)user MoviesType:(MoviesType)moviesType;

@end
