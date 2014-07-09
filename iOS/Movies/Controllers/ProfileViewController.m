//
//  ProfileViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddUserViewController.h"
#import "UserMoviesViewController.h"
#import "CFUser.h"
#import "CFAPI.h"

static NSString *kProfileCellIdentifier = @"kProfileCellIdentifier";

typedef NS_ENUM(NSInteger, ProfileCellType) {
    ProfileCellTypeLikes,
    ProfileCellTypeDislikes,
    ProfileCellTypeWatched,
    ProfileCellTypeWishlist
};

@interface ProfileViewController () <AddUserDelegate, UITableViewDataSource, UITableViewDelegate, CFAPIDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIBarButtonItem *addUserBarButtonIdem;
@property (nonatomic, strong) UIBarButtonItem *deleteUserBarButtonIdem;


@end

@implementation ProfileViewController

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
    
    self.navigationItem.title = @"Profile";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.addUserBarButtonIdem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUserAction)];
    self.deleteUserBarButtonIdem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteUserAction)];
    
    self.navigationItem.rightBarButtonItem = self.addUserBarButtonIdem;
    
    [CFAPI shared].delegate = self;
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

#pragma mark - UIBarButton
- (void)addUserAction
{
    AddUserViewController *addUserVC = [[AddUserViewController alloc] init];
    addUserVC.delegate = self;
    UINavigationController *addUserNav = [[UINavigationController alloc] initWithRootViewController:addUserVC];
    
    [self.tabBarController presentViewController:addUserNav animated:YES completion:^{}];
}

- (void)deleteUserAction
{
    [[CFAPI shared] deleteUser:[CFUser shared].user];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CFUser shared].user ? 4 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfileCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kProfileCellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row == ProfileCellTypeLikes){
        cell.textLabel.text = @"Likes";
        cell.detailTextLabel.text = [CFUser shared].user.likes ? [NSString stringWithFormat:@"%@", [CFUser shared].user.likes]: @"no data";
    }
    else if(indexPath.row == ProfileCellTypeDislikes){
        cell.textLabel.text = @"Dislikes";
        cell.detailTextLabel.text = [CFUser shared].user.dislikes ? [NSString stringWithFormat:@"%@", [CFUser shared].user.dislikes]: @"no data";
    }
    else if(indexPath.row == ProfileCellTypeWatched){
        cell.textLabel.text = @"Watched";
        cell.detailTextLabel.text = [CFUser shared].user.watched ? [NSString stringWithFormat:@"%@", [CFUser shared].user.watched]: @"no data";
    }
    else if(indexPath.row == ProfileCellTypeWishlist){
        cell.textLabel.text = @"Watchlist";
        cell.detailTextLabel.text = [CFUser shared].user.watchlist ? [NSString stringWithFormat:@"%@", [CFUser shared].user.watchlist]: @"no data";
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
    
    if(indexPath.row == ProfileCellTypeLikes){
        moviesType = MoviesTypeLikes;
    }
    else if(indexPath.row == ProfileCellTypeDislikes){
        moviesType = MoviesTypeDislikes;
    }
    else if(indexPath.row == ProfileCellTypeWatched){
        moviesType = MoviesTypeWatched;
    }
    else if(indexPath.row == ProfileCellTypeWishlist){
        moviesType = MoviesTypeWishlist;
    }
    
    UserMoviesViewController *userMovieVC = [[UserMoviesViewController alloc] initWithUser:[CFUser shared].user MoviesType:moviesType];
    [self.navigationController pushViewController:userMovieVC animated:YES];
}


#pragma mark - Refresh Control
- (void)refreshControlAction
{
    [[CFAPI shared] fetchUser:[CFUser shared].user];
}

#pragma mark - AddUser Delegate
- (void)addUserSuccess:(User *)user
{
    [CFUser shared].user = user;
    
    self.title = user.username;
    self.navigationController.tabBarItem.title = nil;
    self.navigationItem.rightBarButtonItem = self.deleteUserBarButtonIdem;
    
    [self.tableView reloadData];
}


#pragma mark - CFAPI Delegate
- (void)apiFetchUser:(User *)user
{
    [CFUser shared].user = user;
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)apiDeleteUserSuccess
{
    self.navigationItem.rightBarButtonItem = self.addUserBarButtonIdem;
    self.title = @"Profile";
    self.navigationController.tabBarItem.title = nil;
    
    [CFUser shared].user = nil;
    [self.tableView reloadData];
    
    [[[UIAlertView alloc] initWithTitle:@"Success" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

@end
