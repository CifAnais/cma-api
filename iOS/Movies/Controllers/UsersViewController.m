//
//  UsersViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "UsersViewController.h"
#import "UserViewController.h"
#import "CFAPI.h"
#import "User.h"

static NSString *kExploreUserCellIdentifier = @"kExploreUserCellIdentifier";

@interface UsersViewController () <UITableViewDataSource, UITableViewDelegate, CFAPIDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *data;

@end

@implementation UsersViewController

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
    
    self.navigationItem.title = @"Users";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [[CFAPI shared] fetchUsers];
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


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kExploreUserCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kExploreUserCellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = ((User *)self.data[indexPath.row]).username;
    
    CALayer *border = [[CALayer alloc] init];
    border.frame = CGRectMake(0.0, cell.height-1.0, self.view.width, 1.0);
    border.backgroundColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
    [cell.layer addSublayer:border];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserViewController *userVC = [[UserViewController alloc] initWithUser:(User *)self.data[indexPath.row]];
    [self.navigationController pushViewController:userVC animated:YES];
}


#pragma mark - Refresh Control
- (void)refreshControlAction
{
    [[CFAPI shared] fetchUsers];
}


#pragma mark - CFAPI Delegate
- (void)apiFetchUsers:(NSArray *)users
{
    self.data = users;
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)apiFetchingUsersFailedWithError:(NSError *)error
{
    NSLog(@"apiFetchingUsersFailedWithError");
    [self.refreshControl endRefreshing];
}

@end
