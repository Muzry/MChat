//
//  QQToolsView.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageToolsView.h"
#import "UIView+Extension.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"
#import "MessageTableView.h"
#import "AFNetworking.h"
@interface MessageToolsView()<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) UITextView *textView;
@property (nonatomic,strong) UIButton *addImageBtn;

@end
@implementation MessageToolsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setImage:[UIImage resizeImageWihtImageName:@"chat_bottom_bg"]];
        [self setupBtn:@"ToolViewInputVoice" hightImage:@"ToolViewInputVoiceHL" tag:MessageToolsViewTypeSpeak];
        [self setupBtn:@"ToolViewEmotion" hightImage:@"ToolViewEmotionHL" tag:MessageToolsViewTypeEmotion];
        self.addImageBtn = [self setupBtn:@"TypeSelectorBtn_Black" hightImage:@"TypeSelectorBtn_BlackHL" tag:MessageToolsViewtypeMore];
        [self.addImageBtn addTarget:self action:@selector(pickImageClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupText];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(UIButton *)setupBtn:(NSString *)image hightImage:(NSString *)hightImage tag:(MessageToolsViewType)type;
{
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed: image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed: hightImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    btn.tag = type;
    return btn;
}

-(void)setupText
{
    UITextView *msgView = [[UITextView alloc]init];
    
    msgView.returnKeyType = UIReturnKeySend;
    msgView.delegate = self;
    msgView.enablesReturnKeyAutomatically = YES;
    msgView.backgroundColor = [UIColor whiteColor];
    msgView.font = [UIFont systemFontOfSize:15];
    msgView.contentInset = UIEdgeInsetsMake(0, 5, 0, 0);
    msgView.font = [UIFont systemFontOfSize:16];
    msgView.layer.cornerRadius = 6;
    msgView.layer.borderColor = SelfColor(185, 185, 185).CGColor;
    msgView.layer.borderWidth = 1.0f;
    msgView.height = 36;
    msgView.width = self.width - 3 * 42;
    msgView.x = 42;
    msgView.y = self.height / 2 - msgView.height / 2;
    msgView.contentSize = CGSizeMake(0, msgView.height);
    self.textView = msgView;
    [self addSubview:msgView];
}

#pragma mark 选择发送图片

-(void)pickImageClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择要发送的图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相机" otherButtonTitles:@"从相册", nil];
    [sheet showInView:self];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing = YES;
    
    if(buttonIndex == 0)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self.viewController presentViewController:imagePicker animated:YES completion:
     ^{
         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     }];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *uploadUrl = @"http://localhost/t.php";
    NSString *downloadUrl = @"http://localhost/upload/image/";
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    NSString *user = [[UserInfo sharedUserInfo].user lowercaseString];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[user stringByAppendingString:timeStr]];
    NSData *data = UIImageJPEGRepresentation(image, 0.75);

    [manager POST:uploadUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/jpeg"];
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [self sendMsgWithText:[downloadUrl stringByAppendingString:fileName] bodyType:@"image"];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
         NSLog(@"%@",error);
         NSLog(@"%@",operation.responseString);
     }];
    
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

#pragma mark TextView的代理

-(void)textViewDidChange:(UITextView *)textView
{
    CGFloat contentH = textView.contentSize.height;
    
    if ([textView.text rangeOfString:@"\n"].length != 0)
    {
        NSString *final = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self sendMsgWithText:final bodyType:@"text"];
        textView.text = @"";
    }
    if (!textView.hasText)
    {
        self.height = 42;
        self.y = 561;
        self.textView.height = 36;
        self.textView.y = self.height / 2 - self.textView.height / 2;
        self.textView.contentSize = CGSizeMake(0, self.textView.height);
    }
    else if (contentH < 97)
    {
        self.y = self.y + self.height - contentH - 6;
        self.height = contentH + 6;
        self.textView.contentSize = CGSizeMake(0, contentH);
        self.textView.height = contentH;
        self.textView.y = self.height / 2 - self.textView.height / 2;
    }
}

-(void)writeToFile
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename = [NSString stringWithFormat:@"records%@.plist",[UserInfo sharedUserInfo].user];
    [[UserInfo sharedUserInfo].msgRecordArray writeToFile:[[pathList objectAtIndex:0] stringByAppendingPathComponent:filename] atomically:YES];
}

-(void)sendMsgWithText:(NSString *)text bodyType:(NSString *)type
{
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyy-MM-dd-HH:mm";
    NSDate *date = [NSDate date];
    
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.Jid];
    [msg addAttributeWithName:@"bodyType" stringValue:type];
    [msg addBody:text];
    [msg addSubject:[fmt stringFromDate:date]];
    [[XmppTools sharedXmppTools].xmppStream sendElement:msg];
    
    newDict[@"username"] = self.Jid.bare;
    newDict[@"msgtext"] = text;
    newDict[@"time"] = [fmt stringFromDate:date];
    newDict[@"type"] = type;
    
    
    int i = 0;
    BOOL flag = NO;
    for (NSDictionary *dict in [UserInfo sharedUserInfo].msgRecordArray)
    {
        if ([dict[@"username"] isEqualToString:newDict[@"username"]])
        {
            [UserInfo sharedUserInfo].msgRecordArray[i] = newDict;
            flag = YES;
            break;
        }
        i++;
    }
    if (!flag)
    {
        [[UserInfo sharedUserInfo].msgRecordArray addObject:newDict];
    }
    
    [self writeToFile];
    NSNotification *notification =[NSNotification notificationWithName:@"SendMessage" object:nil userInfo:newDict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = 42;
    CGFloat btnH = 42;
    CGFloat textW = self.width - 3 * btnW;
    for (int i = 0;  i < count - 1; i ++)
    {
        UIButton *button = self.subviews[i];
        button.x = i * btnW;
        if (i > 0)
        {
            button.x += textW;
        }
        button.y = self.height - button.height;
        button.width = btnW;
        button.height = btnH;
    }
}

@end
