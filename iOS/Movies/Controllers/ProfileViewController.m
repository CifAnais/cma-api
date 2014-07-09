//
//  ProfileViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 07/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddUserViewController.h"
#import "CFUser.h"

@interface ProfileViewController () <AddUserDelegate>

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUserAction)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([CFUser shared].user){
        self.title = [CFUser shared].user.username;
    }
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


#pragma mark - AddUser Delegate
- (void)addUserSuccess:(User *)user
{
    self.title = user.username;
    self.navigationController.tabBarItem.title = nil;
    
    // Reload tableview
}

@end
