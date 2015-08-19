//
//  GuideViewController.m
//  GuideView
//
//  Created by liaosipei on 15/8/17.
//  Copyright (c) 2015年 liaosipei. All rights reserved.
//

#import "GuideViewController.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

//()表示扩展类，定义实例变量用于程序内部访问
@interface GuideViewController () <UIScrollViewDelegate>{
    NSInteger numberOfViews;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@end

@implementation GuideViewController

-(instancetype)init
{
    self=[super init];
    self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfViews=[self numberOfGuideViews];
    _imageViewArray=[NSMutableArray array];
    _labelViewArray=[NSMutableArray array];
    
    self.view.backgroundColor=[UIColor clearColor];
    _scrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.contentSize=CGSizeMake(numberOfViews*SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT-50, 100, 35)];
    _pageControl.numberOfPages=numberOfViews;
    _pageControl.currentPage=0;
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    for(int i=0;i<numberOfViews;i++)
    {
        UIView *view=[self guideView:_scrollView atIndex:i];
        CGRect vframe=view.frame;
        vframe.origin.x=i*SCREEN_WIDTH;
        vframe.origin.y=0;
        view.frame=vframe;
        [_scrollView addSubview:view];
        
        UIImageView *imageView=[self imageAtIndex:i];
        if(i==0)
            imageView.hidden=NO;
        else
            imageView.hidden=YES;
        [self.view addSubview:imageView];
        [_imageViewArray addObject:imageView];
        
        UILabel *label=[self labelAtIndex:i];
        if(i==0)
            label.hidden=NO;
        else
            label.hidden=YES;
        [self.view addSubview:label];
        [_labelViewArray addObject:label];
    }
    //设置“进入首页”的按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT-120, 180, 40);
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:255.00/255 green:182.00/255 blue:193.00/255 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
    button.layer.cornerRadius=10;
    button.layer.borderWidth=2;
    button.layer.borderColor=[[UIColor colorWithRed:255.00/255 green:182.00/255 blue:193.00/255 alpha:1] CGColor];
    button.hidden=YES;
    [button addTarget:self action:@selector(clickEnterButton:) forControlEvents:UIControlEventTouchUpInside];
    _enterButton=button;
    [self.view addSubview:_enterButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePage:(id)sender
{
    UIPageControl *currentControl=(UIPageControl *)sender;
    NSInteger currentPage=currentControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(currentPage*SCREEN_WIDTH, 0)];
}

-(void)clickEnterButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if([_delegate respondsToSelector:@selector(clickEnterButton:)])
        [self.delegate clickEnterButton:sender];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_enterButton setHidden:YES];
    CGFloat pageWidth=scrollView.frame.size.width;
    int page=floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _pageControl.currentPage=page;
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    if(_scrollView.contentOffset.x>0 )
        [self moveImageAndLabelAtIndext:index];
    if(index==(numberOfViews-1) && _scrollView.contentOffset.x>=(SCREEN_WIDTH*(numberOfViews-1)+10))
        [self moveLastImageAndLabel];
}

-(void)moveImageAndLabelAtIndext:(NSInteger)index
{
    CGFloat scrollRate=(_scrollView.contentOffset.x/SCREEN_WIDTH)-floor(_scrollView.contentOffset.x/SCREEN_WIDTH);
    CGFloat k,x =0.0,y=0.0,b;
    
    if(index!=numberOfViews-1)
    {
        CGPoint p1=[self pointCenterAtIndex:index];
        CGPoint p2=[self pointCenterAtIndex:index+1];
        
        if(p2.x!=p1.x)
        {
            k=(p2.y-p1.y)/(p2.x-p1.x);
            x=scrollRate*(p2.x-p1.x)+p1.x;
            b=p1.y-k*p1.x;
            y=k*x+b;
        }
        for(UIImageView *image in _imageViewArray)
        {
            image.hidden=YES;
            [image setCenter:CGPointMake(x+15, y+15)];
            UIImageView *currentImage=[_imageViewArray objectAtIndex:index];
            if(scrollRate<=0.8)
            {
                currentImage.hidden=NO;
                currentImage.layer.opacity=1-scrollRate/0.8;
                //_enterButton.hidden=YES;
            }else
            {
                UIImageView *nextImage=[_imageViewArray objectAtIndex:index+1];
                nextImage.hidden=NO;
                nextImage.layer.opacity=(scrollRate-0.8)/0.2;
            }
            
        }
        for(UILabel *labelView in _labelViewArray)
        {
            labelView.hidden=YES;
            [labelView setCenter:CGPointMake(x+190, y+15)];
            UILabel *currentLabel=[_labelViewArray objectAtIndex:index];
            if(scrollRate<=0.8)
            {
                currentLabel.hidden=NO;
                currentLabel.layer.opacity=1-scrollRate/0.8;
            }else
            {
                UILabel *nextLabel=[_labelViewArray objectAtIndex:index+1];
                nextLabel.hidden=NO;
                nextLabel.layer.opacity=(scrollRate-0.8)/0.2;
            }
        }
    }else
    {
        UIImageView *lastImage=[_imageViewArray objectAtIndex:index];
        CGPoint p=[self pointCenterAtIndex:index];
        [lastImage setCenter:CGPointMake(p.x-scrollRate*SCREEN_WIDTH+15, p.y+15)];
        
        UILabel *lastLabel=[_labelViewArray objectAtIndex:index];
        [lastLabel setCenter:CGPointMake(p.x-scrollRate*SCREEN_WIDTH+190, p.y+15)];
        _enterButton.frame=CGRectMake(SCREEN_WIDTH/2-scrollRate*SCREEN_WIDTH-90, SCREEN_HEIGHT-100-20, 180, 40);
    }
    if ((index==numberOfViews-2 && (scrollRate>0.9)) || (index==numberOfViews-1))
        _enterButton.hidden=NO;
}

-(void)moveLastImageAndLabel
{
    
}

#pragma mark - GuideViewControllerDelegate
-(NSInteger)numberOfGuideViews
{
    NSInteger n;
    if([_delegate respondsToSelector:@selector(numberOfGuideViews)])
        n=[self.delegate numberOfGuideViews];
    return n;
}

-(UIView *)guideView:(UIScrollView *)sView atIndex:(NSInteger)index
{
    if([_delegate respondsToSelector:@selector(guideView:atIndex:)])
        return [self.delegate guideView:sView atIndex:index];
    else
        return nil;
}

-(UIImageView *)imageAtIndex:(NSInteger)index
{
    if([_delegate respondsToSelector:@selector(imageAtIndex:)])
        return [self.delegate imageAtIndex:index];
    else
        return nil;
}

-(UILabel *)labelAtIndex:(NSInteger)index
{
    if([_delegate respondsToSelector:@selector(labelAtIndex:)])
        return [self.delegate labelAtIndex:index];
    else
        return nil;
}

-(CGPoint)pointCenterAtIndex:(NSInteger)index
{
    CGPoint point;
    if([_delegate respondsToSelector:@selector(pointCenterAtIndex:)])
        point=[self.delegate pointCenterAtIndex:index];
    return point;
}


@end

