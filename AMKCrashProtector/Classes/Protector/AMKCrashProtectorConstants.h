//
//  AMKCrashProtectorConstants.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/5.
//

#import <Foundation/Foundation.h>
@class AMKCrashProtector;

/// Crash保护 处理
@protocol AMKCrashProtectHandlerProtocol <NSObject>

@optional

/// 收到并处理异常
+ (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception;

/// 收到并处理异常
- (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception;

@end

#pragma mark -

/// NSExceptionName：未知方法
/// unrecognized selector sent to instance
FOUNDATION_EXPORT NSExceptionName const AMKCPUnrecognizedSelectorException;

/// NSExceptionName：KVO
FOUNDATION_EXPORT NSExceptionName const AMKCPKeyValueObservingException;

/// NSExceptionName：KVO
/// An -addObserver:forKeyPath:options:context: message may be received but not handled.
FOUNDATION_EXPORT NSExceptionName const AMKCPKeyValueObservingNotHandledException;

/// NSExceptionName：循环引用
FOUNDATION_EXPORT NSExceptionName const AMKCPCircularReferenceException;

#pragma mark -

/// Crash保护：上报自定义信息 Key名称
typedef NSString *AMKCPUploadInfoKey NS_EXTENSIBLE_STRING_ENUM;

/// Crash保护：上报视图层级信息 Key名称
FOUNDATION_EXPORT AMKCPUploadInfoKey const AMKCPUploadViewHierarchyInfoKey;

/// Crash保护：操作目标对象 Key名称
FOUNDATION_EXPORT AMKCPUploadInfoKey const AMKCPUploadTargetInfoKey;


