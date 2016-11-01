//
//  AnimationViewController.m
//  UIViewAnimationDemo
//
//  Created by Chris Hu on 15/9/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "AnimationViewController.h"
#import "Pop.h"

typedef NS_ENUM(NSInteger, enumDemoAnimation) {
    // UIView Animation
    demoPositionAnimation = 0,
    demoOpacityAnimation,
    demoScaleAnimation,
    demoColorAnimation,
    demoRotationAnimation,
    demoUIImageCountDown,
    demoCountDownAnimation,
    demoTearOffAnimation,
    
    // Key Frame Animation
    demoKeyFrameAnimation,
    
    // Core Animation
    demoPageCurlAnimation,
    demoFlipAnimation,
    
    // Pop Animation
    demoPOPBasicAnimation,
    demoPOPSpringAnimation,
    demoPOPDecayAnimation,
    demoPOPAnimatableProperty,
};

@interface AnimationViewController ()
<
    CAAnimationDelegate
>

@end

@implementation AnimationViewController {
    NSArray *sections;
    NSArray *uiViewAnimations;
    NSArray *layoutAnimations;
    NSArray *keyFrameAnimations;
    NSArray *coreAnimations;
    NSArray *popAnimations;
    
    NSMutableArray *demosAnimation;
    
    UIView *view1;
    UIView *view2;
    BOOL animated;
    UIImageView *imageView;
    UILabel *lbCountDown;
    NSInteger countdown;
    NSTimer *timer;
    
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _item;
    animated = NO;
    countdown = 3;
    
    sections =              @[@"- UIView Animation",
                              @"- Layout Animation",
                              @"- Key Frame Animation",
                              @"- Core Animation",
                              @"- Pop Animation"];
    
    uiViewAnimations =      @[@"Position",
                              @"Opacity",
                              @"Scale",
                              @"Color",
                              @"Rotation",
                              @"UIImageView Countdown",
                              @"Countdown",
                              @"Tear Off"];
    layoutAnimations =      @[@"NSLayoutConstraint"];    
    keyFrameAnimations =    @[@"Key Frame Animation"];
    coreAnimations =        @[@"CA Page Curl",
                              @"CA Flip"];
    popAnimations =         @[@"POPBasicAnimation",
                              @"POPSpringAnimation",
                              @"POPDecayAnimation",
                              @"POPAnimatableProperty"];
    
    demosAnimation = [NSMutableArray arrayWithCapacity:0];
    [demosAnimation addObjectsFromArray:uiViewAnimations];
    [demosAnimation addObjectsFromArray:keyFrameAnimations];
    [demosAnimation addObjectsFromArray:coreAnimations];
    [demosAnimation addObjectsFromArray:popAnimations];

    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    view1.backgroundColor =[UIColor blueColor];
    [self.view addSubview:view1];

    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 100, 100)];
    view2.backgroundColor =[UIColor greenColor];
    [self.view addSubview:view2];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    label.hidden = YES;
    [self.view addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, 44)];
    [btn setTitle:@"Start Animation" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.layer.borderColor = [[UIColor grayColor] CGColor];
    btn.layer.borderWidth = 2.0f;
    [btn addTarget:self action:@selector(demosAnimationStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)demosAnimationStart:(UIButton *)sender {
    switch ([demosAnimation indexOfObject:_item]) {
        // - UIView Animation
        case demoPositionAnimation:
            [self demoPositionAnimation];
            [self addPauseAndContinue];
            break;
        case demoOpacityAnimation:
            [self demoOpacityAnimation];
            break;
        case demoScaleAnimation:
            [self demoScaleAnimation];
            break;
        case demoColorAnimation:
            [self demoColorAnimation];
            break;
        case demoRotationAnimation:
            [self demoRotationAnimation];
            break;
        case demoUIImageCountDown:
            [self demoUIImageCountDown];
            break;
        case demoCountDownAnimation:
            [self demoCountDownAnimation];
            break;
        case demoTearOffAnimation:
            [self demoTearOffAnimation];
            break;
            
        // - Key Frame Animation
        case demoKeyFrameAnimation:
            [self demoKeyFrameAnimation];
            break;
            
        // - Core Animation
        case demoPageCurlAnimation:
            [self demoPageCurlAnimation];
            break;
        case demoFlipAnimation:
            [self demoFlipAnimation];
            break;
            
        // - Pop Animation
        case demoPOPBasicAnimation:
            [self demoPOPBasicAnimation];
            break;
        case demoPOPSpringAnimation:
            [self demoPOPSpringAnimation];
            break;
        case demoPOPDecayAnimation:
            [self demoPOPDecayAnimation];
            break;
        case demoPOPAnimatableProperty:
            [self demoPOPAnimatableProperty];
            break;
        default:
            break;
    }
}

#pragma mark - UIView Animation

- (void)demoPositionAnimation {
    if (!animated) {
        [UIView animateWithDuration:10.0 animations:^{
            view1.frame = CGRectMake(self.view.frame.size.width - 100, 100, 100, 100);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2.0 animations:^{
                view2.center = self.view.center;
            } completion:^(BOOL finished) {
                animated = YES;
            }];
        }];
    } else {
        [UIView animateWithDuration:2.0 animations:^{
            view1.frame = CGRectMake(0, 100, 100, 100);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2.0 animations:^{
                view2.center = CGPointMake(50, 300);
            } completion:^(BOOL finished) {
                animated = NO;
            }];
        }];
    }
}

