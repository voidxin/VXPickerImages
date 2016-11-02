#一个简单干净极易使用的照片选择器
##你可以这样使用它：
1：import "VXPickerImage.h"

2: 在需要选照片的时候添加:

```
                          VXPickerImageNavController *pickerVC = [[VXPickerImage alloc] returnPickerImageView];
                          pickerVC.pickerDelegate = self;
    
                          [self presentViewController:pickerVC animated:YES completion:nil];
```

3:实现VXPickerImage的代理:

```
- (void)selectImageComplete:(NSMutableArray *)dataArray{
   //VXImageModel里面有原图和缩略图
   VXImageModel *imageModel = dataArray.lastObject;
    [self.imageView setImage:imageModel.fullScreenImage];
}
```

