//
//  AddMovieViewController.h
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMovieDelegate <NSObject>

@optional
- (void)addMovieSuccess;
@end

@interface AddMovieViewController : UIViewController

@property (nonatomic, weak) id<AddMovieDelegate> delegate;

@end
