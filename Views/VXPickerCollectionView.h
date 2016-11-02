//
//  VXPickerCollectionView.h
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VXPickerModel.h"
@interface VXPickerCollectionView : UICollectionViewCell
@property(nonatomic,strong)UIImageView *photoImageView;
//选择状态
@property(nonatomic,strong)UIImageView *stateImageView;

@property(nonatomic,strong)VXPickerModel *pickerModel;
@end
