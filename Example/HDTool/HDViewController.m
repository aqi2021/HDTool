//
//  HDViewController.m
//  HDTool
//
//  Created by hsf on 05/20/2022.
//  Copyright (c) 2022 hsf. All rights reserved.
//

#import "HDViewController.h"
#import "HDViewController1.h"

@interface HDViewController ()

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)clickBtnAction {
    HDViewController1 *vc = [[HDViewController1 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
