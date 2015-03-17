//
//  ViewController.m
//  mySQL
//
//  Created by qianfeng on 13-5-23.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"arr is %@",arr);
//   
//    NSString * path = [arr objectAtIndex:0];
//    path = [path stringByAppendingPathComponent:@"Test.db"];
//    NSLog(@"path is %@...",path);
//    
//    NSLog(@"%@", NSHomeDirectory());
//    NSLog(@"%@",[NSHomeDirectory() stringByAppendingString:@"/Documents/Test.db"]);
//    
//    FMDatabase * dataBase = [FMDatabase databaseWithPath:path];
//    if (![dataBase open]) {
//        NSLog(@"can not open dataBase!");
//        return;
//    }
    
    // [NSNumber numberWithInt:20];
//    NSArray *array=[NSArray arrayWithObjects:
//                    @"CREATE TABLE if not exists student (serial integer  PRIMARY KEY AUTOINCREMENT,sno integer,sname TEXT(1024) DEFAULT NULL,saddress TEXT(1024) DEFAULT NULL)",
//                    @"CREATE TABLE if not exists course (serial integer  PRIMARY KEY AUTOINCREMENT,cno integer,cname TEXT(1024) DEFAULT NULL,cteacher TEXT(1024) DEFAULT NULL)",
//                    @"CREATE TABLE if not exists score (serial integer  PRIMARY KEY AUTOINCREMENT,sno integer,cno integer,score Float DEFAULT NULL)", nil];
//    
//    for (NSString * sql in array) {
//        [dataBase executeUpdate:sql];
//    }
    
//    [dataBase executeUpdate:@"CREATE TABLE  User (serial integer PRIMARY KEY AUTOINCREMENT,Name text,Age integer)"];
//    
//    NSString * str1 = @"alter table User add column MaoTest integer";
//    [dataBase executeUpdate:str1];
//    
//    
//    for (int i = 0; i < 5; i++) {
//        [dataBase executeUpdate:@"INSERT INTO User (serial,Name,Age) VALUES (?,?,?)",[NSNumber numberWithInt:i],@"张三",[NSNumber numberWithInt:20]];
//    }
//    
//    [dataBase executeUpdate:@"INSERT INTO User (Name,Age) VALUES (?,?)",@"张三01",[NSNumber numberWithInt:20]];
//   BOOL flag = [dataBase executeUpdate:@"UPDATE User SET Name=? WHERE Name=?",@"张三222",@"张三"];
//    NSLog(@"flag is %d",flag);
//    
//    [dataBase executeUpdate:@"UPDATE User SET Name=? WHERE serial=?",@"张三",[NSNumber numberWithInt:2]];
//
//    FMResultSet * rs1 = [dataBase executeQuery:@"select * from User WHERE serial=?",[NSNumber numberWithInt:2]];
//    while ([rs1 next]) {
//        NSString * str = [rs1 stringForColumn:@"Name"];
//        int num = [rs1 intForColumn:@"serial"];
//        
//        NSLog(@"str is %@ serial is %d",str,num);
//    }
//    
//    [dataBase executeUpdate:@"DELETE  FROM User WHERE Name = ?",@"张三222"];
//    [dataBase executeUpdate:@"DELETE FROM User"];
//    [dataBase executeUpdate:@"DROP TABLE User"];
//   [dataBase close];
    
    //第一步，创建存放数据库的路径
    NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/test.db"];
    NSLog(@"path is %@",path);
    //创建数据库
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if (![dataBase open]) {
        NSLog(@"dataBase open failed");
        return;
    }
    
    //第二步，创建table,并添加字段
    NSString *createSql=@"create table if not exists Person (Age integer primary key autoincrement,Name text)";
    if (![dataBase executeUpdate:createSql]) {
        NSLog(@"create table failed");
    }
    
    //如何添加字段
    NSString *otherSql=@"alter table Person add column Sex text";
    if (![dataBase executeUpdate:otherSql]) {
        NSLog(@"alter table failed");
        }
    
    //第三步 为字段赋值
    NSString *insertSql=@"insert into Person (Age,Name,Sex) values (?,?,?)";
    if (![dataBase executeUpdate:insertSql,[NSNumber numberWithInt:25],@"pengzhihao",[NSNumber numberWithChar:'M']]) {
        NSLog(@"insert table failed");
    }
    NSLog(@"%@",[NSNumber numberWithChar:'M']);
    
    //第四步 更改table
    NSString *updateSql=@"update Person set Name=? where Age=?";
    if (![dataBase executeUpdate:updateSql,@"lihong",[NSNumber numberWithInt:20]]) {
        NSLog(@"update table failed");
    }
    
    //第五步 查询table
    NSString *querySql=@"select * from Person where Age=?";
    FMResultSet *res=[dataBase executeQuery:querySql,[NSNumber numberWithInt:20]];
    if (!res) {
        NSLog(@"query table failed");
    }
    while ([res next]) {
        NSInteger age=[res intForColumn:@"Age"];
        NSString *name=[res stringForColumn:@"Name"];
        char sex=[res intForColumn:@"Sex"];
        NSLog(@"age %d name %@ sex %d",age,name,sex);
        }
    
    //第六步 删除table
    NSString *deleteSql=@"delete from Person where Age=?";
    if (![dataBase executeUpdate:deleteSql,[NSNumber numberWithInt:25]]) {
        NSLog(@"delete table failed");
    }
    
    //第七步 删除Person表里的内容
    [dataBase executeUpdate:@"delete from Person"];
    
    //第八步 删除Person表
    [dataBase executeUpdate:@"drop table Person"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
