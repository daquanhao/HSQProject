//
//  HSQNavViewController.m
//  测试demo
//
//  Created by administrator on 2018/4/10.
//  Copyright © 2018年 administrator. All rights reserved.
//

#define KNavBarHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 88 : 64)

#import "HSQNavViewController.h"
#import "HSQCustomNavBar.h"

@interface HSQNavViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *Bgimage;

@property (nonatomic, strong) HSQCustomNavBar *NavBar;

@property (nonatomic, assign) CGRect Orgin_Frame;

@end

@implementation HSQNavViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setHidden:YES];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3-1P106112Q1-51"]];
    image.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.7);
    self.Orgin_Frame = image.frame;
    [self.view addSubview:image];
    self.Bgimage =image;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.7 - KNavBarHeight)];
    bgView.backgroundColor = [UIColor clearColor];
    
    // 1.创建tableView
    CGFloat Y = [UIScreen mainScreen].bounds.size.height  - 34;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, Y) style:(UITableViewStylePlain)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.tableHeaderView = bgView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    HSQCustomNavBar *NavBar = [HSQCustomNavBar InitializeTheNavigationBar];
    NavBar.title = @"个人中心";
    NavBar.titleColor = [[UIColor redColor] colorWithAlphaComponent:0.0];
    NavBar.titleFont = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:NavBar];
    self.NavBar = NavBar;
    
    NSLog(@"==%.f", [UIScreen mainScreen].bounds.size.width * 0.7 - KNavBarHeight);
    
    NSString *string = [self timeStampWithString:@"2018年04月10日 14:20" TimeType:@"YYYY年MM月dd日 HH:mm"];
    
    NSLog(@"==%@",string);
    
}

- (NSString *)timeStampWithString:(NSString *)string TimeType:(NSString *)type{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:type]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:string]; //------------将字符串按formatter转成nsdate
    
    NSLog(@"===%@",date);
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    return [NSString stringWithFormat:@"%ld",timeSp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];

    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat Offset_Y = scrollView.contentOffset.y;
    
    NSLog(@"---%.f",Offset_Y);
    
    if (Offset_Y > 0)
    {
        self.Bgimage.frame = ({
            
            CGRect image_frame = self.Orgin_Frame;
            
            image_frame.origin.y = self.Orgin_Frame.origin.y - Offset_Y;
            
             image_frame;
            
        });
    }
    else
    {
        self.Bgimage.frame = ({
            
            CGRect image_frame = self.Orgin_Frame;
            
            image_frame.size.height = self.Orgin_Frame.size.height - Offset_Y;
            
            image_frame.size.width = image_frame.size.height / 0.7;
            
            image_frame.origin.x = self.Orgin_Frame.origin.x - (image_frame.size.width - self.Orgin_Frame.size.width) / 2;
            
            image_frame;
            
        });
    }
    
    CGFloat Height =  [UIScreen mainScreen].bounds.size.width * 0.7 - KNavBarHeight;
    
    if (Offset_Y > 0)
    {
        CGFloat alp = Offset_Y /  Height;
        
        if (alp > 0)
        {
            self.NavBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.6];
        }
        else
        {
            self.NavBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:(Offset_Y /  Height)];
        }
        
        self.NavBar.titleColor = [[UIColor blackColor] colorWithAlphaComponent:Offset_Y /  Height ];
    }
    else
    {
        self.NavBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent: (Offset_Y - Height / Height)];
        
        self.NavBar.titleColor =[[UIColor blackColor] colorWithAlphaComponent: Offset_Y - Height / Height];
    }
}




@end
