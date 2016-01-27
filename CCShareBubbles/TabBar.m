//
//  TabBar.m
//  CCShareBubbles
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "TabBar.h"
#import "UIView+Extension.h"

@interface TabBar ()

@property (nonatomic,strong)UIButton * addBtn;

@end

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化中间的加按钮
        UIButton * addBtn = [[UIButton alloc] init];
        [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
//        addBtn.size = addBtn.currentBackgroundImage.size;
        addBtn.size = CGSizeMake(40, 40);
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn = addBtn;
        [self addSubview:addBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.addBtn.centerX = self.width * 0.5;
    self.addBtn.centerY = self.height * 0.5;
    // 从新布局tabBar上的tabBarItem
    CGFloat tabBarItemWidth = self.width / 5;
    CGFloat tabBarItemHeight = 44;
    CGFloat tabBarItemIndex = 0;
    for (UIView * childItem in self.subviews) {
        if ([childItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            childItem.width = tabBarItemWidth;
            childItem.height = tabBarItemHeight;
            childItem.x = tabBarItemIndex * tabBarItemWidth;
            tabBarItemIndex ++;
            if (tabBarItemIndex == 2) {
                tabBarItemIndex ++;
            }
        }
    }
}


// 中间加号点击事件
- (void)addBtnClick {
    if ([self.delegate respondsToSelector:@selector(addBtnDidClick:)]) {
        [self.delegate addBtnDidClick:self];
    }

}


@end
