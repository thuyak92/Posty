//
//  SearchSpotVC.h
//  Posty
//
//  Created by phuongthuy on 2/21/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

#define TYPE_CURRENT_LOCATION   0
#define TYPE_OTHER_LOCATION     1

@interface SearchSpotVC : UITableViewController<RestKitLibDelegate, UITextFieldDelegate>
{
    SearchModel *search;
    UILabel *lblSlider;
}

//Spot
@property (weak, nonatomic) IBOutlet UIButton *btnCurLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnOtherLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnReload;
- (IBAction)onSpotButtonClicked:(id)sender;
- (IBAction)onLocationButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfLocation;

//slider
@property (weak, nonatomic) IBOutlet UISlider *sliderDistance;
- (IBAction)onSliderChangedValue:(id)sender;

//Commit
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onBtnCommitClicked:(id)sender;

@end
