//
//  SettingLauncher.h
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingCell.h"

@class HomeScreenController;
@interface SettingLauncher : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) HomeScreenController *homeScreenController;

- (void)showSettingMenu;

@end
