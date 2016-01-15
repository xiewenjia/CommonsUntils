//
//  CommentUntils.m
//  RunTimeDemo
//
//  Created by Xwj on 16/1/15.
//  Copyright © 2016年 Xwj. All rights reserved.
//

#import "CommentUntils.h"

@implementation CommentUntils


//获取文本Size
+(CGSize )getTitleSize:(CGSize)size attributeFont:(UIFont *)font titleSize:(NSString *)string{
    
    CGSize trueSize  = CGSizeMake(0, 0);
    NSDictionary *styleAttributeDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    trueSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:styleAttributeDic context:nil].size;
    return trueSize;
};

//计算文本长度
+(int)stringCountWord:(NSString*)string
{
    int i,n= (int)string.length,l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[string characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

//归档数据
+(void)archivedDataWithRootObject:(id)data withKey:(NSString *)key{
    
    NSAssert(key == nil, @" 归档中key 不可以 是 nil ");
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:saveData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//解档数据
+(id)unarchiveObjectWithData:(NSString *)key{
    
    NSAssert(key == nil, @" 解档数据中key 不可以 是 nil ");
    NSData *saveData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id data = [NSKeyedUnarchiver unarchiveObjectWithData:saveData];
    return data;
    
}

//拨打电话
+(void)callPhoneNumber:(NSString *)phoneNumber{
    NSMutableString * urlString = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


@end
