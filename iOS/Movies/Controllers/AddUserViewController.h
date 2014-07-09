//
//  AddUserViewController.h
//  Movies
//
//  Created by Aymeric Gallissot on 09/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@protocol AddUserDelegate <NSObject>

@optional
- (void)addUserSuccess:(User *)user;
@end

@interface AddUserViewController : UIViewController

@property (nonatomic, weak) id<AddUserDelegate> delegate;

@end
