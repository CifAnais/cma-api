//
//  MovieCollectionCell.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "MovieCollectionCell.h"
#import <SDWebImage/SDWebImageManager.h>

@interface MovieCollectionCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation MovieCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kMovieCollectionCellSize.width, kMovieCollectionCellSize.height)];
        self.coverImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.coverImageView];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)prepareForReuse
{
    self.coverImageView.image = nil;
}

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    
    if(movie.coverURL){
        [self downloadImage:movie.coverURL];
    }
}

#pragma mark - Download Images
- (void)downloadImage:(NSString *)imageUrl
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:imageUrl] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished){
        if(image){
            self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
            self.coverImageView.image = image;
        }
    }];
}

@end
