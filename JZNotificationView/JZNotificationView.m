//
//  JZNotificationView.m
//  JZNotificationView
//
//  Created by Joshua Zhou on 14/11/24.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "JZNotificationView.h"

#define margin                  8
#define iconViewLeadingPadding  16
#define iconViewWidth           30
#define iconViewHeight          iconViewWidth

#define headlineLabelTrailingPadding 8
#define headlineLabelHeight          15
#define messageLabelTrailingPadding  headlineLabelTrailingPadding

#define notificationStayTime    2.0

@interface JZNotificationView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *headlineLabel;
@property (nonatomic, weak) UILabel *messageLabel;

@end

@implementation JZNotificationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *headlineLabel = [[UILabel alloc] init];
        headlineLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self addSubview:headlineLabel];
        self.headlineLabel = headlineLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:messageLabel];
        self.messageLabel = messageLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bounds = CGRectMake(0, 0, self.bounds.size.width, 64);
//    CGFloat iconViewY = (self.bounds.size.height - iconViewHeight) / 2;
    self.iconView.frame = CGRectMake(iconViewLeadingPadding, iconViewLeadingPadding, iconViewWidth, iconViewHeight);
    self.iconView.center = CGPointMake(iconViewLeadingPadding + iconViewWidth / 2, self.bounds.size.height / 2);
    
    CGFloat headlineLabelX = iconViewLeadingPadding + iconViewWidth + margin;
    CGFloat headlineLabelWidth = self.bounds.size.width - headlineLabelTrailingPadding - headlineLabelX;
    self.headlineLabel.frame = CGRectMake(headlineLabelX, iconViewLeadingPadding - 4, headlineLabelWidth, headlineLabelHeight);
    
    CGFloat messageLabelY = CGRectGetMaxY(self.headlineLabel.frame) + margin;
    self.messageLabel.frame = CGRectMake(headlineLabelX, messageLabelY, headlineLabelWidth, self.bounds.size.height - messageLabelY - margin);
}

+ (void)showWithIcon:(UIImage *)image headline:(NSString *)headline message:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    
    JZNotificationView *notificationView = [[JZNotificationView alloc] initWithFrame:CGRectMake(0, -64, view.bounds.size.width, 64)];
    notificationView.iconView.image = image;
    notificationView.headlineLabel.text = headline;
    notificationView.messageLabel.text = message;
    
    [view addSubview:notificationView];
    [UIView animateWithDuration:0.8 animations:^{
        notificationView.transform = CGAffineTransformMakeTranslation(0, 64);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.8 delay:notificationStayTime options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            notificationView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

+ (void)showSuccessWithHeadline:(NSString *)headline message:(NSString *)message
{
    [JZNotificationView showWithIcon:[UIImage imageNamed:@"Success"] headline:headline message:message];
}

+ (void)showFailureWithHeadline:(NSString *)headline message:(NSString *)message
{
    [JZNotificationView showWithIcon:[UIImage imageNamed:@"Failure"] headline:headline message:message];
}

+ (void)showWarningWithHeadline:(NSString *)headline message:(NSString *)message
{
    [JZNotificationView showWithIcon:[UIImage imageNamed:@"Warning"] headline:headline message:message];
}

@end
