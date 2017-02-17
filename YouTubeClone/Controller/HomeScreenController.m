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
#import "Video.h"

@interface HomeScreenController ()

@property (strong, nonatomic) UIView *menuBar;
@property (strong, nonatomic) NSArray *videos;
@property (strong, nonatomic) SettingLauncher *settingLauncher;

@end

@implementation HomeScreenController

@synthesize videos=_videos;

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
    
    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    
    [self setupMenuBar];
    [self setupNavBarButton];
    
    [Video fetchVideosWithCompletionHandler:^(NSArray *videos) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videos = videos;
        });
        
    }];
    
    self.settingLauncher = [[SettingLauncher alloc] init];
    
}

- (void)setupMenuBar {
    
    [self.view addSubview:self.menuBar];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": self.menuBar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0(50)]" options:0 metrics:nil views:@{@"v0": self.menuBar}]];
}

- (void)setupNavBarButton {
    UIImage *searchImage = [[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *moreImage = [[UIImage imageNamed:@"more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithImage:searchImage style:UIBarButtonItemStylePlain target:self action:@selector(handleSearch)];
    UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithImage:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(handleMore)];
    self.navigationItem.rightBarButtonItems = @[moreBarButtonItem, searchBarButtonItem];
}

- (void)handleSearch {
    NSLog(@"%@", @"touching search button");
}

- (void)handleMore {
    
    [self.settingLauncher showSettingMenu];
   
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCollectionViewCell *cell = (VideoCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.video = self.videos[indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float height = (self.view.frame.size.width - 32) * 9.0 / 16.0 + 88;
    return CGSizeMake(self.view.frame.size.width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIView *)menuBar {
    if (!_menuBar) {
        _menuBar = [[MenuBar alloc] init];
        _menuBar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _menuBar;
}

- (NSArray *)videos {
    if (!_videos) {
        _videos = [[NSArray alloc] init];
    }
    return _videos;
}

- (void)setVideos:(NSArray *)videos {
    _videos = videos;
    [self.collectionView reloadData];
}


@end
