//
//  SettingCell.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()

@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UIImageView *iconImageView;


@end

@implementation SettingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.nameLable];
    [self addSubview:self.iconImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[v0(20)]-16-[v1]|" options:0 metrics:nil views:@{@"v0": self.iconImageView, @"v1": self.nameLable}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0]|" options:0 metrics:nil views:@{@"v0": self.nameLable}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v0(20)]" options:0 metrics:nil views:@{@"v0": self.iconImageView}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

#pragma mark - Getter
- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLable.font = [UIFont systemFontOfSize:15];
    }
    return _nameLable;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconImageView;
}

#pragma mark - Setter
- (void)setSetting:(Setting *)setting {
    _setting = setting;
    self.nameLable.text = _setting.name;
    self.iconImageView.image = [[UIImage imageNamed:_setting.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.iconImageView.tintColor = [UIColor darkGrayColor];
}

//Highlight the menu when selected.
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? [UIColor darkGrayColor] : [UIColor whiteColor];
    self.nameLable.textColor = highlighted ? [UIColor whiteColor] : [UIColor blackColor];
    self.iconImageView.tintColor = highlighted ? [UIColor whiteColor] : [UIColor darkGrayColor];
}

@end
