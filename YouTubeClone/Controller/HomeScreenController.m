//
//  ViewController.m
//  YouTubeClone
//
//  Created by Changchang on 4/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "HomeScreenController.h"
#import "MenuBar.h"
#import "FeedCell.h"
#import "TrendingCell.h"
#import "SubscriptionCell.h"

@interface HomeScreenController ()

@property (strong, nonatomic) MenuBar *menuBar;
@property (strong, nonatomic) SettingLauncher *settingLauncher;
@property (strong, nonatomic) NSArray *titles;

@end

@implementation HomeScreenController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230.0/255.0 green:32.0/255.0 blue:31.0/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 32, self.view.frame.size.width)];
    
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.text = @" Home";
    self.navigationItem.titleView = titleLable;
    
    
    [self setupCollectionView];
    [self setupMenuBar];
    [self setupNavBarButton];
}

- (void)setupCollectionView {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:@"FeedCell"];
    [self.collectionView registerClass:[TrendingCell class] forCellWithReuseIdentifier:@"TrendingCell"];
    [self.collectionView registerClass:[SubscriptionCell class] forCellWithReuseIdentifier:@"SubscriptionCell"];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
}

- (void)setupMenuBar {
    self.navigationController.hidesBarsOnSwipe = YES;
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:32.0/255.0 blue:31.0/255.0 alpha:1];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:redView];
    [self.view addSubview:self.menuBar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": redView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v0(50)]" options:0 metrics:nil views:@{@"v0": redView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": self.menuBar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v0(50)]" options:0 metrics:nil views:@{@"v0": self.menuBar}]];
    [self.menuBar.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor].active = YES;
}



- (void)setupNavBarButton {
    UIImage *searchImage = [[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *moreImage = [[UIImage imageNamed:@"more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithImage:searchImage style:UIBarButtonItemStylePlain target:self action:@selector(handleSearch)];
    UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithImage:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(handleMore)];
    self.navigationItem.rightBarButtonItems = @[moreBarButtonItem, searchBarButtonItem];
}

- (void)handleSearch {
    [self scrollToMenuIndex:2];
}

- (void)handleMore {
    
    [self.settingLauncher showSettingMenu];
    
}

- (void)scrollToMenuIndex:(NSInteger)menuIndex {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:menuIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    //change title
    UILabel *titleLable = (UILabel *)self.navigationItem.titleView;
    titleLable.text = self.titles[menuIndex];
}

- (void)showControllerForSetting:(Setting *)setting {
    UIViewController *settingViewController = [UIViewController new];
    settingViewController.navigationItem.title = setting.name;
    settingViewController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationController pushViewController:settingViewController animated:true];
}

#pragma mark - Datasources and delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case 1:
            return [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TrendingCell" forIndexPath:indexPath];
            break;
        case 2:
            return [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SubscriptionCell" forIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"FeedCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.menuBar.horizontalBarLeftAnchorConstraint.constant = scrollView.contentOffset.x / 4;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger index = targetContentOffset->x / self.view.frame.size.width;
    [self.menuBar.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    //change title
    UILabel *titleLable = (UILabel *)self.navigationItem.titleView;
    titleLable.text = self.titles[index];
}

#pragma mark - Getter

- (UIView *)menuBar {
    if (!_menuBar) {
        _menuBar = [[MenuBar alloc] init];
        _menuBar.translatesAutoresizingMaskIntoConstraints = NO;
        _menuBar.homeScreenController = self;
    }
    return _menuBar;
}

- (SettingLauncher *)settingLauncher {
    _settingLauncher = [[SettingLauncher alloc] init];
    _settingLauncher.homeScreenController = self;
    return _settingLauncher;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"Home", @"Trending", @"Subscriptions", @"Account"];
    }
    return _titles;
}


#pragma mark - Setter



@end
