//
//  ViewController.m
//  YouTubeClone
//
//  Created by Changchang on 4/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "HomeScreenController.h"
#import "VideoCollectionViewCell.h"
#import "MenuBar.h"

@interface HomeScreenController ()

@end

@implementation HomeScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230.0/255.0 green:32.0/255.0 blue:31.0/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 32, self.view.frame.size.width)];
    
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.text = @"Home";
    self.navigationItem.titleView = titleLable;
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    [self setupMenuBar];
    
}

- (void)setupMenuBar {
    MenuBar *menubar = [[MenuBar alloc] init];
    menubar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:menubar];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": menubar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0(50)]" options:0 metrics:nil views:@{@"v0": menubar}]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    return cell;
                                
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float height = (self.view.frame.size.width - 32) * 9.0 / 16.0 + 68;
    return CGSizeMake(self.view.frame.size.width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


@end
