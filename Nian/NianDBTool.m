//
//  NianDBTool.m
//  Nian
//
//  Created by 周宏 on 15/7/11.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#import "NianDBTool.h"
#import <FMDB.h>
#define PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Nian.sqlite"]
#define DATE_FORMATTER                  @"yyyy-MM-dd"
#define DATE_DETAIL_FORMATTER           @"HH:mm:ss"

@implementation NianDBTool

+ (void)insertRecodeWithModel:(NianModel *)model{
    FMDatabase *db = [FMDatabase databaseWithPath:PATH];
    if ([db open]) {
        NSString *sql = nil;
        
        // 设置日期格式以及日期字符串
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = DATE_FORMATTER;
        NSString *date = [formatter stringFromDate:model.date];
        formatter.dateFormat = DATE_DETAIL_FORMATTER;
        NSString *dateDetail = [formatter stringFromDate:model.date];
        
        if (model.img) {
            sql = @"insert INTO Nian_data (date, date_detail, text, picture) VALUES(?, ?, ?, ?)";
            BOOL res = [db executeUpdate:sql, date, dateDetail, model.text, model.img];
            if (!res) {
                NSLog(@"失败");
            } else {
                NSLog(@"成功");
            }
        } else {
            sql = @"INSERT INTO Nian_data (date, date_detail, text) VALUES(?, ?, ?)";
            BOOL res = [db executeUpdate:sql, date, dateDetail, model.text];
            if (!res) {
                NSLog(@"失败");
            } else {
                NSLog(@"成功");
            }
        }
        [db close];
    }
}

+ (void)createDB{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:PATH]) {
        FMDatabase *db = [FMDatabase databaseWithPath:PATH];
        if ([db open]) {
            NSString *sql = @"CREATE TABLE 'Nian_data' ('date' TEXT PRIMARY KEY NOT NULL,'date_detail' TEXT, 'text' TEXT, 'picture' BLOB)";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"失败");
            } else {
                NSLog(@"成功");
            }
            [db close];
        } else {
            NSLog(@"打开db失败");
        }
    }
}

+ (NSMutableArray *)getLocalData{
    FMDatabase * db = [FMDatabase databaseWithPath:PATH];
    NSMutableArray *mary = [NSMutableArray array];
    if ([db open]) {
        NSString * sql = @"SELECT * FROM Nian_data ORDER BY date DESC";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *strDate = [rs stringForColumn:@"date"];
            NSString *strDateDetail    = [rs stringForColumn:@"date_detail"];
            
            NSString *strDateAll = [NSString stringWithFormat:@"%@%@", strDate, strDateDetail];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = [NSString stringWithFormat:@"%@%@", DATE_FORMATTER, DATE_DETAIL_FORMATTER];
            NSDate *date = [formatter dateFromString:strDateAll];
            NSString *text = [rs stringForColumn:@"text"];
            
            NianModel *model = [NianModel modelWithDate:date text:text img:nil];
            [mary addObject:model];
        }
        [db close];
    }
    return mary;
}

+ (void)deleteTodayRecode{
    FMDatabase *db = [FMDatabase databaseWithPath:PATH];
    if ([db open]) {
        
    }
}

@end
