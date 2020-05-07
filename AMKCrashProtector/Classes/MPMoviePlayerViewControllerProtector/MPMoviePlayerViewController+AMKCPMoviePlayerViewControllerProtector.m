//
//  MPMoviePlayerViewController+AMKCPMoviePlayerViewControllerProtector.m
//  AMKCrashProtector
//
//  Created by 孟昕欣 on 2020/5/7.
//

#import "MPMoviePlayerViewController+AMKCPMoviePlayerViewControllerProtector.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MPMoviePlayerViewController (AMKCPMoviePlayerViewControllerProtector) @end

@implementation MPMoviePlayerViewController (AMKCPMoviePlayerViewControllerProtector)

// MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
// caught "NSInvalidArgumentException", "MPMoviePlayerViewController is no longer available. Use AVPlayerViewController in AVKit."
- (instancetype)AMKCPMoviePlayerViewControllerProtector_initWithContentURL:(NSURL *)contentURL {
    __typeof(&*self) instance = nil;
    @try {
        instance = [self AMKCPMoviePlayerViewControllerProtector_initWithContentURL:contentURL];
    } @catch (NSException *exception) {
        [AMKCrashProtector didHandleException:exception];
    }
    return instance;
}

@end

@implementation AMKCrashProtector (AMKCPMoviePlayerViewControllerProtector)

+ (BOOL)MPMoviePlayerViewControllerProtectorEnable {
    return [[self defaultProtector] MPMoviePlayerViewControllerProtectorEnable];
}

+ (void)setMPMoviePlayerViewControllerProtectorEnable:(BOOL)MPMoviePlayerViewControllerProtectorEnable {
    [[self defaultProtector] setMPMoviePlayerViewControllerProtectorEnable:MPMoviePlayerViewControllerProtectorEnable];
}

- (BOOL)MPMoviePlayerViewControllerProtectorEnable {
    return [objc_getAssociatedObject(self, @selector(MPMoviePlayerViewControllerProtectorEnable)) boolValue];
}

- (void)setMPMoviePlayerViewControllerProtectorEnable:(BOOL)MPMoviePlayerViewControllerProtectorEnable {
    if (self.MPMoviePlayerViewControllerProtectorEnable == MPMoviePlayerViewControllerProtectorEnable) return;
    
    objc_setAssociatedObject(self, @selector(MPMoviePlayerViewControllerProtectorEnable), @(MPMoviePlayerViewControllerProtectorEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [MPMoviePlayerViewController amk_swizzleInstanceMethod:@selector(initWithContentURL:) withMethod:@selector(AMKCPMoviePlayerViewControllerProtector_initWithContentURL:)];
}

@end
