//
//  TabBar.h
//  CCShareBubbles
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar;
@protocol TabBarDelegate <NSObject>

@optional
- (void)addBtnDidClick:(TabBar *)tabBar;

@end

@interface TabBar : UITabBar

@property (nonatomic,weak)id <TabBarDelegate> delegate;

@end
