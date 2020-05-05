//
//  AMKCPUnrecognizedSelectorProtectorTests.m
//  AMKCrashProtector_Tests
//
//  Created by 孟昕欣 on 2020/5/5.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AMKCrashProtector/NSObject+AMKCPUnrecognizedSelectorProtector.h>

@protocol AMKCPUnrecognizedSelectorProtectorTestProtocol <NSObject>

+ (void)xxxClassMethodWithoutParam;
+ (void)xxxClassMethodWithParam:(id)param;
+ (void)xxxClassMethodWithParam:(id)param1 and:(id)param2;

- (void)xxxInstanceMethodWithoutParam;
- (void)xxxInstanceMethodWithParam:(id)param;
- (void)xxxInstanceMethodWithParam:(id)param1 and:(id)param2;

@end

@interface NSObject (AMKCPUnrecognizedSelectorProtectorTest) <AMKCPUnrecognizedSelectorProtectorTestProtocol>

@end

#pragma mark -

@interface AMKCPUnrecognizedSelectorProtectorTests : XCTestCase <AMKCrashProtectHandlerProtocol>

@end

@implementation AMKCPUnrecognizedSelectorProtectorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [AMKCrashProtector registerExceptionHandler:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [AMKCrashProtector unregisterExceptionHandler:self];
}

/// 调用 类方法 —— 目前无解。。
//- (void)test_ClassMethodWithParams {
//    AMKCrashProtector.unrecognizedSelectorProtectorEnable = YES;
//
//    [NSObject xxxClassMethodWithoutParam];
//    [NSObject xxxClassMethodWithParam:nil];
//    [NSObject xxxClassMethodWithParam:nil and:nil];
//}

/// Perform 类方法
- (void)test_PerformClassMethodWithoutParams {
    AMKCrashProtector.unrecognizedSelectorProtectorEnable = YES;
    
    [NSObject performSelector:@selector(xxxClassMethodWithoutParam)];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:)];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:and:)];
    
    [NSObject performSelector:@selector(xxxClassMethodWithoutParam) withObject:nil];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:) withObject:nil];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:and:) withObject:nil];
    
    [NSObject performSelector:@selector(xxxClassMethodWithParam) withObject:nil withObject:nil];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:) withObject:nil withObject:nil];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:and:) withObject:nil withObject:nil];
    
    [NSObject performSelectorOnMainThread:@selector(xxxClassMethodWithParam) withObject:nil waitUntilDone:YES];
    [NSObject performSelectorOnMainThread:@selector(xxxClassMethodWithParam:) withObject:nil waitUntilDone:YES];
    [NSObject performSelectorOnMainThread:@selector(xxxClassMethodWithParam:and:) withObject:nil waitUntilDone:YES];
    
    [NSObject performSelectorOnMainThread:@selector(xxxClassMethodWithParam) withObject:nil waitUntilDone:YES modes:nil];
    [NSObject performSelectorOnMainThread:@selector(xxxClassMethodWithParam:) withObject:nil waitUntilDone:YES modes:nil];
    [NSObject performSelectorOnMainThread:@selector(xxxClassMethodWithParam:and:) withObject:nil waitUntilDone:YES modes:nil];
    
    [NSObject performSelector:@selector(xxxClassMethodWithParam) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:and:) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
    
    [NSObject performSelector:@selector(xxxClassMethodWithParam) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES modes:nil];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES modes:nil];
    [NSObject performSelector:@selector(xxxClassMethodWithParam:and:) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES modes:nil];
    
    [NSObject performSelectorInBackground:@selector(xxxClassMethodWithParam) withObject:nil];
    [NSObject performSelectorInBackground:@selector(xxxClassMethodWithParam:) withObject:nil];
    [NSObject performSelectorInBackground:@selector(xxxClassMethodWithParam:and:) withObject:nil];
}

/// 调用 实例方法
- (void)test_InstanceMethodWithParams {
    AMKCrashProtector.unrecognizedSelectorProtectorEnable = YES;
    
    id<AMKCPUnrecognizedSelectorProtectorTestProtocol> model = [NSObject new];
    
    [model xxxInstanceMethodWithoutParam];
    [model xxxInstanceMethodWithParam:nil];
    [model xxxInstanceMethodWithParam:nil and:nil];
}

/// Perform 实例方法
- (void)test_PerformInstanceMethodWithoutParams {
    AMKCrashProtector.unrecognizedSelectorProtectorEnable = YES;
    
    id<AMKCPUnrecognizedSelectorProtectorTestProtocol> model = [NSObject new];
    
    [model performSelector:@selector(xxxInstanceMethodWithParam)];
    [model performSelector:@selector(xxxInstanceMethodWithParam:)];
    [model performSelector:@selector(xxxInstanceMethodWithParam:and:)];
    
    [model performSelector:@selector(xxxInstanceMethodWithParam) withObject:nil];
    [model performSelector:@selector(xxxInstanceMethodWithParam:) withObject:nil];
    [model performSelector:@selector(xxxInstanceMethodWithParam:and:) withObject:nil];
    
    [model performSelector:@selector(xxxInstanceMethodWithParam) withObject:nil withObject:nil];
    [model performSelector:@selector(xxxInstanceMethodWithParam:) withObject:nil withObject:nil];
    [model performSelector:@selector(xxxInstanceMethodWithParam:and:) withObject:nil withObject:nil];
}

#pragma mark - AMKCrashProtectHandlerProtocol

- (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception {
    NSLog(@"\n%@", exception.amkcp_crashExceptionDescription);
}

@end
