//
//  VideoPlayer.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/22/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "VideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIButton *pausePlayButton;
@property (strong, nonatomic) UILabel *videoLengthLable;
@property (strong, nonatomic) UILabel *currentTimeLable;
@property (strong, nonatomic) UISlider *videoSlider;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic, getter=isPlaying) BOOL playing;

@end

@implementation VideoPlayer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        [self setupPlayer];
        [self setupGradientLayer];
        [self setupControlsContainer];
        
        
    }
    return self;
}

- (void)setupControlsContainer {
    self.controlsContainerView.frame = self.frame;
    [self addSubview:self.controlsContainerView];
    
    [self.controlsContainerView addSubview:self.activityIndicator];
    [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.controlsContainerView.centerXAnchor].active = YES;
    [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.controlsContainerView.centerYAnchor].active = YES;
    
    [self.controlsContainerView addSubview:self.pausePlayButton];
    [self.pausePlayButton.centerXAnchor constraintEqualToAnchor:self.controlsContainerView.centerXAnchor].active = YES;
    [self.pausePlayButton.centerYAnchor constraintEqualToAnchor:self.controlsContainerView.centerYAnchor].active = YES;
    [self.pausePlayButton.widthAnchor constraintEqualToConstant:40].active = YES;
    [self.pausePlayButton.heightAnchor constraintEqualToConstant:40].active = YES;
    
    [self.controlsContainerView addSubview:self.videoLengthLable];
    [self.videoLengthLable.rightAnchor constraintEqualToAnchor:self.controlsContainerView.rightAnchor constant:-8].active = YES;
    [self.videoLengthLable.bottomAnchor constraintEqualToAnchor:self.controlsContainerView.bottomAnchor constant:-3].active = YES;
    [self.videoLengthLable.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.videoLengthLable.heightAnchor constraintEqualToConstant:24].active = YES;
    
    [self.controlsContainerView addSubview:self.currentTimeLable];
    [self.currentTimeLable.leftAnchor constraintEqualToAnchor:self.controlsContainerView.leftAnchor constant:8].active = YES;
    [self.currentTimeLable.bottomAnchor constraintEqualToAnchor:self.controlsContainerView.bottomAnchor constant:-3].active = YES;
    [self.currentTimeLable.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.currentTimeLable.heightAnchor constraintEqualToConstant:24].active = YES;
    
    [self.controlsContainerView addSubview:self.videoSlider];
    [self.videoSlider.rightAnchor constraintEqualToAnchor:self.videoLengthLable.leftAnchor].active = YES;
    [self.videoSlider.bottomAnchor constraintEqualToAnchor:self.controlsContainerView.bottomAnchor].active = YES;
    [self.videoSlider.leftAnchor constraintEqualToAnchor:self.currentTimeLable.rightAnchor].active = YES;
    [self.videoSlider.heightAnchor constraintEqualToConstant:30].active = YES;
}

- (void)setupPlayer {
    NSURL *url = [NSURL URLWithString:@"https://firebasestorage.googleapis.com/v0/b/tbc-chat.appspot.com/o/demo.mp4?alt=media&token=16e7afa6-8fe4-48bc-991e-9ea3d15833da"];
    self.player = [[AVPlayer alloc] initWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:playerLayer];
    playerLayer.frame = self.frame;
    [self.player play];
    
    [self.player addObserver:self forKeyPath:@"currentItem.loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 2) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float seconds = CMTimeGetSeconds(time);
        
        weakSelf.currentTimeLable.text = [NSString stringWithFormat:@"%02d:%02d", (int) seconds / 60, (int) seconds % 60];
        
        CMTime duration = weakSelf.player.currentItem.duration;
        float durationSeconds = CMTimeGetSeconds(duration);
        weakSelf.videoSlider.value = seconds / durationSeconds;
    }];
}

