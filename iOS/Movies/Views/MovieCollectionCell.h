//
//  MovieCollectionCell.h
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

static CGSize kMovieCollectionCellSize = {100, 133};
static NSString *kMovieCollectionCellIdentifier = @"kMovieCollectionCellIdentifier";

@interface MovieCollectionCell : UICollectionViewCell

@property (nonatomic, strong) Movie *movie;

@end
