//
//  TabBarViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "TabBarViewController.h"
#import "MoviesViewController.h"
#import "ExploreUsersViewController.h"
#import "ProfileViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
    
    MoviesViewController *moviesVC = [[MoviesViewController alloc] init];
    UINavigationController *moviesNav = [[UINavigationController alloc] initWithRootViewController:moviesVC];
    moviesNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    moviesNav.tabBarItem.image = [UIImage imageNamed:@"tabBar-movie-icon"];
    
    ExploreUsersViewController *exploreVC = [[ExploreUsersViewController alloc] init];
    UINavigationController *exploreNav = [[UINavigationController alloc] initWithRootViewController:exploreVC];
    exploreNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    exploreNav.tabBarItem.image = [UIImage imageNamed:@"tabBar-explore-icon"];
    
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profileVC];
    profileNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    profileNav.tabBarItem.image = [UIImage imageNamed:@"tabBar-profile-icon"];
    
    self.viewControllers = @[profileNav, exploreNav, moviesNav];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
