//
//  SettingLauncher.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "SettingLauncher.h"
#import "HomeScreenController.h"

@interface SettingLauncher ()

@property (strong, nonatomic) UIView *blackBackGroundView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *settings;

@end

@implementation SettingLauncher


- (instancetype)init {
    self = [super init];
    if (self) {
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.settings = ({
            @[[[Setting alloc] initWithName:@"Settings" imageName:@"settings"],
              [[Setting alloc] initWithName:@"Terms & privacy policy" imageName:@"privacy"],
              [[Setting alloc] initWithName:@"Send feedback" imageName:@"feedback"],
              [[Setting alloc] initWithName:@"Help" imageName:@"help"],
              [[Setting alloc] initWithName:@"Switch account" imageName:@"account-setting"],
              [[Setting alloc] initWithName:@"Cancel" imageName:@"cancel"]];
        });
    }
    return self;
}

- (void)showSettingMenu {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    [window addSubview:self.blackBackGroundView];
    [window addSubview:self.collectionView];
    self.blackBackGroundView.frame = window.frame;
    self.blackBackGroundView.alpha = 0;
    
    CGFloat height = 300;
    CGFloat y = window.frame.size.height - height;
    self.collectionView.frame = CGRectMake(0, window.frame.size.height, window.frame.size.width, height);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.blackBackGroundView.alpha = 1;
        self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);

    } completion:nil];

}

- (void)handleDismiss {
    [self handleDismissWithCompletionHandler:nil];
}

- (void)handleDismissWithCompletionHandler:(nullable void (^)(BOOL finished)) handler {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.blackBackGroundView.alpha = 0;
        self.collectionView.frame = CGRectMake(0, window.frame.size.height, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    } completion:handler];

}

#pragma mark - Datasource and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.settings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"settingCell" forIndexPath:indexPath];
    cell.setting = self.settings[indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self handleDismissWithCompletionHandler:^(BOOL finished) {
        Setting *setting = self.settings[indexPath.item];
        if (![setting.name isEqual:@"Cancel"]) {
            [self.homeScreenController showControllerForSetting:setting];
        }
    }];
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SettingCell class] forCellWithReuseIdentifier:@"settingCell"];
    }
    return _collectionView;
}

- (UIView *)blackBackGroundView {
    if (!_blackBackGroundView) {
        _blackBackGroundView = [[UIView alloc] init];
        _blackBackGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_blackBackGroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismiss)]];
    }
    return _blackBackGroundView;
}

@end
