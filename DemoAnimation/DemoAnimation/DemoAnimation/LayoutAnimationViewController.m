//
//  LayoutAnimationViewController.m
//  DemoAnimation
//
//  Created by zj－db0465 on 16/3/21.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "LayoutAnimationViewController.h"

@interface LayoutAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIView *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;


@end

@implementation LayoutAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnimation:(UIButton *)sender {
    __typeof (&*self) __weak weakSelf = self;
    [UIView animateWithDuration:1.0f animations:^{
        weakSelf.constraintBottom.constant = 0.0f;
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.constraintBottom.constant = 100.0f;
        [weakSelf.view layoutIfNeeded];
    }];
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
