//
//  ListCell.h
//  Posty
//
//  Created by phuongthuy on 2/18/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

+ (ListCell *)createView;

@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end
