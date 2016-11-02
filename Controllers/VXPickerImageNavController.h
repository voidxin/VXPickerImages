//
//  VXPickerImageNavController.h
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VXPickerImageNavControllerDelegate <NSObject>
- (void)selectImageComplete:(NSMutableArray *)dataArray;
@end
@interface VXPickerImageNavController : UINavigationController
@property(nonatomic,weak)id <VXPickerImageNavControllerDelegate> pickerDelegate;
@property(nonatomic,assign)NSInteger maxCount;
@end
