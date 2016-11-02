//
//  VXPhotoAlbumController.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPhotoAlbumController.h"
#import "VXPickerImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface VXPhotoAlbumController ()
@property(nonatomic,strong)NSMutableArray *assetDataArray;
@property(nonatomic,strong)ALAssetsLibrary *assetLibrary;
@end

@implementation VXPhotoAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBaseViews];
    [self searchPhotoAlbum];
    
}
#pragma mark addBaseViews
- (void)addBaseViews{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}
#pragma mark rightItemAction
- (void)rightItemAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 查找相册
- (void)searchPhotoAlbum{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        void(^assetGroupEnumerator)(ALAssetsGroup *,BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
            if (group == nil) {
                return;
            }
            [self.assetDataArray addObject:group];
           [self performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:YES];
        };
        void(^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:[NSString stringWithFormat:@"错误:%@-%@",[error localizedDescription],[error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        };
        [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetGroupEnumerator failureBlock:assetGroupEnumberatorFailure];
    });

}

- (void)updateView{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.assetDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ALAssetsGroup *asGroup = (ALAssetsGroup *)[self.assetDataArray objectAtIndex:indexPath.row];
    [asGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger count = [asGroup numberOfAssets];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[asGroup valueForProperty:ALAssetsGroupPropertyName],count];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup *)[self.assetDataArray objectAtIndex:indexPath.row] posterImage]]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ALAssetsGroup *asGroup = (ALAssetsGroup *)[self.assetDataArray objectAtIndex:indexPath.row];
    VXPickerImageViewController *pickVC = [[VXPickerImageViewController alloc] init];
    pickVC.title = @"选择照片";
    pickVC.assetGroup = asGroup;
    pickVC.maxCount = self.maxCount;
    [self.navigationController pushViewController:pickVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - getter
- (NSMutableArray *)assetDataArray{
    if (!_assetDataArray) {
        _assetDataArray = [[NSMutableArray alloc]init];
    }
    return _assetDataArray;
}

- (ALAssetsLibrary *)assetLibrary{
    if (!_assetLibrary) {
        _assetLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetLibrary;
}



@end
