//
//  MovieViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "MovieViewController.h"
#import "CFAPI.h"
#import "CFUser.h"
#import <SDWebImage/SDWebImageManager.h>

@interface MovieViewController () <CFAPIDelegate>

@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIToolbar *postToolBar;
@property (nonatomic, strong) UIToolbar *deleteToolBar;

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
    
    self.postToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.height - 137.0, self.view.width, 44.0)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *postLike = [[UIBarButtonItem alloc] initWithTitle:@"Like" style:0 target:nil action:nil];
    UIBarButtonItem *postDislike = [[UIBarButtonItem alloc] initWithTitle:@"Dislike" style:0 target:nil action:nil];
    UIBarButtonItem *postWatched = [[UIBarButtonItem alloc] initWithTitle:@"Watched" style:0 target:nil action:nil];
    UIBarButtonItem *postWatchlist = [[UIBarButtonItem alloc] initWithTitle:@"Watchlist" style:0 target:nil action:nil];

    NSArray *postItems = @[flexibleSpace, postLike, postDislike, postWatched, postWatchlist, flexibleSpace];
    [self.postToolBar setItems:postItems];
    
    self.deleteToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.height - 93.0, self.view.width, 44.0)];
    UIBarButtonItem *deleteLike = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:nil action:nil];
    UIBarButtonItem *deleteDislike = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:nil action:nil];
    UIBarButtonItem *deleteWatched = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:nil action:nil];
    UIBarButtonItem *deleteWatchlist = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:nil action:nil];
    NSArray *deleteItems = @[flexibleSpace, deleteLike, deleteDislike, deleteWatched, deleteWatchlist, flexibleSpace];
    [self.deleteToolBar setItems:deleteItems];

    
    [CFAPI shared].delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [CFAPI shared].delegate = self;
    
    if([CFUser shared].user){
        [self.view addSubview:self.postToolBar];
        [self.view addSubview:self.deleteToolBar];
    }
    else{
        [self.postToolBar removeFromSuperview];
        [self.deleteToolBar removeFromSuperview];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if([CFUser shared].user){
        [self.postToolBar removeFromSuperview];
        [self.deleteToolBar removeFromSuperview];
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


#pragma mark - Delete Movie
- (void)deleteMovieAction
{
    [[CFAPI shared] deleteMovie:self.movie];
}


#pragma mark - CFAPI Delegate
- (void)apiDeleteMovieSuccess
{
    [[[UIAlertView alloc] initWithTitle:@"Success" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)apiDeletingMovieFailedWithError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

@end
