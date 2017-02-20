//
//  ViewController.h
//  YouTubeClone
//
//  Created by Changchang on 4/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingLauncher.h"

@interface HomeScreenController : UICollectionViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

- (void)showControllerForSetting:(Setting *)setting;

@end

