//
//  FeedCell.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/21/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "FeedCell.h"
#import "VideoCollectionViewCell.h"

@interface FeedCell ()


@end

@implementation FeedCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupCollectionView];
        
        [self fetchVideo];
    }
    return self;
}

- (void)fetchVideo {
    NSString *url = @"https://s3-us-west-2.amazonaws.com/youtubeassets/home.json";
    [Video fetchVideosWithURL:url completionHandler:^(NSArray *videos) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videos = videos;
            [self.collectionView reloadData];
        });
    }];
}

- (void)setupCollectionView {
    [self addSubview:self.collectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": self.collectionView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0]|" options:0 metrics:nil views:@{@"v0": self.collectionView}]];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - Datasource and delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCollectionViewCell *cell = (VideoCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];

    cell.video = self.videos[indexPath.item];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float height = (self.frame.size.width - 32) * 9.0 / 16.0 + 88;
    return CGSizeMake(self.frame.size.width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - Getter
- (NSArray *)videos {
    if (!_videos) {
        _videos = [[NSArray alloc] init];
    }
    return _videos;
}


@end
