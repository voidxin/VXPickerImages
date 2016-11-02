//
//  UIButton+VX.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/2.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "UIButton+VX.h"

@implementation UIButton (VX)
- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    !enabled ? ([self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal]) : ([self setTitleColor:[[UIColor alloc] initWithRed:35/255.f green:87/255.f blue:255/255.f alpha:1] forState:UIControlStateNormal]);
}
@end
