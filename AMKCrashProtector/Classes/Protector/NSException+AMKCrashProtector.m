//
//  NSException+AMKCrashProtector.m
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2019/2/28.
//

#import "NSException+AMKCrashProtector.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@interface NSException (_AMKCrashProtector)

@end

@implementation NSException (AMKCrashProtector)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSException amk_swizzleInstanceMethod:@selector(initWithName:reason:userInfo:) withMethod:@selector(amkcp_initWithName:reason:userInfo:)];
        [NSException amk_swizzleInstanceMethod:@selector(description) withMethod:@selector(amkcp_description)];
    });
}

#pragma mark - Init Methods

- (instancetype)amkcp_initWithName:(NSExceptionName)aName reason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo {
    __typeof(self) instance = [self amkcp_initWithName:aName reason:aReason userInfo:aUserInfo];
    return instance;
}

+ (NSException *)amkcp_exceptionWithName:(NSExceptionName)name reason:(NSString *)reason userInfoBlock:(AMKCPExceptionUserInfoBlock)userInfoBlock {
    NSMutableDictionary *userInfo = nil;
    if (userInfoBlock) {
        userInfo = [NSMutableDictionary dictionary];
        userInfoBlock(userInfo);
    }
    return [self exceptionWithName:name reason:reason userInfo:userInfo];
}

#pragma mark - Properties

#pragma mark - Public Methods

- (NSString *)amkcp_crashExceptionDescription {
    return [NSString stringWithFormat:@"*** Almost terminated app due to uncaught exception '%@', reason: '%@', userInfo: %@\n*** First throw call stack:\n%@\n***", self.name, self.reason, self.userInfo, self.callStackSymbols];
}

- (NSDictionary *)amkcp_crashExceptionInfo {
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"name"] = self.name ?: @"";
    dict[@"reason"] = self.reason ?: @"";
    dict[@"userInfo"] = self.userInfo ?: @{};
    dict[@"callStackSymbols"] = self.callStackSymbols ?: @[];
    return dict;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
