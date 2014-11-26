//
//  KFPersonCenterViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFPersonCenterViewController.h"

@interface KFPersonCenterViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property(nonatomic,strong)UIImagePickerController * photoPicker;


@end

@implementation KFPersonCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.userPhotoBG.layer  setCornerRadius:CGRectGetWidth(self.userPhotoBG.bounds)/2.0];
    [self.userPhoto.layer  setCornerRadius:CGRectGetWidth(self.userPhoto.bounds)/2.0];
    
}



#pragma mark -  点击

- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)logout:(UIButton *)sender {
    
    [KFSBHelper changeWindowRootVCToAfterLogin:NO orToLoginVC:YES];
}



- (IBAction)photoClick:(UITapGestureRecognizer *)sender {

    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];

}



#pragma mark -
#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [%ld]",(long)buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                self.photoPicker = [[UIImagePickerController alloc] init];
                self.photoPicker.delegate = self;
                self.photoPicker.allowsEditing = YES;
                self.photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //            [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController: self.photoPicker animated:YES completion:nil];
                
            }else{
            
                [KFSBHelper simpleAlertTitle:nil message:@"像机不可用" cancel:nil];
            }
            
            
        }
            break;
        case 1://本地相簿
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                self.photoPicker = [[UIImagePickerController alloc] init];
                self.photoPicker.delegate = self;
                self.photoPicker.allowsEditing = YES;
                self.photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //            [self presentModalViewController:imagePicker animated:YES];
                
//                UIView * cameraOverlayView = [UIView ]
                
                [self presentViewController: self.photoPicker animated:YES completion:nil];
                
            }else{
                
                [KFSBHelper simpleAlertTitle:nil message:@"相册不可用" cancel:nil];
            }
            
            
           
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
//        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
//        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
//    }
//    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
//        NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
//        self.fileData = [NSData dataWithContentsOfFile:videoPath];
//    }
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
 
    self.userPhoto.image = selfPhoto;
}

// 改变图像的尺寸，方便上传服务器 // desprice
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
