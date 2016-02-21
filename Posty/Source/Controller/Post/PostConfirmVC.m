//
//  PostConfirmVC.m
//  Posty
//
//  Created by phuongthuy on 2/21/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostConfirmVC.h"
#import "PostImageCell.h"
#import "PostInfoCell.h"
#import "AppDelegate.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface PostConfirmVC ()

@end

@implementation PostConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LibRestKit share].delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
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

#pragma mark - TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PostImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostImageCell"];
        [cell.imvPost setImage:[UIImage imageWithData:_post.image]];
        return cell;
    } else if (indexPath.section == 1) {
        PostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
        [cell.lblTime setText:[Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT]];
        [cell.txtvStatus setText:_post.textContent];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

#pragma mark - RestKit
- (void)postData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [[LibRestKit share] postObject:_post toPath:URL_POST method:RKRequestMethodPOST withData:_post.image fileName:@"image_file" forClass:CLASS_POST];
}

- (void)onPostObjectSuccess:(LibRestKit *)controller data:(id)object
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app switchToTabWithIndex:TAB_HOME];
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnBack) {
        [self dismissViewControllerAnimated:NO completion:nil];
    } else if (sender == _btnPost) {
        [self postData];
    }
}
@end
