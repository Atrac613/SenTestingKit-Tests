//
//  SenAsyncTests.m
//  SenTestingKit
//
//  Created by Osamu Noguchi on 6/8/13.
//  Copyright (c) 2013 Osamu Noguchi. All rights reserved.
//

#import "SenAsyncTests.h"

static NSTimeInterval const SenDefaultTimeoutInterval = 10.f;

@implementation SenAsyncTests

- (void)setUp
{
    [super setUp];
    
    self.timeoutInterval = SenDefaultTimeoutInterval;
    self.finished = NO;
}

- (void)tearDown
{
    double delayInSeconds = self.timeoutInterval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        STFail(@"timed out.");
        self.finished = YES;
    });
    
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
    } while (!self.isFinished);
    
    [super tearDown];
}

- (void)testHoge
{
    NSURL *URL = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *reqeust = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:reqeust
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                               STAssertEquals(statusCode, 200, nil);
                               STAssertNil(error, nil);
                               
                               self.finished = YES;
                           }];
}

@end