- (void)setupGradientLayer {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.bounds;
    
    gradientLayer.colors = [NSArray arrayWithObjects:(id) [UIColor clearColor].CGColor, (id) [UIColor blackColor].CGColor, nil];
    gradientLayer.locations = @[@0.7, @1.2];
    [self.controlsContainerView.layer addSublayer:gradientLayer];
    
}

- (void)handlePause {
    if (self.isPlaying) {
        [self.player pause];
        [self.pausePlayButton setImage:[UIImage imageNamed:@"play-button"] forState:UIControlStateNormal];
    } else {
        [self.player play];
        [self.pausePlayButton setImage:[UIImage imageNamed:@"pause-button"] forState:UIControlStateNormal];
    }
    self.playing = !self.isPlaying;
}

- (void)handleSliderChange {
    CMTime duration = self.player.currentItem.duration;
    float totalSeconds = CMTimeGetSeconds(duration);
    float seekSeconds = totalSeconds * self.videoSlider.value;
    CMTime seekTime = CMTimeMake(seekSeconds, 1);
    [self.player seekToTime:seekTime completionHandler:^(BOOL finished) {
        
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentItem.loadedTimeRanges"]) {
        [self.activityIndicator stopAnimating];
        self.controlsContainerView.backgroundColor = [UIColor clearColor];
        self.pausePlayButton.hidden = NO;
        self.playing = YES;
        
        CMTime duration = self.player.currentItem.duration;
        float seconds = CMTimeGetSeconds(duration);
        self.videoLengthLable.text = [NSString stringWithFormat:@"%02d:%02d", (int) seconds / 60, (int) seconds % 60];
    }
}

#pragma mark - Getter
- (UIView *)controlsContainerView {
    if (!_controlsContainerView) {
        _controlsContainerView = [[UIView alloc] init];
        _controlsContainerView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    }
    return _controlsContainerView;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [_activityIndicator startAnimating];
    }
    return _activityIndicator;
}

- (UIButton *)pausePlayButton {
    if (!_pausePlayButton) {
        _pausePlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *image = [UIImage imageNamed:@"pause-button"];
        [_pausePlayButton setImage:image forState:UIControlStateNormal];
        _pausePlayButton.tintColor = [UIColor whiteColor];
        _pausePlayButton.translatesAutoresizingMaskIntoConstraints = NO;
        _pausePlayButton.hidden = YES;
        [_pausePlayButton addTarget:self action:@selector(handlePause) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pausePlayButton;
}

- (UILabel *)videoLengthLable {
    if (!_videoLengthLable) {
        _videoLengthLable = [[UILabel alloc] init];
        _videoLengthLable.text = @"00:00";
        _videoLengthLable.textColor = [UIColor whiteColor];
        _videoLengthLable.translatesAutoresizingMaskIntoConstraints = NO;
        _videoLengthLable.font = [UIFont boldSystemFontOfSize:13];
        _videoLengthLable.textAlignment = NSTextAlignmentRight;
    }
    return _videoLengthLable;
}

- (UILabel *)currentTimeLable {
    if (!_currentTimeLable) {
        _currentTimeLable = [[UILabel alloc] init];
        _currentTimeLable.text = @"00:00";
        _currentTimeLable.textColor = [UIColor whiteColor];
        _currentTimeLable.translatesAutoresizingMaskIntoConstraints = NO;
        _currentTimeLable.font = [UIFont boldSystemFontOfSize:13];
    }
    return _currentTimeLable;
}

- (UISlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider = [[UISlider alloc] init];
        _videoSlider.translatesAutoresizingMaskIntoConstraints = NO;
        _videoSlider.minimumTrackTintColor = [UIColor redColor];
        _videoSlider.maximumTrackTintColor = [UIColor whiteColor];
        [_videoSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
        [_videoSlider addTarget:self action:@selector(handleSliderChange) forControlEvents:UIControlEventValueChanged];
    }
    return _videoSlider;
}




@end
