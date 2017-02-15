//
//  Video.h
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Channel.h"

@interface Video : NSObject

@property (strong, nonatomic) NSString *thumbnailImageName;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *numberOfViews;
@property (strong, nonatomic) NSDate *uploadDate;

@property (strong, nonatomic) Channel *channel;

+ (void)fetchVideosWithCompletionHandler:(void (^)(NSArray *videos))handler;


@end
