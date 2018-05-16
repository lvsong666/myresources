//
//  TCShareView.m
//  TTFWC
//

#import "TCShareView.h"

static TCShareView *shareview = nil;

@interface TCShareView ()
@property (nonatomic, strong) NSDictionary *mesDic;
@end

@implementation TCShareView

+(id)ShowTheViewOfShareAndShowMes:(NSDictionary *)Mes andShareSuccess:(ShareSuccess)success andShareFailure:(ShareFailure)failure andShareCancel:(ShareCancel)cancel{
    if (shareview == nil) {
        shareview = [[TCShareView alloc]initWithMes:Mes];
    }
    return shareview;
}
-(id)initWithMes:(NSDictionary *)mes{
    if (self = [super init]) {
        [self creat:mes];
    }
    return self;
}

-(void)creat:(NSDictionary *)mes{
    
    _mesDic = mes;
    //灰色背景
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [TCUIColorFromRGB(0x000000) colorWithAlphaComponent:0.2];
    self.backView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview: self.backView];
    //加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.backView addGestureRecognizer:tap];
    
    //底部的View
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT - (54 + 142), WIDTH, 54 + 142)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview: self.bottomView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.bottomView.frame.size.height - 54, WIDTH, 54)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:TCUIColorFromRGB(0x999999) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [btn addTarget:self action:@selector(miss) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview: btn];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bottomView.frame.size.height - btn.frame.size.height, WIDTH, 1)];
    lineLabel.backgroundColor = TCUIColorFromRGB(0xD8D8D8);
    [self.bottomView addSubview: lineLabel];
    
    [self shareScrollView];
    
    //执行过度动画
    self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, 54 + 142);
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
    }];
}

//分享scrollview
- (void)shareScrollView{
    //滚动视图 以防加的多
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.bottomView.frame.size.height - 54)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.bottomView addSubview: _scrollView];
    
    //分享到的头标
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, 19, WIDTH, 15);
    titleLabel.text = @"分享到";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    titleLabel.textColor = TCUIColorFromRGB(0x666666);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:titleLabel];
    
    NSArray *titlearr = @[@"微信", @"朋友圈", @"QQ", @"微博"];
    NSArray *imArr = @[@"微信", @"朋友圈",@"QQ",@"微博"];
    for (int i = 0; i < titlearr.count; i++) {
        UIView *vie = [[UIView alloc]initWithFrame:CGRectMake((WIDTH / titlearr.count + 1) * i, CGRectGetMaxY(titleLabel.frame) + 20, WIDTH / titlearr.count, _scrollView.frame.size.height)];
        vie.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taps:)];
        [vie addGestureRecognizer:tap];
        [_scrollView addSubview: vie];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(24, 0, 44 , 44)];
        imageview.layer.cornerRadius  = 22;
        imageview.layer.masksToBounds = YES;
        imageview.image = [UIImage imageNamed:imArr[i]];
        [vie addSubview: imageview];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame) + 8, vie.frame.size.width, 16)];
        lb.text = [NSString stringWithFormat:@"%@",  titlearr[i]];
        lb.textColor = TCUIColorFromRGB(0x666666);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [vie addSubview: lb];
    }
    _scrollView.contentSize = CGSizeMake(WIDTH, self.bottomView.frame.size.height - 54 - 1);
}

#pragma mark -- 取消按钮的点击事件
- (void)miss {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, 54 + 142);
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
        _backView = nil;
        [self removeFromSuperview];
        shareview = nil;
    }];
}

#pragma mark -- 手势点击事件
- (void)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, 54 + 142);
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
        _backView = nil;
        [self removeFromSuperview];
        shareview = nil;
    }];
}

//点击的分享
- (void)taps:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了%ld", tap.view.tag);
}

@end
