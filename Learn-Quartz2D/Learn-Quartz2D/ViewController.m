//
//  ViewController.m
//  Learn-Quartz2D
//
//  Created by MAC on 16/2/25.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "ViewController.h"
#import "quartz2D.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //uiview 和xib关联
    quartz2D *qua =[[[NSBundle mainBundle] loadNibNamed:@"quartz2D" owner:self options:nil] lastObject];
    qua.frame = CGRectMake(0, 0, 400, 400);
    [self.view addSubview:qua];
    
    //我是来捣蛋的
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
