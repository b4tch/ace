//-------------------------------------------------------------------------------------------------------
// Copyright (C) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE.txt file in the project root for full license information.
//-------------------------------------------------------------------------------------------------------
#import "TabBar.h"
#import "UIViewHelper.h"
#import "OutgoingMessages.h"

@implementation TabBar

- (id) init {
    self = [super init];
    self.delegate = self;
    return self;
}

// IHaveProperties.setProperty
- (void) setProperty:(NSString*)propertyName value:(NSObject*)propertyValue {
    if (![UIViewHelper setProperty:self propertyName:propertyName propertyValue:propertyValue]) {
        if ([propertyName hasSuffix:@".PrimaryCommands"] ||
            [propertyName hasSuffix:@".Children"]) {
            if (propertyValue == nil) {
                [items removeListener:self];
                items = nil;
            }
            else {
                items = (CommandBarElementCollection*)propertyValue;
                // Listen to collection changes
                [items addListener:self];
            }
        }
        else {
            throw [NSString stringWithFormat:@"Unhandled property for %@: %@", [self class], propertyName];
        }
    }
}

// IRecieveCollectionChanges.add
- (void) add:(NSObject*)collection item:(NSObject*)item {
    //assert collection == items;
    [self addSubview:(UIView*)item];
    [UIViewHelper resize:self];
}

// IRecieveCollectionChanges.removeAt
- (void) removeAt:(NSObject*)collection index:(int)index {
    //assert collection == items;
    UIView* view = [self subviews][index];
    [view removeFromSuperview];
    [UIViewHelper resize:self];
}

- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item {
    int index = item.tag;
    [OutgoingMessages raiseEvent:@"click" instance:items[index] eventData:nil];
}

@end
