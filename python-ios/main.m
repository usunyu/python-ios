//
//  main.m
//  python-ios
//
//  Created by Yu Sun on 6/28/20.
//  Copyright © 2020 usunyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Python/Python.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
  NSString * appDelegateClassName;
  @autoreleasepool {
    // Setup code that might create autoreleased objects goes here.
    appDelegateClassName = NSStringFromClass([AppDelegate class]);
  }

  return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
