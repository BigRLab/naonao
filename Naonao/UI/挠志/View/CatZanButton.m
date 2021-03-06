//
//  CatZanButton.m
//  CatZanButton
//
//  Created by K-cat on 15/7/13.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "CatZanButton.h"

@interface CatZanButton (){
    UIImageView *_zanImageView;
    CAEmitterLayer *_effectLayer;
    UIImage *_zanImage;
    UIImage *_unZanImage;
}

@end

@implementation CatZanButton

- (instancetype)init{
    self=[super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 30, 30)];
        _zanImage=[UIImage imageNamed:@"icon_favourites_selected.png"];
        _unZanImage=[UIImage imageNamed:@"icon_favourites.png"];
        _type=CatZanButtonTypeFirework;
        [self initBaseLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _zanImage = [UIImage imageNamed:@"icon_favourites_selected.png"];
        _unZanImage = [UIImage imageNamed:@"icon_favourites.png"];
        _type=CatZanButtonTypeFirework;
        [self initBaseLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame zanImage:(UIImage *)zanImage unZanImage:(UIImage *)unZanIamge{
    self = [super initWithFrame:frame];
    if (self) {
        _zanImage = zanImage;
        _unZanImage = unZanIamge;
        _type = CatZanButtonTypeFirework;
        [self initBaseLayout];
    }
    return self;
}

/**
 *  Init base layout
 */
- (void)initBaseLayout{
    _isZan = NO;
    
    switch (_type) {
        case CatZanButtonTypeFirework:{
            _effectLayer=[CAEmitterLayer layer];
            [_effectLayer setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [self.layer addSublayer:_effectLayer];
            [_effectLayer setEmitterShape:kCAEmitterLayerCircle];
            [_effectLayer setEmitterMode:kCAEmitterLayerOutline];
            [_effectLayer setEmitterPosition:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
            [_effectLayer setEmitterSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            
            
            _zanImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [_zanImageView setImage:_unZanImage];
            [_zanImageView setUserInteractionEnabled:YES];
            [self addSubview:_zanImageView];
            
            UITapGestureRecognizer *tapImageViewGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zanAnimationPlay)];
            [_zanImageView addGestureRecognizer:tapImageViewGesture];
        }
            break;
        case CatZanButtonTypeFocus:{
            
        }
            break;
        default:
            break;
    }
}

/**
 *  An animation for zan action
 */
-(void)zanAnimationPlay{
    [self setIsZan:!self.isZan];
    if (self.clickHandler!=nil) {
        self.clickHandler(self);
    }
    
    switch (_type) {
        case CatZanButtonTypeFirework:{
            [_zanImageView setBounds:CGRectMake(0, 0, 0, 0)];
            [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
                [_zanImageView setBounds:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
                if (self.isZan) {
                    CABasicAnimation *effectLayerAnimation=[CABasicAnimation animationWithKeyPath:@"emitterCells.zanShape.birthRate"];
                    [effectLayerAnimation setFromValue:[NSNumber numberWithFloat:100]];
                    [effectLayerAnimation setToValue:[NSNumber numberWithFloat:0]];
                    [effectLayerAnimation setDuration:0.0f];
                    [effectLayerAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                    [_effectLayer addAnimation:effectLayerAnimation forKey:@"ZanCount"];
                }
            } completion:^(BOOL finished) {
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Property method
-(void)setIsZan:(BOOL)isZan{
    _isZan=isZan;
    if (isZan) {
        [_zanImageView setImage:_zanImage];
    }else{
        [_zanImageView setImage:_unZanImage];
    }
}

@end
