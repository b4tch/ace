//-------------------------------------------------------------------------------------------------------
// Copyright (C) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE.txt file in the project root for full license information.
//-------------------------------------------------------------------------------------------------------
#import "IHaveProperties.h"
#import "IRecieveCollectionChanges.h"
#import "CommandBarElementCollection.h"

@interface TabBar : NSObject <UITabBarDelegate, IHaveProperties, IRecieveCollectionChanges>
{
    int selectedIndex;
    UITabBar* _tabBar;
    UINavigationController* _controller;
	CommandBarElementCollection* items;
}

- (void)showTabBar:(UIViewController*)viewController animated:(BOOL)animated;
@end
