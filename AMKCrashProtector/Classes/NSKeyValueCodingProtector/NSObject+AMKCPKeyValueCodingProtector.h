//
//  NSObject+AMKCPKeyValueCodingProtector.h
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2018/12/14.
//

#import "AMKCrashProtector.h"

/// NSKeyValueCoding 异常保护
@interface AMKCrashProtector (AMKCPKeyValueCodingProtector)

/// 是否启用 NSKeyValueCoding 异常保护（内部会转为单例的实例属性进行处理）
@property(nonatomic, assign, class) BOOL NSKeyValueCodingProtectorEnable;

/// 是否启用 NSKeyValueCoding 异常保护
@property(nonatomic, assign) BOOL NSKeyValueCodingProtectorEnable;

@end
