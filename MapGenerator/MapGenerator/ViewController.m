//
//  ViewController.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/8.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "ViewController.h"
#import "MGMapUnity.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self viewToImage:self.view];
    
    [MGMapUnity createWithCoordinate:CGPointZero inRegion:nil];
}

-(NSImage *)viewToImage:(NSView *)m_view
{
//    //    焦点锁定
//    [m_view lockFocus];
    //    生成所需图片
    NSImage *image = [[NSImage alloc]initWithData:[m_view dataWithPDFInsideRect:[m_view bounds]]];
//    [m_view unlockFocus];
    
    //   保存图片到本地
    [image lockFocus];
    NSBitmapImageRep *bits = [[NSBitmapImageRep alloc]initWithFocusedViewRect:[m_view bounds]];
    [image unlockFocus];
    //    设置要用到的props属性
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:NSImageCompressionFactor];
    //    转化为Data保存
    NSData *imageData = [bits representationUsingType:NSPNGFileType properties:imageProps];
    //    保存路径必须是绝对路径相对路径不行
    BOOL res =  [imageData writeToFile:[[NSString alloc]initWithFormat:@"%@/test%d.png", [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TestDatas"], 1] atomically:YES];
    
    
    
//    NSLog(@"%hhd", res);
    
    return image;
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
