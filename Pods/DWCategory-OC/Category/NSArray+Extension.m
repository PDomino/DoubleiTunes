//
//  NSArray+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "NSArray+Extension.h"
#import <objc/runtime.h>

@implementation NSArray (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sysMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method myMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(my_objectAtIndex:));
        method_exchangeImplementations(sysMethod, myMethod);
    });
}

- (id)my_objectAtIndex:(NSInteger)idx {
    if (idx >= self.count) {
        NSAssert(NO, @"不可变数组越界");
        return nil;
    }
    return [self my_objectAtIndex:idx];
}

@end
