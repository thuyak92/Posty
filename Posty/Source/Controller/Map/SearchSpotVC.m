//
//  SearchSpotVC.m
//  Posty
//
//  Created by phuongthuy on 2/21/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "SearchSpotVC.h"
#import "LibLocation.h"
#import "MapVC.h"

@interface SearchSpotVC ()

@end

@implementation SearchSpotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btnBack.png"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self initSliderLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    search = [Lib loadDataWithKey:KEY_SEARCH];
    [_txtfLocation setText:search.name];
    [self setDefaultSearch];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self getSearchData];
    [Lib saveData:search forKey:KEY_SEARCH];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init data
- (void)initSliderLabel
{
    [_sliderDistance setThumbImage:[UIImage imageNamed:@"iconSlider.png"] forState:0];
    lblSlider = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 45, 14)];
    [lblSlider setText:[NSString stringWithFormat:@"%.0fkm", _sliderDistance.value]];
    [lblSlider setFont:[UIFont systemFontOfSize:13]];
    [lblSlider setTextAlignment:NSTextAlignmentCenter];
    [_sliderDistance addSubview:lblSlider];
}

- (void)setDefaultSearch
{
    [self setLocation];
    [self setDistance];
}

#pragma mark - config

- (void)setLocation
{
    [_btnCurLoc setSelected:NO];
    [_btnOtherLoc setSelected:NO];
    [_btnReload setHidden:YES];
    [_txtfLocation setEnabled:NO];
    [_txtfLocation setBackground:[UIImage imageNamed:@""]];
    if (search.spot == TYPE_CURRENT_LOCATION) {
        [_btnCurLoc setSelected:YES];
        [_btnReload setHidden:NO];
    } else if (search.spot == TYPE_OTHER_LOCATION) {
        [_btnOtherLoc setSelected:YES];
        [_txtfLocation setEnabled:YES];
        [_txtfLocation setBackground:[UIImage imageNamed:@"btnGreyBorderSqr.png"]];
    }
    [_sliderDistance setValue:search.distance];
    
}

- (void)setDistance
{
    CGRect trackRect = [_sliderDistance trackRectForBounds:_sliderDistance.bounds];
    CGRect thumbRect = [_sliderDistance thumbRectForBounds:_sliderDistance.bounds
                                                 trackRect:trackRect
                                                     value:_sliderDistance.value];
    
    lblSlider.center = CGPointMake(thumbRect.origin.x + _sliderDistance.frame.origin.x + 20,  _sliderDistance.frame.origin.y + 37);
    [lblSlider setText:[NSString stringWithFormat:@"%.0fkm", _sliderDistance.value]];
}

#pragma mark - action

- (IBAction)onSpotButtonClicked:(id)sender {
    search.spot = ((UIButton *)sender).tag;
    [self setLocation];
}

- (IBAction)onLocationButtonClicked:(id)sender {
    if (sender == _btnReload) {
        [_txtfLocation setText:search.name];
    }
}

- (IBAction)onSliderChangedValue:(id)sender {
    [self setDistance];
}

- (IBAction)onBtnCommitClicked:(id)sender {
    if (sender == _btnCancel) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        [[LibRestKit share] getObjectsAtPath:[self createSearchRequest] forClass:CLASS_POST success:^(id objects) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            UINavigationController *nav = (UINavigationController *)self.parentViewController;
            MapVC *vc = (MapVC *)nav.parentViewController;
            vc.listPosts = [NSMutableArray arrayWithArray: objects];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

#pragma mark - RestKit

- (void)getSearchData
{
    if (search.spot == TYPE_OTHER_LOCATION) {
        if (search.name.length == 0) {
            [Lib showAlertTitle:nil message:@"住所を入力してください。"];
        }
    } else {
        search.longitude = [[LibLocation shareLocation] longitude];
        search.latitude = [[LibLocation shareLocation] latitude];
        search.name = @"";
    }
    search.distance = _sliderDistance.value;
}

- (NSString *)createSearchRequest
{
    [self getSearchData];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(search.distance), @"distance",
                            @(search.longitude), @"longitude",
                            @(search.latitude), @"latitude",
                            search.name, @"name",
                            nil];
    NSString *searchUrl = [Lib addQueryStringToUrlString: URL_SEARCH withDictionary:params];
    NSLog(@"search = %@", searchUrl);
    return searchUrl;
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
