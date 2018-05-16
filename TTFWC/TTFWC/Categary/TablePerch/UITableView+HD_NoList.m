//
//  UITableView+HD_NoList.m

#import "UITableView+HD_NoList.h"
#import "UIView+Extension.h"
#import <objc/runtime.h>
@implementation UITableView (HD_NoList)

static const void *kshowNoView = @"kshowNoView";
/// 图片
-(UIImageView *)im{
        UIImageView *im = [[UIImageView alloc]init];
        im.image = [UIImage imageNamed:@"icon_noting_face"];
        im.contentMode =UIViewContentModeCenter;
    
    return im  ;
}
// 文字
-(UILabel *)label{
    UILabel  *_label = [[UILabel alloc]init];
    _label.textColor = TCUIColorFromRGB(0xB1B1B1);
    _label.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    _label.text = @"没有任何内容啊";
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentCenter;

    return _label;
}
-(UIView *)containerV{
    UIView *v = [[UIView alloc]init];
    v.tag = 8808;
    return v;
}


#pragma mark - BOOL类型的动态绑定
- (BOOL)showNoView {
    return [objc_getAssociatedObject(self, kshowNoView) boolValue];
}
-(BOOL)isShowNoView{
    return [objc_getAssociatedObject(self, kshowNoView) boolValue];
}
- (void)setShowNoView:(BOOL)showNoView {
    objc_setAssociatedObject(self, kshowNoView, [NSNumber numberWithBool:showNoView], OBJC_ASSOCIATION_ASSIGN);
}

-(void)showNoView:(NSString *)title image:(UIImage *)placeImage certer:(CGPoint)p{
    
    UIView *containerV = [self containerV];
    containerV.width =[UIScreen mainScreen].bounds.size.width;
    UILabel *label = [self label];
    UIImageView *iv = [self im];
    
    if (title) {
         label.text = title;
    }
    if (placeImage) {
         iv.image =placeImage;
    }

    //图片的位置
    iv.size = iv.image.size;
    iv.y = 0;
    iv.centerX = containerV.width/2.0;
    iv.centerY = 137;
    label.width =containerV.width;
    [label sizeToFit];
    
    //label的位置
    label.centerX = containerV.width/2.0;
    label.y = CGRectGetMaxY(iv.frame) + 40;
    
    containerV.height = CGRectGetMaxY(label.frame);
    if (p.x>0&&p.y>0) {
        containerV.center = p;
    }else{
        containerV.x = 0;
        containerV.y = 100;
    }
    
    [containerV addSubview:iv];
    [containerV addSubview:label];
    [self addSubview: containerV];
    [self setShowNoView:YES];
    
}
-(void)dismissNoView{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 8808) {
            [obj removeFromSuperview];
            [self setShowNoView:NO];
        }
    }];
}
@end
