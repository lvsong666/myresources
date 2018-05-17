//
//  AppDelegate.m
//  TTFWC
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaiduMobStat.h" //百度统计的头文件
#import <UMCommon/UMCommon.h> //友盟统计的头文件
#import <UMMobClick/MobClick.h>
#import "TCNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设计整体的框架结构
    [self setFrameUI];
//    mm
    
    //百度统计
    [self baiduTongJi];
    
    //友盟统计
    [self umengTrack];
    
    return YES;
}

//整体的框架结构
- (void)setFrameUI
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *VC = [[ViewController alloc]init];
    TCNavController *naVC = [[TCNavController alloc] initWithRootViewController:VC];
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
}

//百度统计
- (void)baiduTongJi
{
    BaiduMobStat *statTracker = [BaiduMobStat defaultStat];
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:BaiDuTjAPPKey]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}

//友盟统计数据
- (void)umengTrack {
    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:UMengTj channel:@"App Store"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
