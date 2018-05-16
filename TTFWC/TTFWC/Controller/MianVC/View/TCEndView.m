//
//  TCEndView.m
//  TTFWC
//
//  Created by 胡高广 on 2018/5/15.
//  Copyright © 2018年 吕松松. All rights reserved.
//

#import "TCEndView.h"

@implementation TCEndView
{
    UIView *backView;
    UIView *shoperView;
    UIButton *sureBT;
}

-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)numStr andTime:(NSString *)timeStr
{
    self = [super init];
    if(self){
        if(backView){
            [backView removeFromSuperview];
            [self createUI:numStr andTime:timeStr];
        }else{
            [self createUI:numStr andTime:timeStr];
        }
    }
    return self;
}

#pragma mark -- 创建UI
-(void)createUI:(NSString *)numStr andTime:(NSString *)timeStr {
    //创建背景颜色
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    [[UIApplication sharedApplication].keyWindow addSubview: backView];
    
    //创建视图
    shoperView = [[UIView alloc]initWithFrame:CGRectMake(0, 47, WIDTH, 445)];
    shoperView.backgroundColor = [UIColor clearColor];
    shoperView.userInteractionEnabled = YES;
    [backView addSubview:shoperView];
    
    //创建视图View
    UIView *mainView = [[UIView alloc] init];
    mainView.frame = CGRectMake(38, 137, WIDTH - 38*2, 290);
    mainView.backgroundColor = TCUIColorFromRGB(0x444444);
    mainView.layer.cornerRadius = 18;
    mainView.layer.masksToBounds = YES;
    [shoperView addSubview:mainView];
    
    //数量
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, WIDTH - 38*2, 60)];
    numberLabel.text = numStr;
    numberLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:50];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = TCUIColorFromRGB(0xFFFFFF);
    [mainView addSubview:numberLabel];
    
    //小文字
    UILabel *endlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(numberLabel.frame) + 5, WIDTH - 38*2, 18)];
    endlabel.textColor = [TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.6];
    endlabel.textAlignment = NSTextAlignmentCenter;
    endlabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    endlabel.text = @"完成俯卧撑";
    [mainView addSubview:endlabel];
    
    //时间
    UILabel*timelb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(endlabel.frame) + 30, WIDTH - 38*2, 48)];
    timelb.text = timeStr;
    timelb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:40];
    timelb.textAlignment = NSTextAlignmentCenter;
    timelb.textColor = TCUIColorFromRGB(0xFFFFFF);
    [mainView addSubview:timelb];
    
    //时间提示语
    UILabel*endtime = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timelb.frame) + 10, WIDTH - 38*2, 18)];
    endtime.text = @"本次运动历时";
    endtime.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    endtime.textAlignment = NSTextAlignmentCenter;
    endtime.textColor = [TCUIColorFromRGB(0xFFFFFF) colorWithAlphaComponent:0.6];
    [mainView addSubview:endtime];
    
    //确认按钮
    sureBT = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH - 170)/2, 393, 170, 48)];
    [sureBT setBackgroundImage:[UIImage imageNamed:@"确定按钮"] forState:(UIControlStateNormal)];
    sureBT.layer.cornerRadius = 5;
    sureBT.layer.masksToBounds = YES;
    [sureBT addTarget:self action:@selector(closeBGView:) forControlEvents:(UIControlEventTouchUpInside)];
    [shoperView addSubview:sureBT];
    
    //修饰的图片
    UIImageView *lightimage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, WIDTH - 30, 154)];
    lightimage.image = [UIImage imageNamed:@"光束"];
    [shoperView addSubview:lightimage];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH - 150)/2, 67, 149, 92)];
    image.image = [UIImage imageNamed:@"俯卧撑装饰"];
    [shoperView addSubview:image];
    
    shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        shoperView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)closeBGView:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
    
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shoperView.transform = CGAffineTransformScale(shoperView.transform, 1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                shoperView.transform = CGAffineTransformScale(shoperView.transform, 0.01, 0.01);
            } completion:^(BOOL finished) {
                [backView removeFromSuperview];
                backView = nil;
                // 判断下这个block在控制其中有没有被实现
                if (self.buttonAction) {
                    // 调用block传入参数
                    self.buttonAction(button);
                }
            }];
        }];
    }];
}

@end
