//
//  AMKCrashProtector+Bugly.h
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2020/5/7.
//

#import "AMKCrashProtector.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMKCrashProtector (Bugly)

/// 是否启用 Bugly 异常上报（内部会转为单例的实例属性进行处理）
@property(nonatomic, assign, class) BOOL BuglyEnable;

/// 是否启用 Bugly 异常上报
@property(nonatomic, assign) BOOL BuglyEnable;

@end

NS_ASSUME_NONNULL_END
