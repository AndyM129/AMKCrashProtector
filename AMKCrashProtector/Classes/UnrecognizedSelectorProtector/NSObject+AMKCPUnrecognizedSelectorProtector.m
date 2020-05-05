//
//  NSObject+AMKCPUnrecognizedSelectorProtector.m
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2018/12/11.
//

#import "NSObject+AMKCPUnrecognizedSelectorProtector.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

NSString * const AMKCPUnrecognizedSelectorProtectorClassName = @"_AMKCPUnrecognizedSelectorProtector";
NSString * const AMKCPUnrecognizedSelectorProtectorSelectorName = @"unrecognizedSelectorName";

@interface NSObject (AMKCPUnrecognizedSelectorProtector) @end

@implementation NSObject (AMKCPUnrecognizedSelectorProtector)

+ (id)AMKCPUnrecognizedSelectorProtector_performSelector:(SEL)aSelector {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelector:aSelector];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
    return 0;
}

+ (id)AMKCPUnrecognizedSelectorProtector_performSelector:(SEL)aSelector withObject:(id)object {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelector:aSelector withObject:object];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
    return 0;
}

+ (id)AMKCPUnrecognizedSelectorProtector_performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2 {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelector:aSelector withObject:object1 withObject:object2];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
    return 0;
}

+ (void)AMKCPUnrecognizedSelectorProtector_performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelectorOnMainThread:aSelector withObject:arg waitUntilDone:wait];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

+ (void)AMKCPUnrecognizedSelectorProtector_performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelectorOnMainThread:aSelector withObject:arg waitUntilDone:wait modes:array];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

- (void)AMKCPUnrecognizedSelectorProtector_performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelector:aSelector onThread:thr withObject:arg waitUntilDone:wait modes:array];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

- (void)AMKCPUnrecognizedSelectorProtector_performSelectorInBackground:(SEL)aSelector withObject:(nullable id)arg {
    @try {
        return [self AMKCPUnrecognizedSelectorProtector_performSelectorInBackground:aSelector withObject:arg];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

- (id)AMKCPUnrecognizedSelectorProtector_forwardingTargetForSelector:(SEL)aSelector {
    // 如果对象的类本事如果重写了 -forwardInvocation: 方法的话，就不应该对 -forwardingTargetForSelector: 进行重写了，否则会影响到该类型的对象原本的消息转发流程。
    BOOL overrided = class_getMethodImplementation(NSObject.class, @selector(forwardInvocation:)) != class_getMethodImplementation(self.class, @selector(forwardInvocation:));
    if (overrided) return nil;
    
    Class AMKCPUnrecognizedSelectorProtector = NSClassFromString(AMKCPUnrecognizedSelectorProtectorClassName);
    if (!AMKCPUnrecognizedSelectorProtector) {
        AMKCPUnrecognizedSelectorProtector = objc_allocateClassPair(NSObject.class, AMKCPUnrecognizedSelectorProtectorClassName.UTF8String, 0);
        objc_registerClassPair(AMKCPUnrecognizedSelectorProtector);
    }
    
    // 检查类中是否存在该方法，不存在则添加
    class_addMethod(AMKCPUnrecognizedSelectorProtector, aSelector, [self AMKCPUnrecognizedSelectorProtector_safeImplementation:aSelector], NSStringFromSelector(aSelector).UTF8String);
    
    // 转发
    id instance = [[AMKCPUnrecognizedSelectorProtector alloc] init];
    return instance;
}

// 一个安全的方法实现
- (IMP)AMKCPUnrecognizedSelectorProtector_safeImplementation:(SEL)selector {
    __weak __typeof(self) weakSelf = self;
    IMP imp = imp_implementationWithBlock(^(){
        @try {
            [NSException raise:AMKCPUnrecognizedSelectorException format:@"-[%@ %@]: unrecognized selector sent to instance %@", weakSelf.class, NSStringFromSelector(selector), weakSelf];
        } @catch (NSException *exception) {
            [AMKCrashProtector didHandleException:exception];
        }
        return 0;
    });
    return imp;
}

@end

@implementation AMKCrashProtector (AMKCPUnrecognizedSelectorProtector)

+ (BOOL)unrecognizedSelectorProtectorEnable {
    return [[self defaultProtector] unrecognizedSelectorProtectorEnable];
}

+ (void)setUnrecognizedSelectorProtectorEnable:(BOOL)unrecognizedSelectorProtectorEnable {
    [[self defaultProtector] setUnrecognizedSelectorProtectorEnable:unrecognizedSelectorProtectorEnable];
}

- (BOOL)unrecognizedSelectorProtectorEnable {
    return [objc_getAssociatedObject(self, @selector(unrecognizedSelectorProtectorEnable)) boolValue];
}

- (void)setUnrecognizedSelectorProtectorEnable:(BOOL)unrecognizedSelectorProtectorEnable {
    if (self.unrecognizedSelectorProtectorEnable == unrecognizedSelectorProtectorEnable) return;
    
    objc_setAssociatedObject(self, @selector(unrecognizedSelectorProtectorEnable), @(unrecognizedSelectorProtectorEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [NSObject amk_swizzleClassMethod:@selector(performSelector:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelector:)];
    [NSObject amk_swizzleClassMethod:@selector(performSelector:withObject:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelector:withObject:)];
    [NSObject amk_swizzleClassMethod:@selector(performSelector:withObject:withObject:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelector:withObject:withObject:)];
    [NSObject amk_swizzleClassMethod:@selector(performSelectorOnMainThread:withObject:waitUntilDone:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelectorOnMainThread:withObject:waitUntilDone:)];
    [NSObject amk_swizzleClassMethod:@selector(performSelectorOnMainThread:withObject:waitUntilDone:modes:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelectorOnMainThread:withObject:waitUntilDone:modes:)];
    [NSObject amk_swizzleClassMethod:@selector(performSelector:onThread:withObject:waitUntilDone:modes:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelector:onThread:withObject:waitUntilDone:modes:)];
    [NSObject amk_swizzleClassMethod:@selector(performSelectorInBackground:withObject:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_performSelectorInBackground:withObject:)];
    [NSObject amk_swizzleInstanceMethod:@selector(forwardingTargetForSelector:) withMethod:@selector(AMKCPUnrecognizedSelectorProtector_forwardingTargetForSelector:)];
}

@end

