//
//  FriendsVC.m
//  Posty
//
//  Created by phuongthuy on 7/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "FriendsVC.h"
#import "UserModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ListCell.h"

@interface FriendsVC ()

@end

@implementation FriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    listFriends = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [[LibRestKit share] getObjectsAtPath:URL_USER forClass:CLASS_USER success:^(id objects) {
        listFriends = [NSMutableArray arrayWithArray:objects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return listFriends.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        searchBar = [[UISearchBar alloc] init];
        searchBar.delegate = self;
        searchBar.placeholder = @"ポストモを検索";
        [searchBar setFrame:cell.frame];
        [cell addSubview:searchBar];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
#warning T create invitePostyBtn and createGroupBtn
        return cell;
    } else {
        ListCell *cell = [ListCell createView];
        if (indexPath.section == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.imv setImage:[UIImage imageNamed:@"iconPrivacy1.png"]];
            cell.title.text = [NSString stringWithFormat:@"公式アカウント(%ld)", countPublic];
            cell.subTitle.text = @"ポストモ登録してる公式アカウントはこちら";
        } else if (indexPath.section == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.imv setImage:[UIImage imageNamed:@"iconPrivacy0.png"]];
            cell.title.text = [NSString stringWithFormat:@"グループ(%ld)", countGroup];
            cell.subTitle.text = @"参加しているグループはこちら";
        } else if (indexPath.section == 4) {
            UserModel *user = listFriends[indexPath.row];
            [cell initWithUser:user];
            cell.subTitle.text = user.comment;
        }
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"nickname like '%@'", searchText];
    [listFriends filterUsingPredicate:pred];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

@end
