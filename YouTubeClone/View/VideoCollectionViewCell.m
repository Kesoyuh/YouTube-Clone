//
//  VideoCollectionViewCell.m
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@interface VideoCollectionViewCell ()

@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *titleLableView;
@property (strong, nonatomic) UITextView *subtitleTextView;

@end

@implementation VideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.thumbnailImageView];
    [self addSubview:self.separatorView];
    [self addSubview:self.profileImageView];
    [self addSubview:self.titleLableView];
    [self addSubview:self.subtitleTextView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[v0]-16-|" options:0 metrics:nil views:@{@"v0": self.thumbnailImageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[v0(44)]" options:0 metrics:nil views:@{@"v0": self.profileImageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:@{@"v0": self.separatorView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|" options:0 metrics:nil views:@{@"v0": self.thumbnailImageView, @"v1": self.profileImageView, @"v2": self.separatorView}]];
    
    //title lable constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.thumbnailImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:8]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.thumbnailImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:20]];
    
    //subtitle constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLableView attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.thumbnailImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:30]];
    
    
}

#pragma mark - Setter
- (void)setVideo:(Video *)video {
    _video = video;
    self.titleLableView.text = video.title;
    self.thumbnailImageView.image = [UIImage imageNamed:video.thumbnailImageName];
    self.profileImageView.image = [UIImage imageNamed:video.channel.profileImageName];

}

#pragma mark - Getter
-(UIImageView *)thumbnailImageView {
    if(!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc] init];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnailImageView.clipsToBounds = YES;
        _thumbnailImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _thumbnailImageView;
}

-(UIView *)separatorView {
    if(!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
        _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _separatorView;
}

-(UIImageView *)profileImageView {
    if(!_profileImageView) {
        _profileImageView = [[UIImageView alloc] init];
//        _profileImageView.image = [UIImage imageNamed:@"one-republic-icon"];
        _profileImageView.layer.cornerRadius = 22;
        _profileImageView.layer.masksToBounds = YES;
        _profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _profileImageView;
}

-(UILabel *)titleLableView {
    if(!_titleLableView) {
        _titleLableView = [[UILabel alloc] init];
//        _titleLableView.text = @"OneRepublic - Let's Hurt Tonight";
        _titleLableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLableView;
}

-(UITextView *)subtitleTextView {
    if(!_subtitleTextView) {
        _subtitleTextView = [[UITextView alloc] init];
        _subtitleTextView.text = @"OneRepublicVEVO • 23,000,000 views • 2 months ago";
        _subtitleTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0);
        _subtitleTextView.textColor = [UIColor lightGrayColor];
    }
    return _subtitleTextView;
}

@end
