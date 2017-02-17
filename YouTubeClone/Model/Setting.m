//
//  Setting.m
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "Setting.h"

@implementation Setting

- (instancetype)initWithName:(NSString *)name imageName:(NSString *)imageName {
    if ((self = [super init])) {
        _name = name;
        _imageName = imageName;
    }
    
    return self;
}

@end
