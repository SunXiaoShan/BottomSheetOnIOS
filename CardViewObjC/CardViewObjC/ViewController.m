//
//  ViewController.m
//  CardViewObjC
//
//  Created by Phineas.Huang on 2020/6/19.
//  Copyright © 2020 Phineas. All rights reserved.
//

#import "ViewController.h"

#import "BottomSheetViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBottomSheetView];
}

- (void)addBottomSheetView {
    BottomSheetViewController *bottomSheetVc = [BottomSheetViewController new];
    [self addChildViewController:bottomSheetVc];
    [self.view addSubview:bottomSheetVc.view];
    [bottomSheetVc didMoveToParentViewController:self];

    const CGFloat y = self.view.frame.origin.y;
    const CGFloat height = self.view.frame.size.height;
    const CGFloat width = self.view.frame.size.width;
    bottomSheetVc.view.frame = CGRectMake( 0, y + height, width, height);
}


@end
