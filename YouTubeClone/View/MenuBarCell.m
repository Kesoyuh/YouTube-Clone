//
//  MenuBarCell.m
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "MenuBarCell.h"

@interface MenuBarCell ()


@end

@implementation MenuBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.imageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[v0(28)]" options:0 metrics:nil views:@{@"v0": self.imageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v0(28)]" options:0 metrics:nil views:@{@"v0": self.imageView}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.imageView.tintColor = selected ? [UIColor whiteColor] : [UIColor colorWithRed:91.0/255 green:14.0/255 blue:13.0/255 alpha:1];
}

@end
