//
//  AMKCrashProtector.h
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2018/12/11.
//

#import <Foundation/Foundation.h>
#import "NSException+AMKCrashProtector.h"

/// Crash保护
@interface AMKCrashProtector : NSObject

/// 单例
@property(nonatomic, readonly, nonnull, class) AMKCrashProtector *defaultProtector;

/// 注册Handler
+ (void)registerExceptionHandler:(id<AMKCrashProtectHandlerProtocol> _Nullable)exceptionHandler;
- (void)registerExceptionHandler:(id<AMKCrashProtectHandlerProtocol> _Nullable)exceptionHandler;

/// 注销Handler
+ (void)unregisterExceptionHandler:(id<AMKCrashProtectHandlerProtocol> _Nullable)exceptionHandler;
- (void)unregisterExceptionHandler:(id<AMKCrashProtectHandlerProtocol> _Nullable)exceptionHandler;

/// 处理Crash异常
+ (void)didHandleException:(NSException * _Nullable)exception;
- (void)didHandleException:(NSException * _Nullable)exception;

@end