- (void)demoOpacityAnimation {
    if (!animated) {
        [UIView animateWithDuration:2.0 animations:^{
            view1.alpha = 0.1;
        } completion:^(BOOL finished) {
            animated = YES;
        }];
    } else {
        [UIView animateWithDuration:2.0 animations:^{
            view1.alpha = 1.0;
        } completion:^(BOOL finished) {
            animated = NO;
        }];
    }
}

- (void)demoScaleAnimation {
    if (!animated) {
        [UIView animateWithDuration:1.0 animations:^{
            view1.transform = CGAffineTransformMakeScale(2.0, 2.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                view2.transform = CGAffineTransformMakeScale(2.0, 2.0);
            } completion:^(BOOL finished) {
                animated = YES;
            }];
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            view1.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                animated = NO;
            }];
        }];
    }
}

- (void)demoColorAnimation {
    if (!animated) {
        [UIView animateWithDuration:1.0 animations:^{
            view1.backgroundColor = [UIColor greenColor];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                view2.backgroundColor = [UIColor blueColor];
            } completion:^(BOOL finished) {
                animated = YES;
            }];
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            view1.backgroundColor = [UIColor blueColor];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                view2.backgroundColor = [UIColor greenColor];
            } completion:^(BOOL finished) {
                animated = NO;
            }];
        }];
    }
}

- (void)demoRotationAnimation {
    if (!animated) {
        [UIView animateWithDuration:1.0 animations:^{
            view1.transform = CGAffineTransformMakeRotation(1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                view2.transform = CGAffineTransformRotate(view2.transform, (CGFloat)M_PI);
            } completion:^(BOOL finished) {
                [self demoRotationAnimation];
            }];
        }];
    }
}

- (void)demoUIImageCountDown {
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= 3; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)(3 - i + 1)]]];
    }
    imageView.animationImages = images;
    imageView.animationRepeatCount = 0;
    imageView.animationDuration = 3;
    [imageView startAnimating];
}

- (void)demoCountDownAnimation {
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    
    lbCountDown = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    lbCountDown.backgroundColor = [UIColor grayColor];
    lbCountDown.center = self.view.center;
    lbCountDown.textAlignment = NSTextAlignmentCenter;
    lbCountDown.font = [UIFont systemFontOfSize:70];
    [self.view addSubview:lbCountDown];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)countDown {
//    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)countdown]];
//    imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    imageView.alpha = 1.0;
    
    lbCountDown.text = [NSString stringWithFormat:@"%ld", (long)countdown];
    lbCountDown.transform = CGAffineTransformMakeScale(1.0, 1.0);
    lbCountDown.alpha = 1.0;
    
    if (countdown < 1) {
        [lbCountDown removeFromSuperview];
        [timer invalidate];
        return;
    }
    NSLog(@"countdown : %ld", (long)countdown);
    countdown--;
    [UIView animateWithDuration:1.0 animations:^{
//        imageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
//        imageView.alpha = 0.0;
        
        lbCountDown.transform = CGAffineTransformMakeScale(2.0, 2.0);
        lbCountDown.alpha = 0.0;
    } completion:^(BOOL finished) {
    }];
}

