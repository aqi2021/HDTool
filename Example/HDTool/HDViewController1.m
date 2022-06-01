//
//  HDViewController1.m
//  HDTool_Example
//
//  Created by 黄山锋 on 2022/6/1.
//  Copyright © 2022 hsf. All rights reserved.
//

#import "HDViewController1.h"
#import "HDPerson1.h"

@interface HDViewController1 ()
@property (nonatomic, strong) HDPerson1 *person;
@end

@implementation HDViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);
    self.person = [[HDPerson1 alloc]init];
        
    
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(100, 100, 100, 30);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"添加NULL" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addActionNULL) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(100, 150, 100, 30);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"添加1" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addAction1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(100, 200, 100, 30);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"添加2" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addAction2) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(100, 250, 100, 30);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"移出" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(100, 300, 100, 30);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"赋值" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)addActionNULL {
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
}
- (void)addAction1 {
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:@"1"];
}
- (void)addAction2 {
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:@"2"];
}

- (void)removeAction {
    [self.person removeObserver:self forKeyPath:@"name" context:@"1"];
}

- (void)setAction {
    self.person.name = @"jack";
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSString *info = [NSString stringWithFormat:@"代理转发kvo回调成功: \n keyPath:%@ \n object:%@\n change:%@ \n context:%@", keyPath, object, change, context];
    NSLog(@"%@",info);
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
