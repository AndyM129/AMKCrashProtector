//
//  NSObject+AMKCPUnrecognizedSelectorProtector.h
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2018/12/11.
//

#import "AMKCrashProtector.h"

/// `Unrecognized Selector Sent To Instance：`异常保护 - 运行时构造的类的类名
FOUNDATION_EXPORT NSString * const AMKCPUnrecognizedSelectorProtectorClassName;

/// `Unrecognized Selector Sent To Instance：`异常保护 - 方法名
FOUNDATION_EXPORT NSString * const AMKCPUnrecognizedSelectorProtectorSelectorName;

/// `Unrecognized Selector Sent To Instance：`异常保护
@interface AMKCrashProtector (AMKCPUnrecognizedSelectorProtector)

/// 是否启用`Unrecognized Selector Sent To Instance：`异常保护（内部会转为单例的实例属性进行处理）
@property(nonatomic, assign, class) BOOL unrecognizedSelectorProtectorEnable;

/// 是否启用`Unrecognized Selector Sent To Instance：`异常保护
@property(nonatomic, assign) BOOL unrecognizedSelectorProtectorEnable;

@end
