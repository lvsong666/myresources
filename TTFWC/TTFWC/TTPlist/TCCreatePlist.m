//
//  TCCreatePlist.m
//  搜索框&历史记录
//

#import "TCCreatePlist.h"

@implementation TCCreatePlist
+(NSString *)createPlistFile:(NSString *)name{
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[name stringByAppendingFormat:@"%@", @".plist"]];
    return filepath;
}

@end
