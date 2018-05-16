//
//  TCRecordTableViewCell.m
//  TTFWC
//

#import "TCRecordTableViewCell.h"

@implementation TCRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //视图的颜色
        self.backgroundColor = TCUIColorFromRGB(0xF7F7F7);
        
        UIView *bgView  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WIDTH - 20, 84)];
        bgView.backgroundColor = TCUIColorFromRGB(0xFFFFFF);
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 3;
        [self.contentView addSubview:bgView];
        
        self.dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, 100, 14)];
        self.dayLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.dayLabel.textColor = TCUIColorFromRGB(0xB7B7B7);
        self.dayLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:self.dayLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.dayLabel.frame) + 10, 150, 20)];
        self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.timeLabel.textColor = TCUIColorFromRGB(0x666666);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:self.timeLabel];
        
        self.unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 30 - 20 - 20, 39, 20, 20)];
        self.unitLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        self.unitLabel.textColor = TCUIColorFromRGB(0x666666);
        self.unitLabel.text = @"个";
        self.unitLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:self.unitLabel];
        
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.unitLabel.frame) - 20 - 6 - 100, 22, 100, 40)];
        self.numLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:40];
        self.numLabel.textColor = TCUIColorFromRGB(0x666666);
        self.numLabel.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:self.numLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
