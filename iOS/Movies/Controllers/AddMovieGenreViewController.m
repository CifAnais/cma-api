//
//  AddMovieGenreViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "AddMovieGenreViewController.h"
#import "CFAPI.h"

static NSString *kAddMovieGenreCellIdentifier = @"kAddMovieGenreCellIdentifier";

@interface AddMovieGenreViewController () <UITableViewDataSource, UITableViewDelegate, CFAPIDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *data;

@end

@implementation AddMovieGenreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Select a genre";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [CFAPI shared].delegate = self;
    [[CFAPI shared] fetchGenres];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddMovieGenreCellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAddMovieGenreCellIdentifier];
    }
    
    Genre *genre = (Genre *)self.data[indexPath.row];
    cell.textLabel.text = [genre.name lowercaseString];
    
    if(self.genre){
        if([genre.genreId isEqualToNumber:self.genre.genreId]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.delegate respondsToSelector:@selector(selectedGenre:)]){
        [self.delegate selectedGenre:(Genre *)self.data[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Refresh Control
- (void)refreshControlAction
{
    [[CFAPI shared] fetchGenres];
}


#pragma mark - CFAPI Delegate
- (void)apiFetchGenres:(NSArray *)genres
{
    self.data = genres;
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

@end
