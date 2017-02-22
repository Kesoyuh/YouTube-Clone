//
//  VideoLauncher.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/22/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoLauncher.h"
#import "VideoPlayer.h"

@implementation VideoLauncher

- (void)showVideoPlayer {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *view = [[UIView alloc] init];
    VideoPlayer *videoPlayer = [[VideoPlayer alloc] initWithFrame:CGRectMake(0, 0, keyWindow.frame.size.width, keyWindow.frame.size.width * 9 / 16)];
    
    [keyWindow addSubview:view];
    [view addSubview:videoPlayer];
    
    view.frame = CGRectMake(keyWindow.frame.size.width - 10, keyWindow.frame.size.height - 10, 10, 10);
    view.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = keyWindow.frame;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
    
    
}

@end
