//
//  AMKCPMoviePlayerViewControllerProtectorTests.m
//  AMKCrashProtector_Tests
//
//  Created by 孟昕欣 on 2020/5/7.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AMKCrashProtector/MPMoviePlayerViewController+AMKCPMoviePlayerViewControllerProtector.h>

@interface AMKCPMoviePlayerViewControllerProtectorTests : XCTestCase <AMKCrashProtectHandlerProtocol>

@end

@implementation AMKCPMoviePlayerViewControllerProtectorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [AMKCrashProtector registerExceptionHandler:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [AMKCrashProtector unregisterExceptionHandler:self];
}

- (void)testExample {
    AMKCrashProtector.MPMoviePlayerViewControllerProtectorEnable = YES;

    NSString *url =
    @"http://wv.bbtkid.com/32878619b94bee678e9131c4abbb7bd6/5eb2b452/video/n/bbt-online-bucket/4adf3845100e49cc909b847ece76d9a2/?a=0&br=0&bt=638&cr=1&cs=1&dr=0&ds=6&er=0&l=20200506195744010194099043090E1B00&lr=&qs=0&rc=M2tweDxrcHlpdDMzOmQ7M0ApPDU3aTU2ZWQzNzk8NDU3OWdiZjNvYy5zcWtfLS0zXy9zczM1Xy5iNTUwMzVfYF5fM2I6Yw%3D%3D&vl=&vr=";
    NSURL *videoURL = [NSURL URLWithString:url];
    MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
}

#pragma mark - AMKCrashProtectHandlerProtocol

- (void)crashProtector:(AMKCrashProtector *)crashProtector didHandleException:(NSException *)exception {
    NSLog(@"\n%@", exception.amkcp_crashExceptionDescription);
}

@end
