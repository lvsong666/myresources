//
//  TCEndView.h
//  TTFWC
//
//  Created by 胡高广 on 2018/5/15.
//  Copyright © 2018年 吕松松. All rights reserved.
//

#import <UIKit/UIKit.h>

// 用typef宏定义来减少冗余代码
typedef void(^ButtonClick)(UIButton * sender);

@interface TCEndView : UIView
//下一步就是声明属性了，注意block的声明属性修饰要用copy
@property (nonatomic,copy) ButtonClick buttonAction;

-(instancetype)initWithFrame:(CGRect)frame andTtile:(NSString *)numStr andTime:(NSString *)timeStr;
@end
