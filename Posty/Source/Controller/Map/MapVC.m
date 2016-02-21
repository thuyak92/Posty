//
//  MapVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "MapVC.h"
#import "LibLocation.h"
#import "PostMapCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"

@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Do any additional setup after loading the view.
    [_cvPost registerNib:[UINib nibWithNibName:@"PostMapCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self setLocation];
    _listPosts = [[NSMutableArray alloc] init];
    if (![Lib checkLogin]) {
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [app showLogin];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [[LibRestKit share] getObjectsAtPath:URL_POST forClass:CLASS_POST];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    search = [Lib loadDataWithKey:KEY_SEARCH];
    if (search == nil) {
        search = [Lib setSearchDefault];
    }
    [self setLocation];
}

- (void)setLocation
{
    search.name = [[LibLocation shareLocation] locationName];
    [_lblLocation setText:search.name];
    [_lblDistance setText:[NSString stringWithFormat:@"%.0fkm", search.distance]];
    if (search.name.length == 0) {
        [self performSelector:@selector(setLocation) withObject:nil afterDelay:1];
    } else {
        [Lib saveData:search forKey:KEY_SEARCH];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - action

- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnSeachSpot) {
        [Lib saveData:search forKey:KEY_SEARCH];
        [self performSegueWithIdentifier:SEGUE_MAP_TO_SEARCH sender:nil];
    }
}

#pragma mark - Google Map
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    
}

- (BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView {
    return YES;
}

- (void)zoomMap:(GMSMapView *)theMap toPosts:(NSArray *)posts
{
    double maxLat = [[posts valueForKeyPath:@"@max.latitude.doubleValue"] doubleValue] + 0.01;
    double maxLon = [[posts valueForKeyPath:@"@max.longitude.doubleValue"] doubleValue] + 0.01;
    
    double minLat = [[posts valueForKeyPath:@"@min.latitude.doubleValue"] doubleValue] - 0.01;
    double minLon = [[posts valueForKeyPath:@"@min.longitude.doubleValue"] doubleValue] - 0.01;
    
    CLLocationCoordinate2D  northEast = CLLocationCoordinate2DMake(maxLat, maxLon);
    CLLocationCoordinate2D  southWest = CLLocationCoordinate2DMake(minLat, minLon);
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast coordinate:southWest];
    GMSCameraPosition *camera = [_mapView cameraForBounds:bounds insets:UIEdgeInsetsZero];
    _mapView.camera = camera;
}

- (void)configGmap
{
    for (PostModel *post in _listPosts) {
#warning T config for post
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(post.latitude, post.longitude);
        GMSMarker *place = [GMSMarker markerWithPosition:position];
        place.title = post.locationName;
        place.snippet = post.user.nickname;
        [Lib getImageFromUrl:post.thumbnailUrl callback:^(NSData *data) {
            place.icon = [UIImage imageWithData:data];
        }];
        place.map = _mapView;
    }
    _mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        _mapView.myLocationEnabled = YES;
    });
    [self zoomMap:_mapView toPosts:_listPosts];
}

#pragma mark - Collection View
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listPosts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostMapCell *cell = (PostMapCell*)[_cvPost dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    PostModel *post = _listPosts[indexPath.row];
    [cell.imvAvatar.layer setMasksToBounds:YES];
    [cell.imvAvatar.layer setCornerRadius:15];
    [cell.imvPost sd_setImageWithURL:[NSURL URLWithString:post.imageUrl]
                    placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
    
    [cell.imvAvatar sd_setImageWithURL:[NSURL URLWithString:post.user.avatarUrl]
                      placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
    [cell.lblName setText:post.user.nickname];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:SEGUE_MAP_TO_DETAIL sender:_listPosts[indexPath.row]];
}

#pragma mark - RestKit Delegate
- (void)onGetObjectsSuccess:(LibRestKit *)controller data:(NSArray *)objects
{
    _listPosts = [[NSMutableArray alloc] initWithArray:objects];
    [_cvPost reloadData];
    [self configGmap];
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

@end
