//
//  AddMovieViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 08/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "AddMovieViewController.h"
#import "AddMovieGenreViewController.h"
#import "Movie.h"
#import "Genre.h"
#import "CFAPI.h"

static NSString *kAddMovieCellIdentifier = @"kAddMovieCellIdentifier";

@interface AddMovieViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, AddMovieGenreDelegate, CFAPIDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIAlertView *successAlertView;
@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) Genre *genre;

@end

@implementation AddMovieViewController

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
    
    self.title = @"Add movie";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.movie = [Movie new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [CFAPI shared].delegate = self;
}

#pragma mark - BarButtonItem
- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)doneAction
{
    [[CFAPI shared] postMovie:self.movie Genre:self.genre];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddMovieCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kAddMovieCellIdentifier];
    }
    
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    
    if(indexPath.row == 0 || indexPath.row == 1){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15.0, 1.0, self.view.width - 22.0, cell.height - 2.0)];
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.delegate = self;
        textField.tag = indexPath.row;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        if(indexPath.row == 0){
            textField.placeholder = @"Title";
            textField.returnKeyType = UIReturnKeyNext;
        }
        else{
            textField.placeholder = @"Cover URL";
            textField.returnKeyType = UIReturnKeyDone;
        }
        
        [cell addSubview:textField];
    }
    else if(indexPath.row == 2){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"Genre";
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
    
    if(indexPath.row == 2){
        AddMovieGenreViewController *addMovieGenreVC = [[AddMovieGenreViewController alloc] init];
        addMovieGenreVC.genre = self.genre;
        addMovieGenreVC.delegate = self;
        
        [self.navigationController pushViewController:addMovieGenreVC animated:YES];
    }
}


#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag == 0){
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        for(id subviews in cell.subviews){
            if([subviews isKindOfClass:[UIView class]]){
                for(UIView *subview in ((UIView *)subviews).subviews){
                    if([subview isKindOfClass:[UITextField class]]){
                        [subview becomeFirstResponder];
                    }
                }
            }
        }
    }
    else{
        [textField resignFirstResponder];
    }
    
    [self dataValidation];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.tag == 0){
        self.movie.title = textField.text;
    }
    else if(textField.tag == 1){
        self.movie.coverURL = textField.text;
    }
    
    [self dataValidation];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(textField.tag == 0){
        self.movie.title = @"";
    }
    else if(textField.tag == 1){
        self.movie.coverURL = @"";
    }
    
    [self dataValidation];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 0){
        self.movie.title = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    }
    else if(textField.tag == 1){
        self.movie.coverURL = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    }
    
    [self dataValidation];
    
    return YES;
}


#pragma mark - Data
- (void)dataValidation
{
    BOOL valid = YES;
    
    if(self.movie.title.length < 3){
        valid = NO;
    }
    else if(!self.genre){
        valid = NO;
    }
    
    self.navigationItem.rightBarButtonItem.enabled = valid;
}


#pragma mark - AddMovieGenre Delegate
- (void)selectedGenre:(Genre *)genre
{
    self.genre = genre;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.detailTextLabel.text = genre.name;
    
    [self dataValidation];
}


#pragma mark - CFAPI Delegate
- (void)apiPostMovieSuccess:(Movie *)movie
{
    if([self.delegate respondsToSelector:@selector(addMovieSuccess)]){
        [self.delegate addMovieSuccess];
    }
    
    self.successAlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[movie debugDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    self.successAlertView.delegate = self;
    [self.successAlertView show];
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
