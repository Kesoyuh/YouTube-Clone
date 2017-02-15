//
//  UIImage.h
//  YouTubeClone
//
//  Created by Changchang Wang on 2/15/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadImage)

@property (nonatomic, strong) NSCache *imageCache;

- (void)loadImageWithURLString:(NSString *)urlString;

@end
