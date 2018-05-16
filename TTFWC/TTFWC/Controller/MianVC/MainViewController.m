//
//  MainViewController.m
//  TTFWC
//

#import "MainViewController.h"
#import "CycleView.h"
#import "AppDelegate.h"
#import "TCNavController.h"
#import "TCEndView.h" //结束弹出窗

@interface MainViewController ()
{
    CGFloat num;
    CycleView *circle;
    UILabel *numLabel;
}
@property (nonatomic, strong) NSTimer *timer;
@property (strong, nonatomic) UILabel *timerLabel;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL isReturn;
@property (nonatomic, strong) UIView *bgView;//弹窗灰色背景
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *dayTime;
@property (nonatomic, strong) NSMutableArray *recardArr;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, assign) CGFloat  times;
@end

@implementation MainViewController
//将要出现，设置导航栏透明度为0
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.layer.shadowOpacity = 0.0;
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.isBack = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCUIColorFromRGB(0x3333333);
    self.title = @"俯卧撑";
    
    //接受返回的通知，用来控制返回按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isBack) name:@"tongzhifanhui" object:nil];
    
    //建表，用来记录所需要保存的数据
    [self createPilst];
    //创视图
    [self creatUI];
    // Do any additional setup after loading the view.
}

//建表
- (void)createPilst {
    //路径
    self.path = [TCCreatePlist createPlistFile:@"record"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:self.path];
    [self.recardArr addObjectsFromArray:arr];
    self.isShow = NO;
    self.recardArr = [[NSMutableArray alloc]init];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self getCurrentTimes];
    self.isReturn = NO;
    self.count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatShowTime:) userInfo:@"admin" repeats:YES];
}

//视图
-(void)creatUI {
    //设置位置圆弧
    circle = [[CycleView alloc] initWithFrame:CGRectMake(78,  100 + StatusBarAndNavigationBarHeight, WIDTH - 78*2, WIDTH - 78*2)];
    [self.view addSubview:circle];
    
    //按钮
    UIButton *touchBT = [[UIButton alloc]initWithFrame:circle.frame];
    touchBT.tag = 33;
    touchBT.layer.masksToBounds = YES;
    touchBT.layer.cornerRadius = (WIDTH - 78*2)/2;
    touchBT.backgroundColor = [UIColor clearColor];
    [touchBT addTarget:self action:@selector(clickBT:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:touchBT];
    
    //中间的数值
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, WIDTH - 78*2, 80)];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:80];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.text = @"0";
    numLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [touchBT addSubview:numLabel];
    
    //定时时间
    self.timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(numLabel.frame) + 29, 220, 24)];
    self.timerLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    self.timerLabel.text = @"00:00:00";
    [touchBT addSubview:self.timerLabel];
    
    //提示文字
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 208)/2, CGRectGetMaxY(circle.frame) + 72, 208, 16)];
    textLabel.text = @"鼻尖轻触计数器既可完成计数";
    textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    textLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:textLabel];
    
    //结束按钮
    UIButton *endBT = [[UIButton alloc]initWithFrame:CGRectMake(24, HEIGHT - 20 - 48 - TabbarSafeBottomMargin, WIDTH - 48, 48)];
    [endBT setBackgroundImage:[UIImage imageNamed:@"结束"] forState:(UIControlStateNormal)];
    [endBT setTitle:@"结束" forState:(UIControlStateNormal)];
    [endBT setTitleColor:TCUIColorFromRGB(0x813700) forState:(UIControlStateNormal)];
    endBT.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    endBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [endBT addTarget:self action:@selector(showalert) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:endBT];
}
//获取刚进来时的时间
-(void)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    NSArray *array = [currentTimeString componentsSeparatedByString:@" "];
    self.dayTime = array[0];
    NSString *startStr = array[1];
    self.startTime = [startStr substringWithRange:NSMakeRange(0,5)];
    
}
//获取运动结束时的时间
-(void)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    NSArray *array = [currentTimeString componentsSeparatedByString:@" "];
    NSString *startStr = array[1];
    self.endTime = [startStr substringWithRange:NSMakeRange(0,5)];
    
    if (num > 0) {
        //如果次数不为0 则计入plist文件中
        NSString *numStr = [NSString stringWithFormat:@"%.f",num];
        self.dic = @{@"startTime":self.startTime,@"endTime":self.endTime,@"dayTime":self.dayTime,@"num":numStr};
        [self.recardArr removeAllObjects];
        //将plist文件中的数据取出
        NSArray *arr = [NSArray arrayWithContentsOfFile: _path];
        [self.recardArr addObjectsFromArray:arr];
        //将新的值插入第一个
        [self.recardArr insertObject:self.dic atIndex:0];
        [self.recardArr writeToFile: _path atomically:YES];//重新写入
    }
}

-(void)showalert{
    //判断
    if (num == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否结束本次锻炼？" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"不做了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //响应事件
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
            [self creatAlert];
            [self getCurrentTime];
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"继续做" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //响应事件
            nil;
        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)creatAlert{
    //弹出窗
    TCEndView *endView = [[TCEndView alloc] initWithFrame:self.view.frame andTtile:numLabel.text andTime:self.timerLabel.text];
    endView.buttonAction = ^(UIButton *sender) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:endView];
}

#pragma mark -- 点击确认按钮事件
-(void)closeBGView{
    [UIView animateWithDuration:0.3f animations:^{
    }completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 定时器
- (void)repeatShowTime:(NSTimer *)tempTimer {
    
    self.count++;
    int surTime = self.count%3600;
    if (self.count >= 7200) {
        [self creatAlert];
    }
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",self.count/3600,surTime/60,surTime%60];
}

-(void)clickBT:(UIButton *)sender{
    num ++;
    if (num > 999) {
        numLabel.text = @"999";
    }else{
        numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    circle.progress = 1;
    [self performSelector:@selector(changeView0) withObject:self afterDelay:0.6];
}

-(void)changeView0{
    circle.progress = 0;
}

//通知事件
- (void)isBack
{
    [self showalert];
}

//将要消失
- (void)viewWillDisappear:(BOOL)animated
{
    //记录返回按钮
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.isBack = NO;
}

@end
