//
//  VXPickerCollectionView.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPickerCollectionView.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation VXPickerCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
         self.photoImageView.frame = self.contentView.bounds;
         self.stateImageView.frame = CGRectMake(self.contentView.frame.size.width-25, 5, 20, 20);
         [self.contentView addSubview:self.photoImageView];
        [self.photoImageView addSubview:self.stateImageView];
    }
    return self;
}

- (void)setPickerModel:(VXPickerModel *)pickerModel{
    _pickerModel = pickerModel;
    ALAsset *result = pickerModel.result;
    [self.photoImageView setImage:[UIImage imageWithCGImage:[result thumbnail]]];
    
    if (pickerModel.state == STATE_COMMON) {
        [_stateImageView setImage:[UIImage imageNamed:@"icon_image_no"]];
    }else{
        [_stateImageView setImage:[UIImage imageNamed:@"icon_image_yes"]];
    }
    
}

- (UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc]init];
        [_stateImageView setImage:[UIImage imageNamed:@"icon_image_no"]];
       
    }
    return _stateImageView;
}

- (UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView=[[UIImageView alloc]init];
       // [_photoImageView setImage:[UIImage imageNamed:@"zl_camera"]];
    }
    return _photoImageView;
}
@end
