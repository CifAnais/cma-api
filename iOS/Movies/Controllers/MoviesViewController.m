//
//  MoviesViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCollectionCell.h"
#import "CFAPI.h"

@interface MoviesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,CFAPIDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *data;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Movies";
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
	[[CFAPI shared] fetchMovies];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [CFAPI shared].delegate = self;
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


#pragma mark - Refresh Control
- (void)refreshControlAction
{
    [[CFAPI shared] fetchMovies];
}


#pragma mark - CFAPI Delegate
- (void)apiFetchingMovies:(NSArray *)movies
{
    self.data = movies;
    
    [self.refreshControl endRefreshing];
    
    [self.collectionView reloadData];
}

- (void)apiFetchingMoviesFailedWithError:(NSError *)error
{
    NSLog(@"apiFetchingMoviesFailedWithError");
    
    [self.refreshControl endRefreshing];
}

@end
