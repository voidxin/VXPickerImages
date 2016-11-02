//
//  VXPickerImage.h
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VXPickerImageNavController.h"
#import "VXPhotoAlbumController.h"
#import "VXImageModel.h"
@interface VXPickerImage : NSObject
@property(nonatomic,assign)NSInteger maxCount;
- (VXPickerImageNavController *)returnPickerImageView;
@end
