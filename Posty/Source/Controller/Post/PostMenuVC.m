//
//  PostMenuVC.m
//  Posty
//
//  Created by phuongthuy on 6/11/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostMenuVC.h"
#import "Lib.h"
#import "LibRestKit.h"
#import "PostModel.h"
#import "PostCell.h"
#import "DetailVC.h"
#import "UserModel.h"

@interface PostMenuVC ()

@end

@implementation PostMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_cvPost registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellWithReuseIdentifier:@"postCell"];
    self.title = MENU_TITLE[_status];
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [[LibRestKit share] getObjectsAtPath:[self createSearchRequest] forClass:CLASS_POST success:^(id objects) {
        listPosts = [NSMutableArray arrayWithArray:objects];
        [_cvPost reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
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

- (NSString *)createSearchRequest
{
    UserModel *userInfo = [Lib currentUser];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(_status), @"status",
                            @(userInfo.userId), @"user_id",
                            nil];
    NSString *searchUrl = [Lib addQueryStringToUrlString: URL_SEARCH withDictionary:params];
    NSLog(@"search = %@", searchUrl);
    return searchUrl;
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return listPosts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = (PostCell*)[_cvPost dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    PostModel *post = listPosts[indexPath.row];
    [cell initWithPost:post];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailVC *vc = [[UIStoryboard storyboardWithName:@"Detail" bundle:nil] instantiateViewControllerWithIdentifier:@"Detail"];
    vc.post = listPosts[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)onBackBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
