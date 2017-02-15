//
//  VideoCollectionViewCell.h
//  YouTubeClone
//
//  Created by Changchang on 12/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LoadImage.h"
#import "Video.h"

@interface VideoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) Video *video;

@end
