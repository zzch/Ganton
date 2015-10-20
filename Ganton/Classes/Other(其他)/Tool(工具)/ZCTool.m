//
//  WWTool.m
//  WeWish
//
//  Created by hh on 15/6/22.
//  Copyright (c) 2015年 WeWish. All rights reserved.
//

#import "ZCTool.h"
#import <AddressBook/AddressBook.h>
#import "AppDelegate.h"

@interface ZCTool ()<AFMultipartFormData>

@end


@implementation ZCTool



//根据字符串计算出宽高
+(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize
{
    CGRect rect = [content boundingRectWithSize:frame options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontSize,NSFontAttributeName, nil] context:nil];
    return rect;
}



+ (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    
    
    unsigned char r, g, b;
    b = x & 0xFF;
    g = (x >> 8) & 0xFF;
    r = (x >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}


+ (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}


/**
 *  图片拉升
 *
 */
+(UIImage *)imagePullLitre:(NSString *)imageStr
{
        CGFloat top = 25; // 顶端盖高度
        CGFloat bottom = 25 ; // 底端盖高度
        CGFloat left = 10; // 左端盖宽度
        CGFloat right = 10; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        UIImage *image=[UIImage imageNamed:imageStr ];
        // 指定为拉伸模式，伸缩后重新赋值
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return image;
}


//手机号验证
+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//封装网络请求
+(AFHTTPRequestOperationManager *)networkRequest
{
    // 1.获取NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"user_accessToken"];
    NSString *users_id = [defaults objectForKey:@"user_id"];
    
//    WWLog(@"%@",token);
//    token = @"1";
//    users_id = @"1";

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    if (token)
    {
        [manger.requestSerializer setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"X-Auth-Token"];
        [manger.requestSerializer setValue:[NSString stringWithFormat:@"%@",users_id] forHTTPHeaderField:@"X-Auth-User"];
    }
    else
    {
        
    }
  
    return manger;
}

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    [manger GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        WWLog(@"AFN原生返回的数据%@",responseObject);
        
//        //判断token是否过期
//        if ([responseObject[@"status"] integerValue] == 403)
//        {
//            [AppDelegate resetUserInfo];
//            return ;
//        }
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        WWLog(@"%@",error);
        if (failure)
        {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    // 2.发送请求
    [manger POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 请求成功, 通知调用者请求成功
        
//        //判断token是否过期
//        if ([responseObject[@"status"] integerValue] == 403)
//        {
//           // [AppDelegate resetUserInfo];
//            return ;
//        }

        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 通知调用者请求失败
//        WWLog(@"请求成功");
        if (failure)
        {
            failure(error);
        }
    }];
}




//上传通讯录
+(BOOL)UploadTheAddressBook
{
    
    NSMutableArray *personArray=[NSMutableArray array];
    
    
    //1.获得通讯录授权状态
    ABAuthorizationStatus status=ABAddressBookGetAuthorizationStatus();
    if (status != kABAuthorizationStatusAuthorized)
        return NO;
    //1.获得通讯录对象
    ABAddressBookRef book=ABAddressBookCreateWithOptions(NULL, NULL);
    //2.访问通讯录中所有的联系人
    CFArrayRef peopleArray=ABAddressBookCopyArrayOfAllPeople(book);
    CFIndex count=CFArrayGetCount(peopleArray);
    for (CFIndex i=0; i<count; i++) {
        //取出i位置的联系人
        ABRecordRef people=CFArrayGetValueAtIndex(peopleArray, i);
        
        //获得姓名
        CFStringRef firstName=ABRecordCopyValue(people, kABPersonFirstNameProperty);
        CFStringRef lastName=ABRecordCopyValue(people, kABPersonLastNameProperty);
        //        //获得公司的名字
        //        CFStringRef org = ABRecordCopyValue(people, kABPersonOrganizationProperty);
        if (firstName==nil) {
            
            NSString *strNS=@"知";
            CFStringRef strRef = (__bridge CFStringRef)strNS;
            firstName=strRef;
        }
        
        if (lastName==nil) {
            
            NSString *strNS=@"未";
            CFStringRef strRef = (__bridge CFStringRef)strNS;
            lastName=strRef;
        }
        
        NSLog(@"%@ %@ ", lastName,firstName);
        
        //获得电话
        ABMultiValueRef phone=ABRecordCopyValue(people, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phone);
        for (CFIndex j = 0; j<phoneCount; j++){
            CFStringRef phoneValue = ABMultiValueCopyValueAtIndex(phone, j);
            // CFStringRef phoneLabel = ABMultiValueCopyLabelAtIndex(phone, j);
            //NSLog(@"%@", phoneLabel);
            
            //拼接字符串
            NSString *person=[NSString stringWithFormat:@"{\"name\":\"%@%@\",\"phone\":\"%@\"}",lastName,firstName,phoneValue];
            [personArray addObject:person];
            
           
            
           // CFRelease(phoneLabel);
            CFRelease(phoneValue);
        }
        
        CFRelease(firstName);
        CFRelease(lastName);
        
        
    }
    
    
    
    //3.不需要通讯录
    CFRelease(peopleArray);
    CFRelease(book);

    
    

    
   
    
    NSString *contactsStr=[NSString stringWithFormat:@"{\"contact\":["];
    for (int i=0; i<personArray.count; i++) {
        if (i==0) {
         contactsStr=[NSString stringWithFormat:@"%@%@",contactsStr,personArray[i]];
        }else if (i==personArray.count-1){
        contactsStr=[NSString stringWithFormat:@"%@,%@]}",contactsStr,personArray[i]];
        
        }else{
        contactsStr=[NSString stringWithFormat:@"%@,%@",contactsStr,personArray[i]];
        
        }
        
    }
    
   
     BOOL __block isUP;
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *users_id = [defaults objectForKey:@"id"];
    params[@"id"]=users_id;
    params[@"contacts"]=contactsStr;
    
    NSString  *URL=[NSString stringWithFormat:@"%@",API];
    
    [self postWithUrl:URL params:params success:^(id responseObject) {
        
       // WWLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue]==200) {
            isUP=YES;
        }
        
        
    } failure:^(NSError *error) {
        isUP=NO;
       // WWLog(@"%@",error);
    }];
    
   
     return isUP;
    
}



@end
