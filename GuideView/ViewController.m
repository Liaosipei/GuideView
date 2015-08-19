//
//  ViewController.m
//  GuideView
//
//  Created by liaosipei on 15/8/17.
//  Copyright (c) 2015年 liaosipei. All rights reserved.
//

#import "ViewController.h"
#import "GuideViewController.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController () <GuideViewControllerDelegate>
{
    BOOL isLoaded;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置“进入首页”的按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT-120, 180, 40);
    [button setTitle:@"返回引导页面" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:255.00/255 green:182.00/255 blue:193.00/255 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
    button.layer.cornerRadius=10;
    button.layer.borderWidth=2;
    button.layer.borderColor=[[UIColor colorWithRed:255.00/255 green:182.00/255 blue:193.00/255 alpha:1] CGColor];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


-(void)viewDidAppear:(BOOL)animated
{
    if(!isLoaded)
    {
        //页面跳转的工作必须放在viewDidAppear中，防止控制器之间相互调用viewDidLoad函数
        GuideViewController *guide=[[GuideViewController alloc]init];
        guide.delegate=self;
        [self presentViewController:guide animated:YES completion:nil];
    }
    
    [super viewDidAppear:animated];
    
}

- (IBAction)btnClicked:(id)sender {
    GuideViewController *guide=[[GuideViewController alloc]init];
    guide.delegate=self;
    [self presentViewController:guide animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate

-(NSInteger)numberOfGuideViews
{
    return 4;
}

-(UIView *)guideView:(UIScrollView *)sView atIndex:(NSInteger)index
{
    CGRect frame=sView.frame;
    UIView *view=[[UIView alloc]initWithFrame:frame];
    switch (index) {
        case 0:
            view.backgroundColor=[UIColor colorWithRed:255.00/255 green:182.00/255 blue:193.00/255 alpha:1];//粉色
            break;
        case 1:
            view.backgroundColor=[UIColor colorWithRed:135.00/255 green:206.00/255 blue:235.00/255 alpha:1];//蓝色
            break;
        case 2:
            view.backgroundColor=[UIColor colorWithRed:221.00/255 green:160.00/255 blue:221.00/255 alpha:1];//紫色
            
            break;
        case 3:
            view.backgroundColor=[UIColor colorWithRed:255.00/255 green:228.00/255 blue:181.00/255 alpha:1];//黄色
            break;
        default:
            break;
    }
    return view;
}

-(UIImageView *)imageAtIndex:(NSInteger)index
{
    NSString *imgStr=[NSString string];
    CGRect frame;
    frame.origin=[self pointCenterAtIndex:index];
    frame.size=CGSizeMake(30, 30);
    switch (index) {
        case 0:
            imgStr=@"blue.png";
            break;
        case 1:
            imgStr=@"purple.png";
            break;
        case 2:
            imgStr=@"yellow.png";
            break;
        case 3:
            imgStr=@"pink.png";
            break;
        default:
            break;
    }
    UIImage *img=[UIImage imageNamed:imgStr];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
    imageView.frame=frame;
    return imageView;
}

-(UILabel *)labelAtIndex:(NSInteger)index
{
    CGRect frame;
    frame.origin=[self pointCenterAtIndex:index];
    frame.origin.x+=40;
    frame.origin.y-=5;
    frame.size=CGSizeMake(300, 40);
    NSString *str;
    switch (index) {
        case 0:
            str=@"More pictures";
            break;
        case 1:
            str=@"Glearer visual design";
            break;
        case 2:
            str=@"Better user interface";
            break;
        case 3:
            str=@"More perfect App";
            break;
        default:
            break;
    }
    
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=str;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"ChalkboardSE-Regular" size:25];
    return label;
}

-(CGPoint)pointCenterAtIndex:(NSInteger)index
{
    CGPoint point;
    switch (index) {
        case 0:
            point=CGPointMake(30, 100);
            break;
        case 1:
            point=CGPointMake(50, 200);
            break;
        case 2:
            point=CGPointMake(70, 300);
            break;
        case 3:
            point=CGPointMake(90, 400);
            break;
        default:
            break;
    }
    return point;
}


@end

