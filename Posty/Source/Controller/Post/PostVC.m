//
//  PostVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostVC.h"
#import "Lib.h"
#import "PostSettingVC.h"
#import "AppDelegate.h"
#import "SearchModel.h"
#import "PostMenuVC.h"

@interface PostVC ()

@end

@implementation PostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[LibRestKit share] setDelegate:self];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app showLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:SEGUE_POST_TO_POST_SETTING]) {
        UINavigationController *nav = [segue destinationViewController];
        PostSettingVC *vc = (PostSettingVC *)[nav topViewController];
        vc.imageData = sender;
    } else if ([[segue identifier] isEqualToString:SEGUE_POST_TO_MENU_POST]) {
        UINavigationController *nav = [segue destinationViewController];
        PostMenuVC *vc = (PostMenuVC *)[nav topViewController];
        vc.status = ((NSIndexPath *)sender).row;
    }
}

- (IBAction)onButonClicked:(id)sender {
    if (sender == _btnSelectPhoto) {
        [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
        pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerLibrary.delegate = self;
        [self presentViewController:pickerLibrary animated:NO completion:^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        }];
    } else if (sender == _btnTakePhoto) {
        [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
        pickerLibrary.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerLibrary.delegate = self;
        [self presentViewController:pickerLibrary animated:NO completion:^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIImage * img = info[UIImagePickerControllerOriginalImage];
    UIImage *sqr = [Lib squareImageWithImage:img scaledToSize:CGSizeMake(414, 414)];
    NSData *image = UIImageJPEGRepresentation(sqr, 0.0);
    [self performSegueWithIdentifier:SEGUE_POST_TO_POST_SETTING sender:image];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = MENU_TITLE[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:MENU_ICON[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:SEGUE_POST_TO_MENU_POST sender:indexPath];
}

#pragma mark - RestKit Delegate

@end
