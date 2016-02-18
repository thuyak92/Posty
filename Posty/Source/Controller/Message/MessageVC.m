//
//  MessageVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "MessageVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ListCell.h"
#import "MessageModel.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LibRestKit share].delegate = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [[LibRestKit share] getObjectsAtPath:URL_USER forClass:CLASS_USER];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [ListCell createView];
    UserModel *user = listUsers[indexPath.row];
    MessageModel *firstMess = [user.messages objectAtIndex:0];
    cell.title.text = user.nickname;
    cell.lblTime.text = [Lib stringFromDate:firstMess.time formatter:DATE_FORMAT];
    cell.subTitle.text = (NSString *)[firstMess.messages objectAtIndex:0];
//    [cell.imv.layer setMasksToBounds:YES];
//    [cell.imv.layer setCornerRadius:15];
    [cell.imv sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]
                      placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedUser = listUsers[indexPath.row];
#warning send request to get list message at pass
    
}

#pragma mark - RestKit

- (void)onGetObjectsSuccess:(LibRestKit *)controller data:(NSArray *)objects
{
    listUsers = [NSMutableArray arrayWithArray:objects];
    [_tableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

@end
