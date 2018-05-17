//
//  MainViewController.m
//  俯卧撑小软件

#import "ViewController.h"
#import "MainViewController.h"
#import "TCSponsorViewController.h"
#import "TCRecordViewController.h"
@interface ViewController ()

@end

@implementation ViewController

//将要出现，设置导航栏透明度为0
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.layer.shadowOpacity = 0.0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = TCUIColorFromRGB(0x333333);
    //创建导航栏的左按钮和右按钮
    [self createNavBtn];
    
    //创建中间视图
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

//创建导航栏按钮
- (void)createNavBtn
{
    //左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =CGRectMake(0,0, 30, 44);
    [leftBtn setTitle:@"赞助"forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    //右边按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0,0, 24, 16);
    [rightBtn setImage:[UIImage imageNamed:@"记录"] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barRightBtn;
    
    //解决按钮不靠左 靠右的问题.
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -20;//这个值可以根据自己需要自己调整
    
//    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, barLeftBtn];
}

//创建中间视图
-(void)creatUI{
    //开始按钮
    UIButton *startBT = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH - 253)/2, StatusBarAndNavigationBarHeight + 98, 253, 253)];
    startBT.layer.masksToBounds = YES;
    startBT.layer.cornerRadius = 253/2;
    [startBT setBackgroundImage:[UIImage imageNamed:@"开始按钮"] forState:(UIControlStateNormal)];
    [startBT addTarget:self action:@selector(clickStart) forControlEvents:(UIControlEventTouchUpInside)];
    [startBT setTitleColor:TCUIColorFromRGB(0x813700) forState:(UIControlStateNormal)];
    [startBT setTitle:@"开始" forState:(UIControlStateNormal)];
    startBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    startBT.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:36];
    [self.view addSubview:startBT];
    
    //下方的提示文字
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 192)/2, CGRectGetMaxY(startBT.frame) + 40, 192, 16)];
    textLabel.text = @"请把手机调整到合适的高度";
    textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:textLabel];
}

#pragma mark -- 开始的点击事件
-(void)clickStart{
    MainViewController *mainVC = [[MainViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mainVC animated:YES];
}

#pragma mark -- 赞助的点击事件
-(void)leftBtn{
    TCSponsorViewController *sponVC = [[TCSponsorViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sponVC animated:YES];
}

#pragma mark -- 记录的点击事件
-(void)rightBtn{
    TCRecordViewController *recordVC = [[TCRecordViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordVC animated:YES];
}

@end

