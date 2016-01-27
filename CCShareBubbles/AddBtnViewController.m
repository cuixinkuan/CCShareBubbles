//
//  AddBtnViewController.m
//  CCShareBubbles
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "AddBtnViewController.h"
#import "CCShareBubbles.h"
#import "UIView+Extension.h"

@interface AddBtnViewController ()<CCShareBubblesDelegate>
{
    CCShareBubbles * shareBubbles;
    float radius;
    float bubbleRadius;
}

@end

@implementation AddBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    radius = 150;
    bubbleRadius = 50;
    [self initWithShareButton];
}

/**
 *  初始化分享按钮
 */
- (void)initWithShareButton {
    UIButton * shareButton = [[UIButton alloc] init];
    shareButton.frame = CGRectMake((self.view.width - 100) / 2, (self.view.height - 100) / 2, 100, 100);
    shareButton.layer.masksToBounds = YES;
    shareButton.layer.cornerRadius = 50;
    [shareButton setBackgroundColor:[UIColor orangeColor]];
    [shareButton setTitle:@"点击开始分享" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [shareButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
}

- (void)shareButtonClick {
    if (shareBubbles) {
        shareBubbles = nil;
    }
    shareBubbles = [[CCShareBubbles alloc] initWithPoint:self.view.center radius:radius inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = bubbleRadius;
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showGooglePlusBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showTumblrBubble = YES;
    shareBubbles.showMailBubble = YES;
    [shareBubbles show];
}

#pragma mark - 
#pragma mark CCShareBubblesDelegate

- (void)ccShareBubbles:(CCShareBubbles *)shareBubbles tappedBubbleWithType:(CCShareBubbleType)bubbleType {
  // 实现具体的分享内容
    switch (bubbleType) {
        case CCShareBubbleTypeFacebook:
        {
          //share to facebook
            NSLog(@"----------> share to facebook !");
        }
            break;
        case CCShareBubbleTypeTwitter:
        {
            //share to Twitter
            NSLog(@"----------> share to Twitter !");
        }
            break;
        case CCShareBubbleTypeGooglePlus:
        {
            //share to GooglePlus
            NSLog(@"----------> share to GooglePlus !");
        }
            break;
        case CCShareBubbleTypeTumblr:
        {
            //share to Tumblr
            NSLog(@"----------> share to Tumblr !");
        }
            break;
        case CCShareBubbleTypeMail:
        {
            //share to Mail
            NSLog(@"----------> share to Mail !");
        }
            break;
            
        default:
            break;
    }
}


// 触摸响应
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
