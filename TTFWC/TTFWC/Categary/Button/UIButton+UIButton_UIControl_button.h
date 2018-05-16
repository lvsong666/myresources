//
//  UIButton+UIButton_UIControl_button.h
//  TTFWC
//

#import <UIKit/UIKit.h>
#define defaultInterval 0.6//默认时间间隔
@interface UIButton (UIButton_UIControl_button)

@property(nonatomic,assign)NSTimeInterval timeInterval;//用这个给重复点击加间隔
@property(nonatomic,assign)BOOL isIgnoreEvent;//YES不允许点击NO允许点击
@end


