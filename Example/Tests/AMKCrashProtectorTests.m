//
//  AMKCrashProtectorTests.m
//  AMKCrashProtector_Tests
//
//  Created by 孟昕欣 on 2020/5/5.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AMKCrashProtector/AMKCrashProtector.h>

@interface AMKCrashProtectorTests : XCTestCase <AMKCrashProtectHandlerProtocol>

@end

@implementation AMKCrashProtectorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [AMKCrashProtector registerExceptionHandler:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [AMKCrashProtector unregisterExceptionHandler:self];
}

- (void)test_didHandleException {
    @try {
        NSMutableArray *array = @[];
        [array insertObject:@"" atIndex:1];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

#pragma mark - AMKCrashProtectHandlerProtocol

- (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception {
    NSLog(@"\n%@", exception.amkcp_crashExceptionDescription);
}

@end
