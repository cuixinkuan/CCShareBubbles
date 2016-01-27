//
//  CCShareBubbles.h
//  CCShareBubbles
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCShareBubblesDelegate;
typedef enum {
    CCShareBubbleTypeFacebook = 0,
    CCShareBubbleTypeTwitter = 1,
    CCShareBubbleTypeGooglePlus = 2,
    CCShareBubbleTypeTumblr = 3,
    CCShareBubbleTypeMail = 4,
}CCShareBubbleType;


@interface CCShareBubbles : UIView
{
    NSMutableArray * bubbles;
    UIView * bgView;
}

@property (nonatomic,assign) id <CCShareBubblesDelegate> delegate;

@property (nonatomic,assign)BOOL showFacebookBubble;
@property (nonatomic,assign)BOOL showTwitterBubble;
@property (nonatomic,assign)BOOL showGooglePlusBubble;
@property (nonatomic,assign)BOOL showTumblrBubble;
@property (nonatomic,assign)BOOL showMailBubble;

@property (nonatomic,assign)int radius;
@property (nonatomic,assign)int bubbleRadius;
@property (nonatomic,assign)BOOL isAnimating;
@property (nonatomic,weak)UIView * parentView;

@property (nonatomic,assign)int facebookBackgroundColorRGB;
@property (nonatomic,assign)int twitterBackgroundColorRGB;
@property (nonatomic,assign)int googlePlusBackgroundColorRGB;
@property (nonatomic,assign)int tumblrBackgroundColorRGB;
@property (nonatomic,assign)int mailBackgroundColorRGB;

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView;
- (void)show;
- (void)hide;

@end


@protocol CCShareBubblesDelegate <NSObject>

- (void)ccShareBubbles:(CCShareBubbles *)shareBubbles tappedBubbleWithType:(CCShareBubbleType)bubbleType;

@end
