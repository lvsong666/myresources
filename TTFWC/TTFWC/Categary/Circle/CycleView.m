//
//  CycleView.m
//  CycleProgressBar

#define PROGRESS_LINE_WIDTH 2 //弧线的宽度
#define RYUIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "CycleView.h"

@implementation CycleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        float centerX = self.bounds.size.width/2.0;
        float centerY = self.bounds.size.height/2.0;
        //半径
        float radius = (self.bounds.size.width-12)/2.0;
        //创建贝塞尔路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:YES];
        //添加背景圆环
        CAShapeLayer *backLayer = [CAShapeLayer layer];
        backLayer.frame = self.bounds;
        backLayer.fillColor =  [[UIColor clearColor] CGColor];
        backLayer.strokeColor  = TCUIColorFromRGB(0xADADAD).CGColor;
        backLayer.lineWidth = 2;
        backLayer.path = [path CGPath];
        backLayer.strokeEnd = 1;
        [self.layer addSublayer:backLayer];
        
        //创建进度layer
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
        //指定path的渲染颜色
        _progressLayer.strokeColor  = [[UIColor blackColor] CGColor];
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = 12;
        _progressLayer.path = [path CGPath];
        _progressLayer.strokeEnd = 0;
        
        //设置渐变颜色
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[RYUIColorWithRGB(255, 151, 0) CGColor],(id)[RYUIColorWithRGB(255, 203, 0) CGColor], nil]];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
        [self.layer addSublayer:gradientLayer];
        
    }
    return self;
}

-(void)setProgress:(float)progress
{
    [self startAninationWithPro:progress];
}

-(void)startAninationWithPro:(CGFloat)pro
{
    //增加动画
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:pro];
    pathAnimation.autoreverses=NO;
    
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

@end
