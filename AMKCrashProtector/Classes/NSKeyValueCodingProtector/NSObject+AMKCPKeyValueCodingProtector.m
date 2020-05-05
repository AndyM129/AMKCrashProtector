//
//  NSObject+AMKCPKeyValueCodingProtector.m
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2018/12/14.
//

#import "NSObject+AMKCPKeyValueCodingProtector.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@implementation NSObject (AMKCPKeyValueCodingProtector)

// [self setValue:@"value" forKey:nil];
// caught "NSInvalidArgumentException", "*** -[AMKCPKeyValueCodingProtectorTest setValue:forKey:]: attempt to set a value for a nil key"
- (void)AMKCPKeyValueCodingProtector_setValue:(id)value forKey:(NSString *)key {
    @try {
        return [self AMKCPKeyValueCodingProtector_setValue:value forKey:key];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

// [self setValue:@"value" forKeyPath:@"key.path"];
// caught "NSUnknownKeyException", "[<AMKCPKeyValueCodingProtectorTest 0x6080000554b0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key key."
- (id)AMKCPKeyValueCodingProtector_valueForUndefinedKey:(NSString *)key {
    @try {
        return [self AMKCPKeyValueCodingProtector_valueForUndefinedKey:key];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
    return 0;
}

// [self setValue:@"value" forKey:@"unknow"];
// caught "NSUnknownKeyException", "[<AMKCPKeyValueCodingProtectorTest 0x61400005ba80> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key unknow."
- (void)AMKCPKeyValueCodingProtector_setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    @try {
        return [self AMKCPKeyValueCodingProtector_setValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

// [self setValue:nil forKey:@"integerVariable"];
// caught "NSInvalidArgumentException", "[<AMKCPKeyValueCodingProtectorTest 0x614000453fe0> setNilValueForKey]: could not set nil as the value for the key integerVariable."
- (void)AMKCPKeyValueCodingProtector_setNilValueForKey:(NSString *)key {
    @try {
        return [self AMKCPKeyValueCodingProtector_setNilValueForKey:key];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
}

@end

@implementation AMKCrashProtector (AMKCPKeyValueCodingProtector)

+ (BOOL)NSKeyValueCodingProtectorEnable {
    return [[self defaultProtector] NSKeyValueCodingProtectorEnable];
}

+ (void)setNSKeyValueCodingProtectorEnable:(BOOL)NSKeyValueCodingProtectorEnable {
    [[self defaultProtector] setNSKeyValueCodingProtectorEnable:NSKeyValueCodingProtectorEnable];
}

- (BOOL)NSKeyValueCodingProtectorEnable {
    return [objc_getAssociatedObject(self, @selector(NSKeyValueCodingProtectorEnable)) boolValue];
}

- (void)setNSKeyValueCodingProtectorEnable:(BOOL)NSKeyValueCodingProtectorEnable {
    if (self.NSKeyValueCodingProtectorEnable == NSKeyValueCodingProtectorEnable) return;
    
    objc_setAssociatedObject(self, @selector(NSKeyValueCodingProtectorEnable), @(NSKeyValueCodingProtectorEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [NSObject amk_swizzleInstanceMethod:@selector(setValue:forKey:) withMethod:@selector(AMKCPKeyValueCodingProtector_setValue:forKey:)];
    [NSObject amk_swizzleInstanceMethod:@selector(valueForUndefinedKey:) withMethod:@selector(AMKCPKeyValueCodingProtector_valueForUndefinedKey:)];
    [NSObject amk_swizzleInstanceMethod:@selector(setValue:forUndefinedKey:) withMethod:@selector(AMKCPKeyValueCodingProtector_setValue:forUndefinedKey:)];
    [NSObject amk_swizzleInstanceMethod:@selector(setNilValueForKey:) withMethod:@selector(AMKCPKeyValueCodingProtector_setNilValueForKey:)];
}

@end