- (void)demoTearOffAnimation {
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    
    UIImage *image0 = [UIImage imageNamed:@"tearoff_0.jpg"];
    
    // left, 原图和效果图都不变，而viewLeft的frame的width逐渐减为0，结合clipsToBounds属性，生成tearoff效果。
    // 原图放在viewLeft中
    CGRect rectLeft = CGRectMake(0, 0, self.view.frame.size.width / 2, 350);
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:rectLeft];
    imageView1.image = [UIImage imageNamed:@"tearoff_1.jpg"];
    [self.view addSubview:imageView1];
    
    UIView *viewLeft = [[UIView alloc] initWithFrame:rectLeft];
    viewLeft.clipsToBounds = YES;
    [self.view addSubview:viewLeft];
    
    UIImageView *imageView0Left = [[UIImageView alloc] initWithFrame:rectLeft];
    imageView0Left.image = image0;
    [viewLeft addSubview:imageView0Left];
    
    // right，原图和效果图都不变，而viewRight的frame的width从0逐渐增大，结合clipsToBounds属性，生成tearoff效果。
    // 效果图放在viewRight中
    CGRect rectRight = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 350);
    
    UIImageView *imageView0Right = [[UIImageView alloc] initWithFrame:rectRight];
    imageView0Right.image = image0;
    [self.view addSubview:imageView0Right];
    
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 0, 0, 350)];
    viewRight.clipsToBounds = YES;
    [self.view addSubview:viewRight];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, 350)];
    imageView2.image = [UIImage imageNamed:@"tearoff_2.jpg"];
    [viewRight addSubview:imageView2];
    
    if (!animated) {
        [UIView animateWithDuration:2.0 animations:^{
            viewLeft.frame = CGRectMake(0, 0, 0, 350);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2.0 animations:^{
                viewRight.frame = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 350);
            }];
        }];
    }
}

#pragma mark - Key Frame Animation

- (void)demoKeyFrameAnimation {
    // 关键帧动画作用在CALayer上
    CALayer *layer1 = view1.layer;
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation1.values = @[@(layer1.position.x), @(layer1.position.x + 100), @(layer1.position.x + 200), @(layer1.position.x + 100), @(layer1.position.x)];
    animation1.autoreverses = NO;
    animation1.repeatCount = MAXFLOAT;
    animation1.duration = 2.0;
    [layer1 addAnimation:animation1 forKey:@"position.x"];
    
    
    CALayer *layer2 = view2.layer;
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 分为几段
    NSValue *value0 = [NSValue valueWithCGPoint:layer2.position];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(layer2.position.x, layer2.position.y + 200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(layer2.position.x + 200, layer2.position.y + 200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(layer2.position.x + 200, layer2.position.y)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(layer2.position.x, layer2.position.y)];
    animation2.values = @[value0, value1, value2, value3, value4];
    
    // 每一段的运行速率
    CAMediaTimingFunction *cf0 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CAMediaTimingFunction *cf1 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *cf2 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *cf3 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAMediaTimingFunction *cf4 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation2.timingFunctions = @[cf0, cf1, cf2, cf3, cf4];
    
    // 每一段的运行时间
    animation2.keyTimes = @[@0.1, @0.2, @0.5, @1.0, @0.5];
    
    animation2.autoreverses = NO;
    animation2.repeatCount = MAXFLOAT;
    animation2.duration = 5.0;
    [layer2 addAnimation:animation2 forKey:@"position"];
}

#pragma mark - Core Animation

/**
 *  PageCurl：将当前CALayer截图，然后做翻页动画
 */
- (void)demoPageCurlAnimation {
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    
    UIImageView *imageViewFlip = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 150, 100, 300, 400)];
    imageViewFlip.image = [UIImage imageNamed:@"Model.jpg"];
    [self.view addSubview:imageViewFlip];
    
    // CATransition作用于Layer上。
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    animation.type = @"pageCurl"; // type指定了过渡的种类（淡化，推挤，揭开，覆盖）。
    // CATransition动画的私有类型有立方体，吸收，翻转，波纹，翻页，镜头
    animation.subtype = kCATransitionFromBottom; // 指定过渡的方向（上下左右）。
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

