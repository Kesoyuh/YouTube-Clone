//
//  UIImage.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/15/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "UIImageView+LoadImage.h"
#import <objc/runtime.h>

static void *ImageCacheKey = &ImageCacheKey;
@implementation UIImageView (LoadImage)

- (void)loadImageWithURLString:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    if (self.imageCache == nil) {
        self.imageCache = [[NSCache alloc] init];
    }
    NSLog(@"%@", [self.imageCache objectForKey:urlString]);
    
    if ([self.imageCache objectForKey:urlString]) {
        self.image = [self.imageCache objectForKey:urlString];
        return;
    }
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *imageToCache = [UIImage imageWithData:data];
            [self.imageCache setObject:imageToCache forKey:urlString];
            self.image = imageToCache;
        });
        
    }];
    [task resume];
}

- (void)setImageCache:(NSCache *)imageCache {
    objc_setAssociatedObject(self, ImageCacheKey, imageCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSCache *)imageCache {
    return objc_getAssociatedObject(self, ImageCacheKey);
}

@end
