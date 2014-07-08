//
//  UserViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (nonatomic, strong) User *user;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end