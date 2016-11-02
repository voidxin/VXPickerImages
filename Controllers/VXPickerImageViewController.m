//
//  VXPickerImageViewController.m
//  VXPickerImage
//
//  Created by voidxin on 16/11/1.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

#import "VXPickerImageViewController.h"
#import "VXPickerCollectionView.h"
#import "VXPickerModel.h"
#import "VXPickerBottomView.h"
#import "VXPhotosScrollView.h"
#import "UIButton+VX.h"
#import "VXImageModel.h"
#define kCELL_Width (self.view.bounds.size.width - 3) / 4
#define kBOTTOMVIEW_HEIGHT 50
@interface VXPickerImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)VXPickerBottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableSet *selectDataSet;
@end

@implementation VXPickerImageViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBaseViews];
    
    [self addAssetImage];
    
    [self calculatePhotoCount];
    
    
}
#pragma mark  addBaseViews
- (void)addBaseViews{
    self.collectionView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - kBOTTOMVIEW_HEIGHT);
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.view.frame.size.width, kBOTTOMVIEW_HEIGHT);
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    self.bottomView.overViewBtn.userInteractionEnabled = YES;
    self.bottomView.completedBtn.userInteractionEnabled = YES;
    [self.bottomView.overViewBtn addTarget:self action:@selector(overViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.completedBtn addTarget:self action:@selector(completedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
#pragma mark rightItemAction
- (void)rightItemAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark bottomView btn action
- (void)overViewBtnAction{
    VXPhotosScrollView *scrollView = [[VXPhotosScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    scrollView.dataArray = [[self.selectDataSet allObjects] mutableCopy];
    [self.navigationController.view addSubview:scrollView];
}
- (void)completedBtnAction{
   //发送通知到VXPickerImage
    NSMutableArray *dataArray = [[self.selectDataSet allObjects] mutableCopy];
    NSMutableArray *selectImageArray = [[NSMutableArray alloc]init];
    for (VXPickerModel *model in dataArray) {
        ALAssetRepresentation *rep = [model.result defaultRepresentation];
        CGImageRef fullResImage = [rep fullScreenImage];
        UIImage *image = [UIImage imageWithCGImage:fullResImage];
         CGImageRef refthumbnail = [model.result thumbnail];
        UIImage *thumbnail = [UIImage imageWithCGImage:refthumbnail];
        VXImageModel *imageModel = [[VXImageModel alloc] init];
        imageModel.fullScreenImage = image;
        imageModel.thumbnail = thumbnail;
        [selectImageArray addObject:imageModel];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickerImageCompleted" object:nil userInfo:@{@"data":selectImageArray}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark  addAssetImage
- (void)addAssetImage{
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (!result) {
            return ;
        }
        VXPickerModel *model = [[VXPickerModel alloc] init];
        model.result = result;
        [self.dataArray addObject:model];
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   VXPickerCollectionView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   VXPickerModel *model = self.dataArray[indexPath.row];
   cell.pickerModel = model;
   return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    VXPickerModel *model = self.dataArray[indexPath.row];
    
    [self stateControlWith:model];
    //计算当前选择的照片数量
    [self calculatePhotoCount];
    
    [self.collectionView reloadData];

}
- (void)stateControlWith:(VXPickerModel *)model{
    switch (model.state) {
        case STATE_COMMON:
            if (![self checkCount]) {
                [self showMessageView];
                return;
            }
            model.state = STATE_SELECTED;
            
            [self.selectDataSet addObject:model];
            break;
        case STATE_SELECTED:
            model.state = STATE_COMMON;
            [self.selectDataSet removeObject:model];
            break;
        default:
            break;
    }
    
   
}

- (void)showMessageView{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message: [NSString stringWithFormat:@"最多只能选择%ld张照片",self.maxCount] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (BOOL)checkCount{
    if (self.maxCount <= [self.selectDataSet allObjects].count) {
        return false;
    }
    return  true;
}
#pragma mark <计算选中的照片的数量>
- (void)calculatePhotoCount{
    NSInteger photoCount = self.selectDataSet.count;
    [self.bottomView.completedBtn setTitle:[NSString stringWithFormat:@"完成(%ld)",photoCount] forState:UIControlStateNormal];
    self.selectDataSet.count > 0 ? ({
        self.bottomView.overViewBtn.enabled = YES;
        self.bottomView.completedBtn.enabled = YES;
    }) : ({
        self.bottomView.overViewBtn.enabled = NO;
        self.bottomView.completedBtn.enabled = NO;
    });
    
        
    
}
#pragma mark <getter>
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout alloc];
        layout.itemSize = CGSizeMake(kCELL_Width, kCELL_Width);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = 0;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.userInteractionEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[VXPickerCollectionView class] forCellWithReuseIdentifier:reuseIdentifier];
        
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableSet *)selectDataSet{
    if (!_selectDataSet) {
        _selectDataSet = [[NSMutableSet alloc]init];
    }
    return _selectDataSet;
}

- (VXPickerBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[VXPickerBottomView alloc]init];
    }
    return _bottomView;
}

@end
