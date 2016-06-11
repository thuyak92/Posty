//
//  ListPopup.m
//  Posty
//
//  Created by phuongthuy on 3/14/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "ListPopup.h"
#import "LibRestKit.h"
#import "ListCell.h"
#import "UserModel.h"
#import "PostSettingVC.h"

@interface ListPopup ()

@end

@implementation ListPopup

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil ] forCellReuseIdentifier:@"listCell"];
    [[LibRestKit share] getObjectsAtPath:URL_USER forClass:CLASS_USER success:^(id objects) {
        listFriends = [NSArray arrayWithArray:objects];
        [self.tableView reloadData];
    }];
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

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    UserModel *user = listFriends[indexPath.row];
    [cell initWithUser:user];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel *user = listFriends[indexPath.row];
    PostSettingVC *vc = (PostSettingVC *)self.parentViewController;
    vc.targetUser = user;
    [self.view removeFromSuperview];
}

@end
