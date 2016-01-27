//
//  CCShareBubbles.m
//  CCShareBubbles
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "CCShareBubbles.h"
#import <QuartzCore/QuartzCore.h>

@interface CCShareBubbles ()

@end

@implementation CCShareBubbles
@synthesize delegate = _delegate,parentView;

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView {
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, radiusValue * 2, radiusValue * 2)];
    if (self) {
        self.radius = radiusValue;
        self.bubbleRadius = 40;
        self.parentView = inView;
        self.facebookBackgroundColorRGB = 0x3c5a9a;
        self.twitterBackgroundColorRGB = 0x3083be;
        self.mailBackgroundColorRGB = 0xbb54b5;
        self.googlePlusBackgroundColorRGB = 0xd95433;
        self.tumblrBackgroundColorRGB = 0x385877;
    }
    return self;
}

#pragma mark -
#pragma mark Actions

- (void)buttonWasTapped:(UIButton *)sender {
    [self shareButtonTappedWithType:sender.tag];
}

- (void)shareButtonTappedWithType:(CCShareBubbleType)buttonType {
    [self hide];
    if ([self.delegate respondsToSelector:@selector(ccShareBubbles:tappedBubbleWithType:)]) {
        [self.delegate ccShareBubbles:self tappedBubbleWithType:buttonType];
    }
}

#pragma mark -
#pragma mark Methods 
- (void)show {
  if (!self.isAnimating) {
        self.isAnimating = YES;
        [self.parentView addSubview:self];

    // create background
    bgView = [[UIView alloc] initWithFrame:self.parentView.bounds];
    UITapGestureRecognizer * tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewBackgroundTapped:)];
    [bgView addGestureRecognizer:tapges];
    [parentView insertSubview:bgView belowSubview:self];
    if (bubbles) {
        bubbles = nil;
    }
    bubbles = [[NSMutableArray alloc] init];
    if (self.showFacebookBubble) {
        UIButton * facebookBubble = [self shareButtonWithIcon:@"icon-aa-facebook.png" backgroundColor:self.facebookBackgroundColorRGB andSite:CCShareBubbleTypeFacebook];
        [self addButtonToSubview:facebookBubble];
    }
    if (self.showTwitterBubble) {
        UIButton * twitterBubble = [self shareButtonWithIcon:@"icon-aa-twitter.png" backgroundColor:self.twitterBackgroundColorRGB andSite:CCShareBubbleTypeTwitter];
        [self addButtonToSubview:twitterBubble];
    }
    if (self.showGooglePlusBubble) {
        UIButton * googlePlueBubble = [self shareButtonWithIcon:@"icon-aa-googleplus.png" backgroundColor:self.googlePlusBackgroundColorRGB andSite:CCShareBubbleTypeGooglePlus];
        [self addButtonToSubview:googlePlueBubble];
    }
    if (self.showTumblrBubble) {
        UIButton * tumblrBubble = [self shareButtonWithIcon:@"icon-aa-tumblr.png" backgroundColor:self.tumblrBackgroundColorRGB andSite:CCShareBubbleTypeTumblr];
        [self addButtonToSubview:tumblrBubble];
    }
    if (self.showMailBubble) {
        UIButton * mailBubble = [self shareButtonWithIcon:@"icon-aa-at.png" backgroundColor:self.mailBackgroundColorRGB andSite:CCShareBubbleTypeMail];
        [self addButtonToSubview:mailBubble];
    }
    if (bubbles.count == 0 ) {
        return;
    }
    float bubbleDistanceFromPivot = self.radius - self.bubbleRadius;
    float bubblesBetweenAngel = 360 / bubbles.count;
    float angely = (180 - bubblesBetweenAngel) * 0.5;
    float startAngel = 180 - angely;
    NSMutableArray * coordinates = [NSMutableArray array];
    for (int i = 0; i < bubbles.count; ++i) {
        UIButton * bubble = [bubbles objectAtIndex:i];
        bubble.tag = i;
        float angle = startAngel + i * bubblesBetweenAngel;
        float x = cos(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
        float y = sin(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
        [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x],@"x",[NSNumber numberWithFloat:y],@"y", nil]];
        bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
        bubble.center = CGPointMake(self.radius, self.radius);
    }
    
    int outnumber = 0;
    for (NSDictionary * coordinate in coordinates) {
        UIButton * bubble = [bubbles objectAtIndex:outnumber];
        float delayTime = outnumber * 0.1;
        [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble,@"button",coordinate,@"coordinate", nil] afterDelay:delayTime];
        ++ outnumber;
    }
  }
    
}

- (void)hide {
    if (!self.isAnimating) {
        self.isAnimating = YES;
        int inNumber = 0;
        for (UIButton * bubble in bubbles) {
            float delayTime = inNumber * 0.1;
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++ inNumber;
        }
    }
}

#pragma mark -
#pragma mark privote methods 

- (void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture {
    [tapGesture.view removeFromSuperview];
    [self hide];
}

- (void)showBubbleWithAnimation:(NSDictionary *)info {
    UIButton * bubble = (UIButton *)[info objectForKey:@"button"];
    NSDictionary * coordinate = (NSDictionary *)[info objectForKey:@"coordinate"];
    
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            bubble.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                bubble.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                if (bubble.tag == bubbles.count - 1) self.isAnimating = NO;
                bubble.layer.shadowColor = [UIColor blackColor].CGColor;
                bubble.layer.shadowOpacity = 0.2;
                bubble.layer.shadowOffset = CGSizeMake(0, 1);
                bubble.layer.shadowRadius = 2;
            }];
        }];
    }];
}

- (void)hideBubbleWithAnimation:(UIButton *)bubble {
  [UIView animateWithDuration:0.2 animations:^{
      bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
  } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.25 animations:^{
          bubble.center = CGPointMake(self.radius, self.radius);
          bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
          bubble.alpha = 0;
      } completion:^(BOOL finished) {
          if (bubble.tag == bubbles.count - 1) {
              self.isAnimating = NO;
              self.hidden = YES;
              [bgView removeFromSuperview];
              bgView = nil;
              [self removeFromSuperview];
          }
          [bubble removeFromSuperview];
      }];
  }];
}

- (UIButton *)shareButtonWithIcon:(NSString *)iconName backgroundColor:(int)rgb andSite:(NSInteger)site {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.bubbleRadius * 2, self.bubbleRadius * 2);
    button.tag = site;
    // circle background
    UIView * circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bubbleRadius * 2, self.bubbleRadius * 2)];
    circle.backgroundColor = [self colorFromRGB:rgb];
    circle.layer.masksToBounds = YES;
    circle.layer.cornerRadius = self.bubbleRadius;
    circle.opaque = NO;
    circle.alpha = 0.97;
    // circle icon
    UIImageView * icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    CGRect f = icon.frame;
    f.origin.x = (circle.frame.size.width - f.size.width)*0.5;
    f.origin.y = (circle.frame.size.height - f.size.height)*0.5;
    icon.frame = f;
    [circle addSubview:icon];
    
    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    return button;
}

- (UIColor *)colorFromRGB:(int)rgb {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)addButtonToSubview:(UIButton *)button {
    [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [bubbles addObject:button];
}

@end
