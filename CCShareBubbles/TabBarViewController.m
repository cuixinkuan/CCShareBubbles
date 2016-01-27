//
//  TabBarViewController.m
//  CCShareBubbles
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "AddBtnViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "TabBar.h"
#import "NavigationViewController.h"

@interface TabBarViewController ()<TabBarDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBarControl];
}

- (void)createTabBarControl {
    HomeViewController * home = [[HomeViewController alloc] init];
    [self addChildViewController:home image:nil selectedIamge:nil title:@"首页"];
    MessageViewController * message = [[MessageViewController alloc] init];
    [self addChildViewController:message image:nil selectedIamge:nil title:@"消息"];
    DiscoverViewController * discover = [[DiscoverViewController alloc] init];
    [self addChildViewController:discover image:nil selectedIamge:nil title:@"发现"];
    MineViewController * mine = [[MineViewController alloc] init];
    [self addChildViewController:mine image:nil selectedIamge:nil title:@"我的"];
    
    TabBar * tabBar = [[TabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}


/**
 *  添加子控制器
 *
 *  @param childController 子控制器
 *  @param image           正常状态图片
 *  @param selectedImage   选中状态图片
 *  @param title           标题
 */
- (void)addChildViewController:(UIViewController *)childController image:(NSString *)image selectedIamge:(NSString *)selectedImage title:(NSString *)title {
    childController.title = title;
    childController.view.backgroundColor = [UIColor whiteColor];
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem字体
    NSMutableDictionary * normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0f green:123/255.0f blue:123/255.0f alpha:1.0];
    [childController.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    NSMutableDictionary * selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    // 导航控制器
    NavigationViewController * nav = [[NavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    
}


#pragma mark - 
#pragma mark TabBarDelegate
- (void)addBtnDidClick:(TabBar *)tabBar {
    AddBtnViewController * addBtnVC = [[AddBtnViewController alloc] init];
    addBtnVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:addBtnVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
