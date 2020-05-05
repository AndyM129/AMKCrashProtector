//
//  NSException+AMKCrashProtector.h
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2019/2/28.
//

#import <Foundation/Foundation.h>
#import "AMKCrashProtectorConstants.h"

/// NSException: UserInfo 构造Block
typedef void(^_Nullable AMKCPExceptionUserInfoBlock)(NSMutableDictionary *_Nullable userInfo);

/// Crash异常
@interface NSException (AMKCrashProtector)

/// 创建并返回 NSException 对象
+ (instancetype)amkcp_exceptionWithName:(NSExceptionName)name reason:(NSString *)reason userInfoBlock:(AMKCPExceptionUserInfoBlock)userInfoBlock;

/// Crash异常描述，用于控制台输出
- (NSString *)amkcp_crashExceptionDescription;

/// Crash异常信息，用于全量信息上报
- (NSDictionary *)amkcp_crashExceptionInfo;

@end
