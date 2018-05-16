//
//  TCRecordViewController.m
//  TTFWC
//

#import "TCRecordViewController.h"
#import "TCRecordTableViewCell.h"
#import "UITableView+HD_NoList.h" //占位图

@interface TCRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation TCRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TCUIColorFromRGB(0xF7F7F7);
    self.title = @"记录";
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"record.plist" ];
    self.dataArr = [NSArray arrayWithContentsOfFile:fileName];
    //创建视图
    [self creatUI];
    //1.设置阴影颜色
    self.navigationController.navigationBar.layer.shadowColor = TCUIColorFromRGB(0x181818).CGColor;
    //设置阴影的高度
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    //设置透明度
    self.navigationController.navigationBar.layer.shadowOpacity = 0.6;
    // Do any additional setup after loading the view.
}
//创建视图
-(void)creatUI{
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:(UITableViewStyleGrouped)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.mainTableView];
    
    //判断有无数据
    if (self.dataArr.count > 0) {
        [self.mainTableView dismissNoView];
    } else {
        [self.mainTableView showNoView:@"还没看到您的记录，开始运动吧" image: [UIImage imageNamed:@"空状态"] certer:CGPointZero];
    }
}

#pragma mark - TableView DataSource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCRecordTableViewCell *cell = [[TCRecordTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    NSDictionary *dic = self.dataArr[indexPath.section];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@ - %@",dic[@"startTime"],dic[@"endTime"]];
    cell.dayLabel.text = [NSString stringWithFormat:@"%@",dic[@"dayTime"]];
    cell.numLabel.text = [NSString stringWithFormat:@"%@",dic[@"num"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 16;
    }else{
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

@end
