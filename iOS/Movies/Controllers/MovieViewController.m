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
@property (nonatomic, strong) UIBarButtonItem *postLikeButtonItem;
@property (nonatomic, strong) UIBarButtonItem *postDislikeButtonItem;
@property (nonatomic, strong) UIBarButtonItem *postWatchedButtonItem;
@property (nonatomic, strong) UIBarButtonItem *postWatchlistButtonItem;
@property (nonatomic, strong) UIBarButtonItem *deleteLikeButtonItem;
@property (nonatomic, strong) UIBarButtonItem *deleteDislikeButtonItem;
@property (nonatomic, strong) UIBarButtonItem *deleteWatchedButtonItem;
@property (nonatomic, strong) UIBarButtonItem *deleteWatchlistButtonItem;

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

    UIBarButtonItem *barSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    self.postLikeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Like" style:0 target:self action:@selector(postLikeAction)];
    self.postDislikeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dislike" style:0 target:self action:@selector(postDislikeAction)];
    self.postWatchedButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Watched" style:0 target:self action:@selector(postWatchedAction)];
    self.postWatchlistButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Watchlist" style:0 target:self action:@selector(postWatchlistAction)];
    
    self.deleteLikeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:self action:@selector(deleteLikeAction)];
    self.deleteDislikeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:self action:@selector(deleteDislikeAction)];
    self.deleteWatchedButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:self action:@selector(deleteWatchedAction)];
    self.deleteWatchlistButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:0 target:self action:@selector(deleteWatchlistAction)];

    self.postToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.height - 137.0, self.view.width, 44.0)];
    [self.postToolBar setItems:@[barSpace, self.postLikeButtonItem, self.postDislikeButtonItem, self.postWatchedButtonItem, self.postWatchlistButtonItem, barSpace]];
    
    self.deleteToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.height - 93.0, self.view.width, 44.0)];
    [self.deleteToolBar setItems:@[barSpace, self.deleteLikeButtonItem, barSpace, self.deleteDislikeButtonItem, barSpace, self.deleteWatchedButtonItem, barSpace, self.deleteWatchlistButtonItem, barSpace]];
    
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


#pragma mark - Post Actions
- (void)postLikeAction
{
    [[CFAPI shared] postUserLike:[CFUser shared].user movie:self.movie];
}

- (void)postDislikeAction
{
    [[CFAPI shared] postUserDislike:[CFUser shared].user movie:self.movie];
}

- (void)postWatchedAction
{
    [[CFAPI shared] postUserWatched:[CFUser shared].user movie:self.movie];
}

- (void)postWatchlistAction
{
    [[CFAPI shared] postUserWatchlist:[CFUser shared].user movie:self.movie];
}

#pragma mark - Delete Actions
- (void)deleteLikeAction
{
    [[CFAPI shared] deleteUserLike:[CFUser shared].user movie:self.movie];
}

- (void)deleteDislikeAction
{
    [[CFAPI shared] deleteUserDislike:[CFUser shared].user movie:self.movie];
}

- (void)deleteWatchedAction
{
    [[CFAPI shared] deleteUserWatched:[CFUser shared].user movie:self.movie];
}

- (void)deleteWatchlistAction
{
    [[CFAPI shared] deleteUserWatchlist:[CFUser shared].user movie:self.movie];
}


#pragma mark - CFAPI Delegate
- (void)apiDeleteMovieSuccess
{
    [[[UIAlertView alloc] initWithTitle:@"Success" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)apiPostUserLikeSuccess
{
    [self alertViewSuccessWithTitle:@"Like"];
}

- (void)apiPostUserDislikeSuccess
{
    [self alertViewSuccessWithTitle:@"Dislike"];
}

- (void)apiPostUserWatchedSuccess
{
    [self alertViewSuccessWithTitle:@"Watched"];
}

- (void)apiPostUserWatchlistSuccess
{
    [self alertViewSuccessWithTitle:@"Watchlist"];
}

- (void)apiDeleteUserLikeSuccess
{
    [self alertViewSuccessWithTitle:@"DELETE Like"];
}

- (void)apiDeleteUserDislikeSuccess
{
    [self alertViewSuccessWithTitle:@"DELETE Dislike"];
}

- (void)apiDeleteUserWatchedSuccess
{
    [self alertViewSuccessWithTitle:@"DELETE Watched"];
}

- (void)apiDeleteUserWatchlistSuccess
{
    [self alertViewSuccessWithTitle:@"DELETE Watchlist"];
}

- (void)apiDeletingMovieFailedWithError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error debugDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}


#pragma mark - Success
- (void)alertViewSuccessWithTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ success", title] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

@end
