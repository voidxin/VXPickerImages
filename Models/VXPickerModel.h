//
//  VXPickerModel.h
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef enum{
    //正常
    STATE_COMMON,
    //选中状态
    STATE_SELECTED
}STATE;
@interface VXPickerModel : NSObject
@property(nonatomic,strong)ALAsset *result;
@property(nonatomic,assign)STATE state;
@end
