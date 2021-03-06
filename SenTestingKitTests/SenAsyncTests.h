//
//  SenAsyncTests.h
//  SenTestingKit
//
//  Created by Osamu Noguchi on 6/8/13.
//  Copyright (c) 2013 Osamu Noguchi. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface SenAsyncTests : SenTestCase

@property (nonatomic) NSTimeInterval timeoutInterval;
@property (nonatomic, getter = isFinished) BOOL finished;

@end
