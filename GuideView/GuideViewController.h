//
//  GuideViewController.h
//  GuideView
//
//  Created by liaosipei on 15/8/17.
//  Copyright (c) 2015年 liaosipei. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义GuideViewControllerDelegate协议
@protocol GuideViewControllerDelegate <NSObject>
-(NSInteger)numberOfGuideViews;
@optional
-(UIView *)guideView:(UIScrollView *)sView atIndex:(NSInteger)index;
//-(void)guideViewDidScroll:(UIScrollView *)sView atIndex:(NSInteger)index;

-(UIImageView *)imageAtIndex:(NSInteger)index;
-(UILabel *)labelAtIndex:(NSInteger)index;
-(CGPoint)pointCenterAtIndex:(NSInteger)index;

-(void)clickEnterButton:(id)sender;
@end


@interface GuideViewController : UIViewController

@property (weak,nonatomic) id<GuideViewControllerDelegate> delegate;
@property (strong,nonatomic) NSMutableArray *imageViewArray;
@property (strong,nonatomic) NSMutableArray *labelViewArray;
@property (strong,nonatomic) UIButton *enterButton;
@end

