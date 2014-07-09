//
//  AddUserViewController.m
//  Movies
//
//  Created by Aymeric Gallissot on 09/07/2014.
//  Copyright (c) 2014 Cifacom. All rights reserved.
//

#import "AddUserViewController.h"
#import "CFAPI.h"

static NSString *kAddUserCellIdentifier = @"kAddUserCellIdentifier";

@interface AddUserViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, CFAPIDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIAlertView *successAlertView;
@property (nonatomic, strong) User *user;

@end

@implementation AddUserViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add a user";
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
    
    self.user = [User new];
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
    [[CFAPI shared] postUser:self.user];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddUserCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAddUserCellIdentifier];
    }
    
    if(indexPath.row == 0){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15.0, 1.0, self.view.width - 22.0, cell.height - 2.0)];
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.delegate = self;
        textField.tag = indexPath.row;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.placeholder = @"Username";
        textField.returnKeyType = UIReturnKeyDone;
        
        [cell addSubview:textField];
        
        [textField becomeFirstResponder];
    }
    
    CALayer *border = [[CALayer alloc] init];
    border.frame = CGRectMake(0.0, cell.height-1.0, self.view.width, 1.0);
    border.backgroundColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
    [cell.layer addSublayer:border];
    
    return cell;
}


#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self dataValidation];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.tag == 0){
        self.user.username = textField.text;
    }
    
    [self dataValidation];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(textField.tag == 0){
        self.user.username = @"";
    }
    
    [self dataValidation];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 0){
        self.user.username = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    }
    
    [self dataValidation];
    
    return YES;
}


#pragma mark - Data
- (void)dataValidation
{
    BOOL valid = YES;
    
    if(self.user.username.length < 3){
        valid = NO;
    }
    
    self.navigationItem.rightBarButtonItem.enabled = valid;
}


#pragma mark - CFAPI Delegate
- (void)apiPostUserSuccess:(User *)user
{
    if([self.delegate respondsToSelector:@selector(addUserSuccess:)]){
        [self.delegate addUserSuccess:user];
    }

    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
