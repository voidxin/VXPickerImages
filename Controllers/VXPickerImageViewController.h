//
//  VXPickerImageViewController.h
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface VXPickerImageViewController : UIViewController
@property(nonatomic,strong)ALAssetsGroup *assetGroup;
@property(nonatomic,assign)NSInteger maxCount;
@end
