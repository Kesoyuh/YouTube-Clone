//
//  CustomImageView.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "CustomImageView.h"

static NSCache *imageCache;

@implementation CustomImageView

- (void)loadImageWithURLString:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    self.imageURLString = urlString;
    
    if (imageCache == nil) {
        imageCache = [[NSCache alloc] init];
    }

    if ([imageCache objectForKey:urlString]) {
        self.image = [imageCache objectForKey:urlString];
        return;
    }


    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"%@", error);
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            //To prevent the images are loaded in the wrong cell by checking if url remains same
            if ([self.imageURLString isEqualToString:urlString]) {
                UIImage *imageToCache = [UIImage imageWithData:data];
                [imageCache setObject:imageToCache forKey:urlString];
                self.image = imageToCache;
            }
        });

    }];
    [task resume];
}

@end
