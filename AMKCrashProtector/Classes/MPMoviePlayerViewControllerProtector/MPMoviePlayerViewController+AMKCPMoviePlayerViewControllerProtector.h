//
//  MPMoviePlayerViewController+AMKCPMoviePlayerViewControllerProtector.h
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2020/5/7.
//

#import "AMKCrashProtector.h"

@interface AMKCrashProtector (AMKCPMoviePlayerViewControllerProtector)

/// 是否启用 MPMoviePlayerViewController 异常保护（内部会转为单例的实例属性进行处理）
@property(nonatomic, assign, class) BOOL MPMoviePlayerViewControllerProtectorEnable;

/// 是否启用 MPMoviePlayerViewController 异常保护
@property(nonatomic, assign) BOOL MPMoviePlayerViewControllerProtectorEnable;

@end
