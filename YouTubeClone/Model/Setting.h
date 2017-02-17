//
//  Setting.h
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;

- (instancetype)initWithName:(NSString *)name imageName:(NSString *)imageName;

@end
