//
//  UserMoviesViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 09/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "UserMoviesViewController.h"
#import "MovieCollectionCell.h"
#import "MovieViewController.h"
#import "CFAPI.h"

@interface UserMoviesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CFAPIDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic, assign) MoviesType moviesType;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *data;

@end

@implementation UserMoviesViewController

- (id)initWithUser:(User *)user MoviesType:(MoviesType)moviesType
{
    self = [super init];
    if (self) {
        self.user = user;
        self.moviesType = moviesType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[MovieCollectionCell class] forCellWithReuseIdentifier:kMovieCollectionCellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    
    [CFAPI shared].delegate = self;
    
    if(self.moviesType == MoviesTypeLikes){
        self.title = @"Likes";
        [[CFAPI shared] fetchUserLikes:self.user];
    }
    else if(self.moviesType == MoviesTypeDislikes){
        self.title = @"Dislikes";
        [[CFAPI shared] fetchUserDislikes:self.user];
    }
    else if(self.moviesType == MoviesTypeWatched){
        self.title = @"Watched";
        [[CFAPI shared] fetchUserWatched:self.user];
    }
    else if(self.moviesType == MoviesTypeWishlist){
        self.title = @"Watchlist";
        [[CFAPI shared] fetchUserWatchlist:self.user];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [CFAPI shared].delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMovieCollectionCellIdentifier forIndexPath:indexPath];
    
    cell.movie = self.data[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kMovieCollectionCellSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    MovieViewController *movieVC = [[MovieViewController alloc] initWithMovie:(Movie *)self.data[indexPath.row]];
    [self.navigationController pushViewController:movieVC animated:YES];
}


#pragma mark - Refresh Control
- (void)refreshControlAction
{
    [[CFAPI shared] fetchUserLikes:self.user];
    if(self.moviesType == MoviesTypeLikes){
        [[CFAPI shared] fetchUserLikes:self.user];
    }
    else if(self.moviesType == MoviesTypeDislikes){
        [[CFAPI shared] fetchUserDislikes:self.user];
    }
    else if(self.moviesType == MoviesTypeWatched){
        [[CFAPI shared] fetchUserWatched:self.user];
    }
    else if(self.moviesType == MoviesTypeWishlist){
        [[CFAPI shared] fetchUserWatchlist:self.user];
    }
}

#pragma mark - CFAPI Delegate
- (void)apiFetchUserLikes:(NSArray *)movies
{
    self.data = movies;
    
    [self.refreshControl endRefreshing];
    [self.collectionView reloadData];
}

- (void)apiFetchUserDislikes:(NSArray *)movies
{
    self.data = movies;
    
    [self.refreshControl endRefreshing];
    [self.collectionView reloadData];
}

- (void)apiFetchUserWatched:(NSArray *)movies
{
    self.data = movies;
    
    [self.refreshControl endRefreshing];
    [self.collectionView reloadData];
}

- (void)apiFetchUserWatchlist:(NSArray *)movies
{
    self.data = movies;
    
    [self.refreshControl endRefreshing];
    [self.collectionView reloadData];
}

- (void)apiFetchUserMoviesError
{
    [self.refreshControl endRefreshing];
}

@end
