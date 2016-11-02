//
//  VXPhotosScrollView.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPhotosScrollView.h"
#import "VXPickerModel.h"
@implementation VXPhotosScrollView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseSetter];
       
    }
    return self;
}
- (void)baseSetter{
    
    self.showsVerticalScrollIndicator = false;
    self.delegate = self;
    self.pagingEnabled = YES;
    self.minimumZoomScale = 1.0;
    self.bounces = NO;
    self.backgroundColor = [UIColor blackColor];
}




- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSInteger i = 0;
    for (VXPickerModel *model in dataArray) {
        /*
         这里把alasset转成image时速度很慢，当选择的图片数量够大的时候需等待很久才能加载出这个页面，所以目前限制只能选9张图片，这里还需要优化
         图片查看时占时还不支持缩放，动画效果还没有加上，后期还要优化加上
        */
        UIImageView *imageView = [[UIImageView alloc]init];
        ALAssetRepresentation *rep = [model.result defaultRepresentation];
        CGImageRef fullResImage = [rep fullScreenImage];
        UIImage *image = [UIImage imageWithCGImage:fullResImage];
        [imageView setImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i * width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tapGesture];
        i++;
        
    }
    self.contentSize = CGSizeMake(width * dataArray.count, [UIScreen mainScreen].bounds.size.height);
    

}




- (void)tapAction:(UITapGestureRecognizer *)tap{

    [self performSelector:@selector(tap) withObject:self afterDelay:0.5];
   
    
}
- (void)tap{
    //消失的动画效果还需要添加
     [self removeFromSuperview];
}

@end
