//
//  MenuBar.m
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "MenuBar.h"
#import "MenuBarCell.h"
#import "HomeScreenController.h"

@interface MenuBar ()

@property (strong, nonatomic) NSArray *imageNames;
@property (strong, nonatomic) UIView *horizontalBar;

@end

@implementation MenuBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.collectionView registerClass:[MenuBarCell class] forCellWithReuseIdentifier:@"menuBarCell"];
        
        [self addSubview:self.collectionView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": self.collectionView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0]|" options:0 metrics:nil views:@{@"v0": self.collectionView}]];
        
        self.imageNames = @[@"home", @"trending", @"subscriptions", @"account"];
        
        
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView selectItemAtIndexPath:selectedIndexPath animated:NO  scrollPosition:UICollectionViewScrollPositionNone];
        
        [self setupHorizontalBar];
    }
    return self;
}

- (void)setupHorizontalBar {
    
    [self addSubview:self.horizontalBar];
    self.horizontalBarLeftAnchorConstraint = [self.horizontalBar.leftAnchor constraintEqualToAnchor:self.leftAnchor];
    self.horizontalBarLeftAnchorConstraint.active = YES;
    [self.horizontalBar.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.horizontalBar.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.25].active = YES;
    [self.horizontalBar.heightAnchor constraintEqualToConstant:5].active = YES;
}

#pragma mark - Datasources and delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuBarCell" forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:self.imageNames[indexPath.item]];
    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.tintColor = [UIColor colorWithRed:91.0/255 green:14.0/255 blue:13.0/255 alpha:1];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width / 4, self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.homeScreenController scrollToMenuIndex:indexPath.item];
}

#pragma mark - Getters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:32.0/255.0 blue:31.0/255.0 alpha:1];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIView *)horizontalBar {
    if (!_horizontalBar) {
        _horizontalBar = [[UIView alloc] init];
        _horizontalBar.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        _horizontalBar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _horizontalBar;
}
@end
