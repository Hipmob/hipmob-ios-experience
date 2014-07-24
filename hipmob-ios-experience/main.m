//
//  main.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        int retVal = -1;
        @try {
            retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([HMAppDelegate class]));
        }
        @catch (NSException* exception) {
            NSLog(@"Uncaught exception: %@", exception.description);
            NSLog(@"Stack trace: %@", [exception callStackSymbols]);
        }
        return retVal;
    }
}
