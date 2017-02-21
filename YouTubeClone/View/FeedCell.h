//
//  FeedCell.h
//  YouTubeClone
//
//  Created by Changchang Wang on 2/21/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UICollectionViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *videos;
@property (strong, nonatomic) UICollectionView *collectionView;

- (void)fetchVideo;

@end
