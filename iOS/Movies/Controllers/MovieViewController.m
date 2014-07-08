//
//  MovieViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "MovieViewController.h"
#import "CFAPI.h"
#import <SDWebImage/SDWebImageManager.h>

@interface MovieViewController () <CFAPIDelegate>

@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMovie:(Movie *)movie
{
    self = [super init];
    if (self) {
        self.movie = movie;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.movie.title;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteMovieAction)];
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.coverImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.coverImageView];
    
    if(self.movie.coverURL){
        [self downloadImage:self.movie.coverURL];
    }
    
    [CFAPI shared].delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Delete Movie
- (void)deleteMovieAction
{
    [[CFAPI shared] deleteMovie:self.movie];
}


#pragma mark - CFAPI Delegate
- (void)apiDeletingMovieSuccess
{
    [[[UIAlertView alloc] initWithTitle:@"Success" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)apiDeletingMovieFailedWithError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

@end
