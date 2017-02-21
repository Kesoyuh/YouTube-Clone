//
//  VideoCollectionViewCell.m
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@interface VideoCollectionViewCell ()

@property (strong, nonatomic) CustomImageView *thumbnailImageView;
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) CustomImageView *profileImageView;
@property (strong, nonatomic) UILabel *titleLableView;
@property (strong, nonatomic) UITextView *subtitleTextView;

@end

@implementation VideoCollectionViewCell {
    NSLayoutConstraint *titleLabelHeightConstraint;
}

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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|" options:0 metrics:nil views:@{@"v0": self.thumbnailImageView, @"v1": self.profileImageView, @"v2": self.separatorView}]];
    
    //title lable constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.thumbnailImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:8]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.thumbnailImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:20];
    [self addConstraint:titleLabelHeightConstraint];
    
    //subtitle constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLableView attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.thumbnailImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:30]];
    
    
}

#pragma mark - Setter
- (void)setVideo:(Video *)video {
    _video = video;
    
    //setup title and measuring its size
    self.titleLableView.text = video.title;
    CGRect estimateRect = [video.title boundingRectWithSize:CGSizeMake(self.frame.size.width - 16 - 44 -8 -16, 1000)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}
                              context:nil];
    if (estimateRect.size.height > 21) {
        titleLabelHeightConstraint.constant = 44;
    } else {
        titleLabelHeightConstraint.constant = 22;
    }
    
    //setup thumbnailImage and profileImage
    [self.thumbnailImageView loadImageWithURLString:self.video.thumbnailImageName];
    [self.profileImageView loadImageWithURLString:self.video.channel.profileImageName];
    
    //setup subtitle
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *subtitleString = [NSString stringWithFormat:@"%@ • %@ • 2 years ago", video.channel.name, [formatter stringFromNumber:video.numberOfViews]];
    self.subtitleTextView.text = subtitleString;
}

#pragma mark - Getter
- (CustomImageView *)thumbnailImageView {
    if(!_thumbnailImageView) {
        _thumbnailImageView = [[CustomImageView alloc] init];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnailImageView.clipsToBounds = YES;
        _thumbnailImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _thumbnailImageView;
}

- (UIView *)separatorView {
    if(!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
        _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _separatorView;
}

- (CustomImageView *)profileImageView {
    if(!_profileImageView) {
        _profileImageView = [[CustomImageView alloc] init];
        _profileImageView.layer.cornerRadius = 22;
        _profileImageView.layer.masksToBounds = YES;
        _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
        _profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _profileImageView;
}

- (UILabel *)titleLableView {
    if(!_titleLableView) {
        _titleLableView = [[UILabel alloc] init];
        _titleLableView.numberOfLines = 0;
        _titleLableView.font = [UIFont systemFontOfSize:17];
//        _titleLableView.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLableView;
}

- (UITextView *)subtitleTextView {
    if(!_subtitleTextView) {
        _subtitleTextView = [[UITextView alloc] init];
        _subtitleTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0);
        _subtitleTextView.textColor = [UIColor lightGrayColor];
    }
    return _subtitleTextView;
}

@end
