## DemoAnimation

Demo for iOS animation, including UIView Animation, Layout Animation, KeyFrame Animation, CoreAnimation, Pop Animation.

### UIView Animation

#### Position
```
[UIView animateWithDuration:2.0 animations:^{
    view1.frame = CGRectMake(self.view.frame.size.width - 100, 100, 100, 100);
} completion:^(BOOL finished) {
    [UIView animateWithDuration:2.0 animations:^{
        view2.center = self.view.center;
    } completion:^(BOOL finished) {
        animated = YES;
    }];
}];
```

#### Opacity
```
[UIView animateWithDuration:2.0 animations:^{
    view1.alpha = 0.1;
} completion:^(BOOL finished) {
    animated = YES;
}];
```

#### Scale
```
[UIView animateWithDuration:1.0 animations:^{
    view1.transform = CGAffineTransformMakeScale(2.0, 2.0);
} completion:^(BOOL finished) {
    [UIView animateWithDuration:1.0 animations:^{
        view2.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        animated = YES;
    }];
}];
```

#### Color
```
[UIView animateWithDuration:1.0 animations:^{
    view1.backgroundColor = [UIColor greenColor];
} completion:^(BOOL finished) {
    [UIView animateWithDuration:1.0 animations:^{
        view2.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        animated = YES;
    }];
}];
```

#### Rotation
```
[UIView animateWithDuration:1.0 animations:^{
    view1.transform = CGAffineTransformMakeRotation(1.0);
} completion:^(BOOL finished) {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view2.transform = CGAffineTransformRotate(view2.transform, (CGFloat)M_PI);
    } completion:^(BOOL finished) {
        [self demoRotationAnimation];
    }];
}];
```

#### UIImageView Count Down
```
NSMutableArray *images = [[NSMutableArray alloc] init];
for (NSInteger i = 1; i <= 3; i++) {
    [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)(3 - i + 1)]]];
}
imageView.animationImages = images;
imageView.animationRepeatCount = 0;
imageView.animationDuration = 3;
[imageView startAnimating];
```
请参考博客:[iOS --- 使用UIImageView来实现倒计时动画](http://blog.csdn.net/icetime17/article/details/49463971)

#### Count Down
```
timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
[timer fire];
```

```
lbCountDown.text = [NSString stringWithFormat:@"%ld", (long)countdown];
```

#### Tear Off
```
[UIView animateWithDuration:2.0 animations:^{
    viewLeft.frame = CGRectMake(0, 0, 0, 350);
} completion:^(BOOL finished) {
    [UIView animateWithDuration:2.0 animations:^{
        viewRight.frame = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 350);
    }];
}];
```

### Layout Animation

#### NSLayoutConstraint
```
__typeof (&*self) __weak weakSelf = self;
[UIView animateWithDuration:1.0f animations:^{
    weakSelf.constraintBottom.constant = 0.0f;
    [weakSelf.view layoutIfNeeded];
} completion:^(BOOL finished) {
    weakSelf.constraintBottom.constant = 100.0f;
    [weakSelf.view layoutIfNeeded];
}];
```

### Key Frame Animation

#### CAKeyframeAnimation
```
CALayer *layer1 = view1.layer;
CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
animation1.values = @[@(layer1.position.x), @(layer1.position.x + 100), @(layer1.position.x + 200), @(layer1.position.x + 100), @(layer1.position.x)];
animation1.autoreverses = NO;
animation1.repeatCount = MAXFLOAT;
animation1.duration = 2.0;
[layer1 addAnimation:animation1 forKey:@"position.x"];
```

### Core Animation
#### Page Curl Animation
```
CATransition *animation = [CATransition animation];
animation.duration = 2.0f;
animation.type = @"pageCurl";
animation.subtype = kCATransitionFromBottom;
animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
[self.view.layer addAnimation:animation forKey:@"animation"];
```

#### Flip Animation
```
CATransform3D transform = CATransform3DIdentity;
transform.m34 = - 1.0 / 500.0;
transform = CATransform3DRotate(transform, - M_PI_2, 0, 1, 0);
CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
animation.duration = 2.0f;
animation.toValue = [NSValue valueWithCATransform3D:transform];
animation.delegate = self;
[imageViewFlip.layer addAnimation:animation forKey:@"animationRotate"];
```

### Pop Animation

#### POPBasicAnimation
```
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
```

#### POPAnimatableProperty
```
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
basic.property = property;
basic.fromValue = @(0);
basic.toValue = @(10 * 60);
basic.duration = 10 * 60;
basic.beginTime = CACurrentMediaTime() + 1.0f;
[label pop_addAnimation:basic forKey:@"countdown"];
```
