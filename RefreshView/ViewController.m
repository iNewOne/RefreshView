//
//  ViewController.m
//  RefreshView
//
//  Created by Xujiangfei on 2018/6/5.
//  Copyright © 2018年 Xujiangfei. All rights reserved.
//

#import "ViewController.h"
#import "RefreshView.h"

@interface ViewController (){
    RefreshView * rView;
    UIScrollView *mainSC;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rView = [[RefreshView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    rView.colorArray = @[[UIColor colorWithRed:243.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:255.0/255.0], [UIColor colorWithRed:142.0/255.0 green:200.0/255.0 blue:249.0/255.0 alpha:255.0/255.0], [UIColor colorWithRed:174.0/255.0 green:173.0/255.0 blue:172.0/255.0 alpha:255.0/255.0]];
    rView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:198.0/255.0 blue:76.0/255.0 alpha:255.0/255.0];
    [self.view addSubview:rView];
    

    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(100, 250, 250, 10)];
    slider.value = 0.0;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)sliderChanged:(UISlider *)slider{
    rView.progress = slider.value;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
