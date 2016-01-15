//
//  CommentUntils.h
//  RunTimeDemo
//
//  Created by Xwj on 16/1/15.
//  Copyright © 2016年 Xwj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CommentUntils : NSObject

//获取文本Size
+(CGSize )getTitleSize:(CGSize)size attributeFont:(UIFont *)font titleSize:(NSString *)string;

//计算文本长度
+(int)stringCountWord:(NSString*)string;

//归档数据
+(void)archivedDataWithRootObject:(id)data withKey:(NSString *)key;

//解档数据
+(id)unarchiveObjectWithData:(NSString *)key;

//拨打电话
+(void)callPhoneNumber:(NSString *)phoneNumber;


@end
