//
//  UITableView+HD_NoList.h

#import <UIKit/UIKit.h>

@interface UITableView (HD_NoList)


-(void)showNoView:(NSString *)title image:(UIImage *)placeImage certer:(CGPoint)p;
-(void)dismissNoView;

@property(nonatomic,assign,readonly,getter = isShowNoView)BOOL showNoView;



@end
