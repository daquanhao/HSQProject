//
//  ViewController.m
//  测试demo
//
//  Created by administrator on 2018/4/6.
//  Copyright © 2018年 administrator. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "HeaderView.h"
#import "HSQCustomTextView.h"
#import "FL_Button.h"
#import "HSQCustomButton.h"
#import "HSQCustomShareView.h"
#import "HSQNavViewController.h"

@interface ViewController ()<UIAlertViewDelegate,UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(30, 100, 300, 500)];
//
//    [self.view addSubview:headerView];
//
//    [headerView CreatView];
    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
//
//    imageV.image = [UIImage imageNamed:@"jt_icon"];
//
//    [self.view addSubview:imageV];
//
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确认要删除这个宝贝" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//
//    // 传递多参数
//    objc_setAssociatedObject(alert, "suppliers_id", @"1", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    objc_setAssociatedObject(alert, "warehouse_id", @"2", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    alert.tag = [@"删除" intValue];
//    [alert show];
    
//    HSQCustomTextView *CustomTextView = [[HSQCustomTextView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -  200)/2, 88, 200, 300)];
//
//    CustomTextView.placeholder = @"请输入您的内容";
//
//     CGFloat font = 15 * [UIScreen mainScreen].bounds.size.width / 375;
//
//    CustomTextView.font = [UIFont systemFontOfSize:font];
//
//    CustomTextView.placeholderColor = [UIColor redColor];
//
//    CustomTextView.backgroundColor = [UIColor orangeColor];
//
//    CustomTextView.delegate = self;
//
//    [self.view addSubview:CustomTextView];
//
//    NSMutableDictionary *diction = [NSMutableDictionary dictionary];
//    diction[NSFontAttributeName] = [UIFont systemFontOfSize:font];
//
//    CGSize size = [CustomTextView.placeholder boundingRectWithSize:CGSizeMake(100, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:diction context:nil].size;
//
//    NSLog(@"==1111====%f==%f",size.height,size.width);
//
//
//    NSLog(@"===%f==%f==%f",font,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
//
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//
//    [btn setBackgroundColor:[UIColor redColor]];
//
//    btn.frame = CGRectMake(30, CGRectGetMaxY(CustomTextView.frame), 100, 100);
//
//    [btn setTitle:@"分享" forState:(UIControlStateNormal)];
//
//    [btn addTarget:self action:@selector(btnclickaction:) forControlEvents:(UIControlEventTouchUpInside)];
//
//    [self.view addSubview:btn];
    
    HSQCustomButton *btn = [HSQCustomButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setBackgroundColor:[UIColor orangeColor]];
    
    btn.frame = CGRectMake(100, 100, 200, 100);
    
    [btn addTarget:self action:@selector(btnclickaction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];

}

- (void)btnclickaction:(UIButton *)sender{
    
    NSLog(@"=======");
    
//    NSDictionary *diction = @{@"name":@"微信",@"icon":@"weixin"};
//    NSDictionary *diction01 = @{@"name":@"朋友圈",@"icon":@"weixin"};
//    NSDictionary *diction02 = @{@"name":@"QQ",@"icon":@"weixin"};
//    NSDictionary *diction03 = @{@"name":@"QQ空间",@"icon":@"weixin"};
//    NSDictionary *diction04 = @{@"name":@"微博",@"icon":@"weixin"};
//    NSDictionary *diction05 = @{@"name":@"QQ空间",@"icon":@"weixin"};
//    NSDictionary *diction06 = @{@"name":@"微博",@"icon":@"weixin"};
//
//    NSArray *array = @[diction,diction01,diction02,diction03,diction04,diction05,diction06];
//
//    HSQCustomShareView *ShareView = [[HSQCustomShareView alloc] init];
//
//    [ShareView showInView:[UIApplication sharedApplication].keyWindow contentArray:array];
    
    HSQNavViewController *NavVC = [[HSQNavViewController alloc] init];
    
    [self.navigationController pushViewController:NavVC animated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self performSelector:@selector(textViewDidChange:) withObject:textView afterDelay:0.1f];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGRect cursorPosition;
    
    if (textView.selectedTextRange)
    {
        cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start];
    }
    else
    {
        cursorPosition = CGRectMake(0, 0, 0, 0);
    }
    
    NSLog(@"==%@",NSStringFromCGRect(cursorPosition));
    
    // 7 plus =={{4, 7}, {2, 21.666666666666668}}  字体39.524062==67.498560

}

/**
 *  确定删除操作
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        NSString *warehouse_id = objc_getAssociatedObject(alertView, "warehouse_id");
        
        NSString *suppliers_id = objc_getAssociatedObject(alertView, "suppliers_id");
        
        NSString *recId = [NSString stringWithFormat:@"%ld",(long)alertView.tag];
        
        NSLog(@"==%@==%@==%@",warehouse_id,suppliers_id,recId);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
