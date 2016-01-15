//
//  RegexConst.h
//  RunTimeDemo
//
//  Created by Xwj on 16/1/15.
//  Copyright © 2016年 Xwj. All rights reserved.
//

#ifndef RegexConst_h
#define RegexConst_h


//邮箱账户
#define REGEX_EMAIL     @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//手机账户
#define REGEX_TELPHONE  @"^1[3,4,5,7,8]\\d{9}$"
//座机判断
#define REGEX_HOME_TEL  @"^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$"
//字符串个数
#define REGEX_STRING_COUNT @"^[\\u4e00-\\u9fa5]{1,5}$|^[\\dA-Za-z_]{2,10}$"
//身份证
#define REGEX_IDNUM     @"(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])"

//查询图片链接
#define REGEX_IMAGELINK @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"

//图形验证码
#define REGEX_VCODE @"^[A-Za-z0-9]{4}$"

//注册密码
//以字母开头，长度在6-18之间，只能包含字符、数字和下划线
#define REGEX_REGISTER_PASSWORD @"^[a-zA-Z]\\w{5,17}$"

//登录密码
#define REGEX_LOGIN_PASSWORD @"^[a-zA-Z\d]\\w{5,17}$"


#endif /* RegexConst_h */
