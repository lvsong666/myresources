//
//  TCShareView.h
//  TTFWC
//
//  Created by 胡高广 on 2018/5/14.
//  Copyright © 2018年 吕松松. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShareCancel)(void);
typedef void(^ShareSuccess)(void);
typedef void(^ShareFailure)(void);

@interface TCShareView : UIView
@property (nonatomic, strong) UIView *backView; //背景图
@property (nonatomic, strong) UIView *bottomView; //底部的View
@property (nonatomic, strong) UIImageView *imageStr; //图片
@property (nonatomic, strong) UILabel *titleLabel; //图片下面的文字
@property (nonatomic, strong) UIButton *cancelBtn; //取消的按钮
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) ShareCancel cancel;
@property (nonatomic, copy) ShareSuccess success;
@property (nonatomic, copy) ShareFailure failure;

+ (id)ShowTheViewOfShareAndShowMes:(NSDictionary *)Mes andShareSuccess:(ShareSuccess)success andShareFailure:(ShareFailure)failure andShareCancel:(ShareCancel)cancel;
@end
