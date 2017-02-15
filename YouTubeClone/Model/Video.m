//
//  Video.m
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "Video.h"

@implementation Video

+ (void)fetchVideosWithCompletionHandler:(void (^)(NSArray *videos))handler {
    
    NSMutableArray *videos = [[NSMutableArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        for (NSDictionary *dictionary in json) {
            Video *video = [[Video alloc] init];
            video.title = dictionary[@"title"];
            video.thumbnailImageName = dictionary[@"thumbnail_image_name"];
            video.numberOfViews = dictionary[@"number_of_views"];
            
            NSDictionary *channelDictionary = dictionary[@"channel"];
            Channel *channel = [[Channel alloc] init];
            channel.name = channelDictionary[@"name"];
            channel.profileImageName = channelDictionary[@"profile_image_name"];
            
            video.channel = channel;
            
            [videos addObject:video];
        }
        handler(videos);
        
        NSLog(@"%@", videos);

    }];
    [task resume];
}

@end
