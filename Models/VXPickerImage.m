//
//  VXPickerImage.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPickerImage.h"
@implementation VXPickerImage

- (VXPickerImageNavController *)returnPickerImageView{
   
    VXPhotoAlbumController *photoAlbumVC = [[VXPhotoAlbumController alloc] init];
    photoAlbumVC.title = @"选择照片";
    photoAlbumVC.maxCount = self.maxCount;
    VXPickerImageNavController *navController = [[VXPickerImageNavController alloc]initWithRootViewController:photoAlbumVC];
    return navController;
}

- (NSInteger)maxCount{
    if (!_maxCount) {
        _maxCount = 9;
    }
    return _maxCount;
}

@end
