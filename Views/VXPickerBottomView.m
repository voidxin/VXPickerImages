//
//  VXPickerBottomView.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPickerBottomView.h"

@implementation VXPickerBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor alloc]initWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1];
       
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
     [self addBaseViews];
}
#pragma mark - addViews
- (void)addBaseViews{
    
    self.overViewBtn.frame = CGRectMake(15,(self.frame.size.height-30) / 2,60, 30);
   
    self.completedBtn.frame = CGRectMake(self.frame.size.width-95, (self.frame.size.height-30) / 2, 80, 30);
    
    
    [self addSubview:self.overViewBtn];
    [self addSubview:self.completedBtn];
    
}



#pragma mark - getter
- (UIButton *)overViewBtn{
    if (!_overViewBtn) {
        _overViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_overViewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_overViewBtn setTitleColor:[[UIColor alloc] initWithRed:35/255.f green:87/255.f blue:255/255.f alpha:1] forState:UIControlStateNormal];
        _overViewBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _overViewBtn;
}
- (UIButton *)completedBtn{
    if (!_completedBtn) {
        _completedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_completedBtn setTitle:@"完成(0)" forState:UIControlStateNormal];
        _completedBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_completedBtn setTitleColor:[[UIColor alloc] initWithRed:35/255.f green:87/255.f blue:255/255.f alpha:1] forState:UIControlStateNormal];
        _completedBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _completedBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _completedBtn;
}

@end
