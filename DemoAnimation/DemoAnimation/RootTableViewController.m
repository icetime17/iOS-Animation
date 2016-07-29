//
//  RootTableViewController.m
//  UIViewAnimationDemo
//
//  Created by Chris Hu on 15/9/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "RootTableViewController.h"
#import "AnimationViewController.h"
#import "LayoutAnimationViewController.h"

typedef NS_ENUM(NSInteger, EnumAnimation) {
    kUIViewAnimations,
    kLayoutAnimations,
    kKeyFrameAnimations,
    kCoreAnimations,
    kPopAnimations,
};


@interface RootTableViewController ()

@end

@implementation RootTableViewController {

    NSArray *sections;
    NSArray *uiViewAnimations;
    NSArray *layoutAnimations;
    NSArray *keyFrameAnimations;
    NSArray *coreAnimations;
    NSArray *popAnimations;
    
    NSMutableArray *demosAnimation;
    NSString *selectedItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"DemoAnimation";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
                              @"POPAnimatableProperty"];
    
    demosAnimation = [NSMutableArray arrayWithCapacity:0];
    [demosAnimation addObjectsFromArray:uiViewAnimations];
    [demosAnimation addObjectsFromArray:keyFrameAnimations];
    [demosAnimation addObjectsFromArray:coreAnimations];
    [demosAnimation addObjectsFromArray:popAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sections.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return sections[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case kUIViewAnimations:
            return uiViewAnimations.count;
        case kLayoutAnimations:
            return layoutAnimations.count;
        case kKeyFrameAnimations:
            return keyFrameAnimations.count;
        case kCoreAnimations:
            return coreAnimations.count;
        case kPopAnimations:
            return popAnimations.count;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case kUIViewAnimations:
            cell.textLabel.text = uiViewAnimations[indexPath.row];
            break;
        case kLayoutAnimations:
            cell.textLabel.text = layoutAnimations[indexPath.row];
            break;
        case kKeyFrameAnimations:
            cell.textLabel.text = keyFrameAnimations[indexPath.row];
            break;
        case kCoreAnimations:
            cell.textLabel.text = coreAnimations[indexPath.row];
            break;
        case kPopAnimations:
            cell.textLabel.text = popAnimations[indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kUIViewAnimations:
            selectedItem = uiViewAnimations[indexPath.row];
            break;
        case kLayoutAnimations:
            selectedItem = layoutAnimations[indexPath.row];
            break;
        case kKeyFrameAnimations:
            selectedItem = keyFrameAnimations[indexPath.row];
            break;
        case kCoreAnimations:
            selectedItem = coreAnimations[indexPath.row];
            break;
        case kPopAnimations:
            selectedItem = popAnimations[indexPath.row];
            break;
        default:
            break;
    }
    
    if (indexPath.section == kLayoutAnimations) {
        [self performSegueWithIdentifier:@"SegueLayoutAnimation" sender:self];
    } else {
        [self performSegueWithIdentifier:@"Segue" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Segue"]) {
        AnimationViewController *animationVC = (AnimationViewController *)segue.destinationViewController;
        animationVC.item = selectedItem;
    } else {
        LayoutAnimationViewController *animationVC = (LayoutAnimationViewController *)segue.destinationViewController;
    }
}

@end
