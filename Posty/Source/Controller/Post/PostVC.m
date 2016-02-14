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

@interface PostVC ()

@end

@implementation PostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    switch (indexPath.row) {
        case MENU_RECEIVED:
            [cell.imageView setImage:[UIImage imageNamed:@"menuReceived.png"]];
            cell.textLabel.text = @"受信ポスト";
            break;
        case MENU_DELAY:
            [cell.imageView setImage:[UIImage imageNamed:@"menuDelay.png"]];
            cell.textLabel.text = @"送信予定ポスト（日時設定あり）";
            break;
        case MENU_SAVE:
            [cell.imageView setImage:[UIImage imageNamed:@"menuSave.png"]];
            cell.textLabel.text = @"下書きポスト";
            break;
        case MENU_SEND:
            [cell.imageView setImage:[UIImage imageNamed:@"menuSend.png"]];
            cell.textLabel.text = @"送信済みポスト";
            break;
        case MENU_TRASH:
            [cell.imageView setImage:[UIImage imageNamed:@"menuTrash.png"]];
            cell.textLabel.text = @"ゴミ箱";
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end
