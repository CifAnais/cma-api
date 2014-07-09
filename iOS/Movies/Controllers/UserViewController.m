//
//  UserViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "UserViewController.h"
#import "UserMoviesViewController.h"
#import "CFAPI.h"

static NSString *kUserCellIdentifier = @"kUserCellIdentifier";

typedef NS_ENUM(NSInteger, UserCellType) {
    UserCellTypeLikes,
    UserCellTypeDislikes,
    UserCellTypeWatched,
    UserCellTypeWishlist
};

@interface UserViewController () <UITableViewDataSource, UITableViewDelegate, CFAPIDelegate>

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation UserViewController

- (id)initWithUser:(User *)user;
{
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.user.username;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteUserAction)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [CFAPI shared].delegate = self;
    [[CFAPI shared] fetchUser:self.user];
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
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.refreshControl endRefreshing];
}

#pragma mark - BarButtonItem
- (void)deleteUserAction
{
    [[CFAPI shared] deleteUser:self.user];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kUserCellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if(indexPath.row == UserCellTypeLikes){
        cell.textLabel.text = @"Likes";
        cell.detailTextLabel.text = self.user.likes ? [NSString stringWithFormat:@"%@", self.user.likes]: @"no data";
    }
    else if(indexPath.row == UserCellTypeDislikes){
        cell.textLabel.text = @"Dislikes";
        cell.detailTextLabel.text = self.user.dislikes ? [NSString stringWithFormat:@"%@", self.user.dislikes]: @"no data";
    }
    else if(indexPath.row == UserCellTypeWatched){
        cell.textLabel.text = @"Watched";
        cell.detailTextLabel.text = self.user.watched ? [NSString stringWithFormat:@"%@", self.user.watched]: @"no data";
    }
    else if(indexPath.row == UserCellTypeWishlist){
        cell.textLabel.text = @"Watchlist";
        cell.detailTextLabel.text = self.user.watchlist ? [NSString stringWithFormat:@"%@", self.user.watchlist]: @"no data";
    }

    CALayer *border = [[CALayer alloc] init];
    border.frame = CGRectMake(0.0, cell.height-1.0, self.view.width, 1.0);
    border.backgroundColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
    [cell.layer addSublayer:border];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MoviesType moviesType = 0;
    
    if(indexPath.row == UserCellTypeLikes){
        moviesType = MoviesTypeLikes;
    }
    else if(indexPath.row == UserCellTypeDislikes){
        moviesType = MoviesTypeDislikes;
    }
    else if(indexPath.row == UserCellTypeWatched){
        moviesType = MoviesTypeWatched;
    }
    else if(indexPath.row == UserCellTypeWishlist){
        moviesType = MoviesTypeWishlist;
    }
    
    UserMoviesViewController *userMovieVC = [[UserMoviesViewController alloc] initWithUser:self.user MoviesType:moviesType];
    [self.navigationController pushViewController:userMovieVC animated:YES];
}

#pragma mark - CFAPI Delegate
- (void)apiFetchUser:(User *)user
{
    self.user = user;
    
    [self.tableView reloadData];
}

@end
