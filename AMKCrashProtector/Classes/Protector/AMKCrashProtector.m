//
//  AMKCrashProtector.m
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2018/12/11.
//

#import "AMKCrashProtector.h"

@interface AMKCrashProtector ()
@property(nonatomic, strong) NSHashTable *exceptionHandlers;
@end

@implementation AMKCrashProtector

#pragma mark - Init Methods

- (void)dealloc {
    
}

+ (AMKCrashProtector *)defaultProtector {
    static AMKCrashProtector *_defaultProtector = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _defaultProtector = [[super allocWithZone:nil] init];
    });
    return _defaultProtector ;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self defaultProtector];
}

- (id)copy {
    return [self.class defaultProtector];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Properties

- (NSHashTable *)exceptionHandlers {
    if (!_exceptionHandlers) {
        _exceptionHandlers = [NSHashTable weakObjectsHashTable];
    }
    return _exceptionHandlers;
}

#pragma mark - Public Methods

+ (void)registerExceptionHandler:(id<AMKCrashProtectHandlerProtocol>)exceptionHandler {
    [[self defaultProtector] registerExceptionHandler:exceptionHandler];
}

- (void)registerExceptionHandler:(id<AMKCrashProtectHandlerProtocol>)exceptionHandler {
    [self.exceptionHandlers addObject:exceptionHandler];
}

+ (void)unregisterExceptionHandler:(id<AMKCrashProtectHandlerProtocol>)exceptionHandler {
    [[self defaultProtector] unregisterExceptionHandler:exceptionHandler];
}

- (void)unregisterExceptionHandler:(id<AMKCrashProtectHandlerProtocol>)exceptionHandler {
    [self.exceptionHandlers removeObject:exceptionHandler];
}

+ (void)didHandleException:(NSException *)exception {
    [[self defaultProtector] didHandleException:exception];
}

- (void)didHandleException:(NSException *)exception {
    for (id exceptionHandler in self.exceptionHandlers) {
        if ([exceptionHandler respondsToSelector:@selector(crashProtector:didHandleException:)]) {
            [exceptionHandler crashProtector:self didHandleException:exception];
        }
    }
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