- (void)demoFlipAnimation {
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    
    UIImageView *imageViewFlip = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 150, 100, 300, 400)];
    imageViewFlip.image = [UIImage imageNamed:@"Model.jpg"];
    [self.view addSubview:imageViewFlip];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 500.0; // 使用透视效果
    transform = CATransform3DRotate(transform, - M_PI_2, 0, 1, 0);
//    imageViewFlip.layer.transform = transform;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 2.0f;
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.delegate = self;
    [imageViewFlip.layer addAnimation:animation forKey:@"animationRotate"];
    
    
//    // rotate
//    CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 1.0, 0); // 绕Y轴旋转
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.toValue = [NSValue valueWithCATransform3D:transform];
//    animation.duration = 2.0f;
//    animation.autoreverses = NO;
//    animation.cumulative = NO;
//    animation.repeatCount = 0;
//    animation.beginTime = 0.0f;
//    animation.delegate = self;
//    
////    imageViewFlip.layer.anchorPoint = CGPointMake(0, 0);
//    [imageViewFlip.layer addAnimation:animation forKey:@"animationRotate"];
    
    
//    // scale
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.duration = 2.0f;
//    animation.autoreverses = YES;
//    animation.repeatCount = FLT_MAX;
//    animation.removedOnCompletion = NO;
//    animation.toValue = [NSNumber numberWithDouble:2.0];
//    animation.delegate = self;
//    [imageViewFlip.layer addAnimation:animation forKey:@"animationFalling"];
    
    
//    // falling down
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    animation.duration = 2.0f;
//    animation.autoreverses = NO;
//    animation.removedOnCompletion = NO;
//    animation.repeatCount = FLT_MAX;
//    animation.fromValue = [NSNumber numberWithInt: 0];
//    animation.toValue = [NSNumber numberWithInt: 1024];
//    animation.delegate = self;
//    [imageViewFlip.layer addAnimation:animation forKey:@"animationFalling"];
}

#pragma mark - Pop

- (void)demoPOPBasicAnimation {
    POPBasicAnimation *basic1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    basic1.toValue = @(view1.center.x + 200);
    basic1.beginTime = CACurrentMediaTime() + 0.5f;
    [view1 pop_addAnimation:basic1 forKey:@"position"];
    
    POPBasicAnimation *basic2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    basic2.toValue = [NSValue valueWithCGPoint:self.view.center];
    basic2.beginTime = CACurrentMediaTime() + 1.0f;
    [view2 pop_addAnimation:basic2 forKey:@"center"];

    POPBasicAnimation *basic3 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    basic3.fromValue = @(1.0);
    basic3.toValue = @(0.0);
    [view1 pop_addAnimation:basic3 forKey:@"fade"];
    
    POPSpringAnimation *basic4 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    basic4.fromValue = [NSValue valueWithCGRect:view2.frame];
    basic4.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 300, 300)];
    [view2.layer pop_addAnimation:basic4 forKey:@"size"];
}

- (void)demoPOPSpringAnimation
{
    //springBounciness:4.0    //[0-20] 弹力 越大则震动幅度越大
    //springSpeed     :12.0   //[0-20] 速度 越大则动画结束越快
    //dynamicsTension :0      //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
    //dynamicsFriction:0      //摩擦 同上
    //dynamicsMass    :0      //质量 同上
    POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim1.toValue = @(view1.center.x + 200);
    anim1.springBounciness = 20.f;
    [view1 pop_addAnimation:anim1 forKey:@"position"];
}

