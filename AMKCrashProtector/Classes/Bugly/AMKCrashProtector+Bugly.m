//
//  AMKCrashProtector+Bugly.m
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2020/5/7.
//

#import "AMKCrashProtector+Bugly.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>
#import <Bugly/Bugly.h>

@interface Bugly (AMKCrashProtector) <AMKCrashProtectHandlerProtocol> @end

@implementation Bugly (AMKCrashProtector)

#pragma mark - AMKCrashProtectHandlerProtocol

+ (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception {
    [Bugly reportExceptionWithCategory:3 name:exception.name reason:exception.reason callStack:exception.callStackSymbols extraInfo:nil terminateApp:NO];
}

@end

@implementation AMKCrashProtector (Bugly)

+ (BOOL)BuglyEnable {
    return [[self defaultProtector] BuglyEnable];
}

+ (void)setBuglyEnable:(BOOL)BuglyEnable {
    [[self defaultProtector] setBuglyEnable:BuglyEnable];
}

- (BOOL)BuglyEnable {
    return [objc_getAssociatedObject(self, @selector(BuglyEnable)) boolValue];
}

- (void)setBuglyEnable:(BOOL)BuglyEnable {
    if (self.BuglyEnable == BuglyEnable) return;
        
    objc_setAssociatedObject(self, @selector(BuglyEnable), @(BuglyEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.BuglyEnable) {
        [self registerExceptionHandler:Bugly.class];
    } else {
        [self unregisterExceptionHandler:Bugly.class];
    }
}

@end
