//
//  PostMenuVC.h
//  Posty
//
//  Created by phuongthuy on 6/11/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostMenuVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *listPosts;
}
@property (assign, nonatomic) NSInteger status;

@property (weak, nonatomic) IBOutlet UICollectionView *cvPost;
- (IBAction)onBackBtnClicked:(id)sender;

@end