- (void)demoPOPDecayAnimation
{
    //deceleration:0.998  //衰减系数(越小则衰减得越快)
    //对POPDecayAnimation设置toValue是没有意义的 会被忽略(因为目的状态是动态计算得到的)
    POPDecayAnimation *anDecay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anDecay.velocity = @(600); // 初始速度,采用默认衰减系数.
    anDecay.beginTime = CACurrentMediaTime();
    [view1 pop_addAnimation:anDecay forKey:@"position"];
}

- (void)demoPOPAnimatableProperty {
    POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lb = (UILabel *)obj;
            lb.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                                (int)values[0] / 60,
                                                (int)values[0] % 60,
                                                (int)(values[0] * 100) % 100
                          ];
        };
    }];
    
    label.hidden = NO;
    
    POPBasicAnimation *basic = [POPBasicAnimation linearAnimation];
    basic.property = property; // 自定义属性
    basic.fromValue = @(0);
    basic.toValue = @(10 * 60);
    basic.duration = 10 * 60;
    basic.beginTime = CACurrentMediaTime() + 1.0f;
    [label pop_addAnimation:basic forKey:@"countdown"];
}

#pragma mark - pause and continue

- (void)addPauseAndContinue {
    UIButton *btnPause = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 150, 150, 44)];
    [btnPause setTitle:@"Pause" forState:UIControlStateNormal];
    [btnPause setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnPause setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btnPause.layer.borderColor = [[UIColor grayColor] CGColor];
    btnPause.layer.borderWidth = 2.0f;
    [btnPause addTarget:self action:@selector(demosAnimationPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPause];
    
    UIButton *btnContinue = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 150, self.view.frame.size.height - 150, 150, 44)];
    [btnContinue setTitle:@"Continue" forState:UIControlStateNormal];
    [btnContinue setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnContinue setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btnContinue.layer.borderColor = [[UIColor grayColor] CGColor];
    btnContinue.layer.borderWidth = 2.0f;
    [btnContinue addTarget:self action:@selector(demosAnimationContinue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnContinue];
    
    UIButton *btnSpeedup = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height -200, 150, 44)];
    [btnSpeedup setTitle:@"Speed up" forState:UIControlStateNormal];
    [btnSpeedup setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnSpeedup setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btnSpeedup.layer.borderColor = [[UIColor grayColor] CGColor];
    btnSpeedup.layer.borderWidth = 2.0f;
    [btnSpeedup addTarget:self action:@selector(demosAnimationSpeedup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSpeedup];
    
    UIButton *btnSlowdown = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 150, self.view.frame.size.height - 200, 150, 44)];
    [btnSlowdown setTitle:@"Slow down" forState:UIControlStateNormal];
    [btnSlowdown setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnSlowdown setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btnSlowdown.layer.borderColor = [[UIColor grayColor] CGColor];
    btnSlowdown.layer.borderWidth = 2.0f;
    [btnSlowdown addTarget:self action:@selector(demosAnimationSlowdown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSlowdown];
}

- (void)demosAnimationPause:(UIButton *)sender {
    // 时间需要转换
    CFTimeInterval pauseTime = [view1.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    // 设置layer的timeOffset, 则视为CALayer的时间暂停
    view1.layer.timeOffset = pauseTime;
    // 暂停
    view1.layer.speed = 0;
}

- (void)demosAnimationContinue:(UIButton *)sender {
    // 时间转换
    CFTimeInterval pauseTime = view1.layer.timeOffset;
    // 计算暂停时间
    CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;
    // 取消
    view1.layer.timeOffset = 0;
    // 相对于父坐标系的beginTime
    view1.layer.beginTime = timeSincePause;
    // 继续
    view1.layer.speed = 1;
}

- (void)demosAnimationSpeedup:(UIButton *)sender {
    view1.layer.timeOffset = [view1.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    view1.layer.beginTime = CACurrentMediaTime();
    view1.layer.speed += 0.5;
}

- (void)demosAnimationSlowdown:(UIButton *)sender {
    view1.layer.timeOffset = [view1.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    view1.layer.beginTime = CACurrentMediaTime();
    view1.layer.speed -= 0.5;
}

@end
