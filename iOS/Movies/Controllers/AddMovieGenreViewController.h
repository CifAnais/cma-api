//
//  AddMovieGenreViewController.h
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Genre.h"

@protocol AddMovieGenreDelegate <NSObject>

@optional
- (void)selectedGenre:(Genre *)genre;
@end

@interface AddMovieGenreViewController : UIViewController

@property (nonatomic, weak) id<AddMovieGenreDelegate> delegate;
@property (nonatomic, strong) Genre *genre;

@end
