//
//  AMKCPKeyValueCodingProtectorTest.m
//  AMKCrashProtector_Tests
//
//  Created by 孟昕欣 on 2018/12/14.
//  Copyright © 2018年 AndyM129. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AMKCrashProtector/NSObject+AMKCPKeyValueCodingProtector.h>

@interface AMKCPKeyValueCodingProtectorTest : XCTestCase <AMKCrashProtectHandlerProtocol>
@property(nonatomic, assign) NSInteger integerVariable;
@property(nonatomic, assign) BOOL boolVariable;
@property(nonatomic, strong) NSString *stringVariable;
@end

@implementation AMKCPKeyValueCodingProtectorTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [AMKCrashProtector registerExceptionHandler:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [AMKCrashProtector unregisterExceptionHandler:self];
}

- (void)test_NSKeyValueCodingProtectorEnable {
    BOOL classMethodResult = AMKCrashProtector.NSKeyValueCodingProtectorEnable;
    BOOL instanceMethodResult = AMKCrashProtector.defaultProtector.NSKeyValueCodingProtectorEnable;
    XCTAssertEqual(classMethodResult, instanceMethodResult, @"+NSKeyValueCodingProtectorEnable 与 -NSKeyValueCodingProtectorEnable 的值应该一样");
    
    AMKCrashProtector.NSKeyValueCodingProtectorEnable = !AMKCrashProtector.NSKeyValueCodingProtectorEnable;
    classMethodResult = AMKCrashProtector.NSKeyValueCodingProtectorEnable;
    instanceMethodResult = AMKCrashProtector.defaultProtector.NSKeyValueCodingProtectorEnable;
    XCTAssertEqual(classMethodResult, instanceMethodResult, @"+NSKeyValueCodingProtectorEnable 与 -NSKeyValueCodingProtectorEnable 的值应该一样");
    
    AMKCrashProtector.defaultProtector.NSKeyValueCodingProtectorEnable = !AMKCrashProtector.defaultProtector.NSKeyValueCodingProtectorEnable;
    classMethodResult = AMKCrashProtector.NSKeyValueCodingProtectorEnable;
    instanceMethodResult = AMKCrashProtector.defaultProtector.NSKeyValueCodingProtectorEnable;
    XCTAssertEqual(classMethodResult, instanceMethodResult, @"+NSKeyValueCodingProtectorEnable 与 -NSKeyValueCodingProtectorEnable 的值应该一样");
}

// 非对象属性value为nil产生的crash
- (void)test_setNilValueForKey {
    AMKCrashProtector.NSKeyValueCodingProtectorEnable = YES;
    
    [self setValue:nil forKey:@"integerVariable"];
}

// key不是object的属性产生的crash
- (void)test_setValueForUnknowKey {
    AMKCrashProtector.NSKeyValueCodingProtectorEnable = YES;
    
    [self setValue:@"value" forKey:@"unknow"];
}

// 当key为nil的时候程序会产生crash
- (void)test_setValueForNilKey {
    AMKCrashProtector.NSKeyValueCodingProtectorEnable = YES;
    
    [self setValue:@"value" forKey:nil];
}

// 如果keyPath不正确，这个时候程序也会产生crash
- (void)test_setValueForWrongKeyPath {
    AMKCrashProtector.NSKeyValueCodingProtectorEnable = YES;
    
    [self setValue:@"value" forKeyPath:@"key.path"];
}

#pragma mark - AMKCrashProtectHandlerProtocol

- (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception {
    NSLog(@"\n%@", exception.amkcp_crashExceptionDescription);
}

@end
