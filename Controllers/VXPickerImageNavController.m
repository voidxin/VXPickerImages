//
//  VXPickerImageNavController.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPickerImageNavController.h"
#import "VXPhotoAlbumController.h"
@interface VXPickerImageNavController ()

@end

@implementation VXPickerImageNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeSender:) name:@"pickerImageCompleted" object:nil];
    //

    
}
- (void)completeSender:(NSNotification *)nfi{
    NSDictionary *dic = nfi.userInfo;
    NSMutableArray *dataArray = [dic objectForKey:@"data"];
    if ([self.pickerDelegate respondsToSelector:@selector(selectImageComplete:)]) {
        [self.pickerDelegate selectImageComplete:dataArray];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pickerImageCompleted" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
