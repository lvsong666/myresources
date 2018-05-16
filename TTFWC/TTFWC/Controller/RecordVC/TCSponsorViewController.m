//
//  TCSponsorViewController.m
//  TTFWC
//

#import "TCSponsorViewController.h"
#import "TCShareView.h" //分享的view

@interface TCSponsorViewController ()
@property (nonatomic, strong) UIView *backView; //弹窗的背景颜色
@property (nonatomic, strong) UIScrollView *scroller; //滚动视图

@end

@implementation TCSponsorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赞助";
    self.view.backgroundColor = TCUIColorFromRGB(0xFDFDFD);
    //创建右边导航栏
    [self createNav];
    //创建视图
    [self creatUI];
    // Do any additional setup after loading the view.
}

//创建右边导航栏
- (void)createNav
{
    //右边按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0,0, 24, 16);
    [rightBtn setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barRightBtn;
    
    //1.设置阴影颜色
    self.navigationController.navigationBar.layer.shadowColor = TCUIColorFromRGB(0x181818).CGColor;
    //设置阴影的高度
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    //设置透明度
    self.navigationController.navigationBar.layer.shadowOpacity = 0.6;
}

//创建视图
-(void)creatUI{
 
    //创建滚动视图
    _scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    _scroller.showsHorizontalScrollIndicator = NO;
    _scroller.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scroller];
    //提示文字
    UILabel *  totleLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, WIDTH - 80*2, 96)];
    totleLb.text = @"感谢您对我们软件的喜爱\n为支持我们做出更好的软件\n您可以为我们赞助一笔\n或者将本软件分享给您的好友";
    totleLb.textAlignment = NSTextAlignmentCenter;
    totleLb.numberOfLines = 0;
    totleLb.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    totleLb.textColor = TCUIColorFromRGB(0x333333);
    [_scroller addSubview:totleLb];
    
    //支付宝图片
    UIImageView *alipayImage = [[UIImageView alloc]initWithFrame:CGRectMake(88, CGRectGetMaxY(totleLb.frame) + 20, WIDTH - 88*2, WIDTH - 88*2)];
    alipayImage.image = [UIImage imageNamed:@"二维码"];
    [_scroller addSubview:alipayImage];
    //文字
    UILabel *aliLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(alipayImage.frame) + 17, WIDTH, 20)];
    aliLabel.text = @"支付宝支付";
    aliLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    aliLabel.textAlignment = NSTextAlignmentCenter;
    aliLabel.textColor = TCUIColorFromRGB(0x813700);
    [_scroller addSubview:aliLabel];
    
    //微信图片
    UIImageView *weChatImage = [[UIImageView alloc]initWithFrame:CGRectMake(88, CGRectGetMaxY(aliLabel.frame) + 20, WIDTH - 88*2, WIDTH - 88*2)];
    weChatImage.image = [UIImage imageNamed:@"二维码"];
    [_scroller addSubview:weChatImage];
    //文字
    UILabel *weChatLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(weChatImage.frame) + 17, WIDTH, 20)];
    weChatLabel.text = @"微信支付";
    weChatLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    weChatLabel.textAlignment = NSTextAlignmentCenter;
    weChatLabel.textColor = TCUIColorFromRGB(0x813700);
    [_scroller addSubview:weChatLabel];
    
    //视图的滚动位置
    _scroller.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(weChatLabel.frame) + 20);
}

#pragma mark -- 分享的点击事件
- (void)rightBtn {
    TCShareView *shareView = [[TCShareView alloc]init];
    [TCShareView ShowTheViewOfShareAndShowMes:@{} andShareSuccess:^{
        //写你的结果 。。。。。。
    } andShareFailure:^{
        
    } andShareCancel:^{
        
    }];
    [self.view addSubview:shareView];
}


@end
