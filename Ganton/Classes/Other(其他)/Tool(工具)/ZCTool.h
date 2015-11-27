//
//  WWTool.h
//  WeWish
//
//  Created by hh on 15/6/22.
//  Copyright (c) 2015年 WeWish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

@interface ZCTool : NSObject

+ (UIColor *)colorWithHexString:(NSString *)str;
+ (id) _valueOrNil:(id)obj;
//根据时间戳 返回是今天还是明天后天
+(NSString * )JudgmentIsWhichDay:(long )dateTime;
/**

  根据字符串计算出宽高
 
 */
+(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize;

/**
 *  图片拉升  imageStr 为图片的名字
 *
 */
+(UIImage *)imagePullLitre:(NSString *)imageStr;
/**
 *  验证手机号是否输入正确
 *
 */
+(BOOL)validateMobile:(NSString *)mobileNum;

//实例网络请求
+(AFHTTPRequestOperationManager *)networkRequest;

//get请求
+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;

//post请求
+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;

//put请求
+(void)putWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;


//判断是否要上传推送ID
+(void)uploadThePushID;

//上传服务器registrationID
+(void)uploadRegistrationID;

//上传通讯录
+(BOOL)UploadTheAddressBook;

@end
