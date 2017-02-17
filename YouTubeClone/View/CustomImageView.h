//
//  CustomImageView.h
//  YouTubeClone
//
//  Created by Changchang Wang on 2/16/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView

//To prevent the images are loaded in the wrong cell by checking if url is the same
@property (strong, nonatomic) NSString *imageURLString;

- (void)loadImageWithURLString:(NSString *)urlString;

@end
