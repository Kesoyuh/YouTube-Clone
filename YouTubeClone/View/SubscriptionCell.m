//
//  SubscriptionCell.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/21/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "SubscriptionCell.h"
#import "Video.h"

@implementation SubscriptionCell

- (void)fetchVideo {
    NSString *url = @"https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json";
    [Video fetchVideosWithURL:url completionHandler:^(NSArray *videos) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videos = videos;
            [self.collectionView reloadData];
        });
    }];
}

@end
