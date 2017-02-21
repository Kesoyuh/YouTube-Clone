//
//  MenuBar.h
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeScreenController;
@interface MenuBar : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) HomeScreenController *homeScreenController;
@property (strong, nonatomic) NSLayoutConstraint *horizontalBarLeftAnchorConstraint;

@end
