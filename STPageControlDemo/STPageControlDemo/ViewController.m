//
//  ViewController.m
//  STPageControlDemo
//
//  Created by shentian on 15/11/17.
//  Copyright © 2015年 ST. All rights reserved.
//

#import "ViewController.h"

#import "STPageControl.h"

@interface ViewController ()

/**
 *  1.自定义pageControl
 */
@property (nonatomic, weak, nullable)STPageControl *pageCustom;

/**
 *  2.仿系统pageControl
 */
@property (nonatomic, weak, nullable)STPageControl *pageSystem;

/**
 *  3.默认的pageControl
 */
@property (nonatomic, weak, nullable)STPageControl *pageDefault;


@property (nonatomic, weak, nullable)UILabel    *labelSystem;
@property (nonatomic, weak, nullable)UILabel    *labelDefault;
@property (nonatomic, weak, nullable)UILabel    *labelCustom;

@end

@implementation ViewController

#pragma mark - lift cycle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPageSystem];
    
    [self setupPageDefault];
    
    [self setupPageCustom];
    
}


- (void)setupPageSystem
{
    STPageControl *pageSystem = [STPageControl pageControlSystemWithFrame:CGRectMake(0, 0, 0, 0)
                                                            numberOfPages:10
                                                       pageIndicatorColor:[UIColor grayColor]
                                                currentPageIndicatorColor:[UIColor redColor]];
    
    [self.view addSubview:pageSystem];
    [pageSystem setCenter:CGPointMake(self.view.frame.size.width/2, 100)];
    [pageSystem addTarget:self
                   action:@selector(changePageSystem:)
         forControlEvents:UIControlEventValueChanged];
    self.pageSystem = pageSystem;
    
    UILabel *labelSystem = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [labelSystem setTextAlignment:NSTextAlignmentCenter];
    [labelSystem setCenter:CGPointMake(self.view.frame.size.width/2, 70)];
    [self.view addSubview:labelSystem];
    self.labelSystem = labelSystem;
    [self.labelSystem setText:@"仿系统UIPageControl"];
}

- (void)setupPageDefault
{
    STPageControl *pageDefault = [STPageControl pageControlDefaultWithFrame:CGRectMake(0, 0, 0, 0)
                                                              numberOfPages:10
                                                            coreNormalColor:[UIColor whiteColor]
                                                          coreSelectedColor:[UIColor redColor]
                                                            lineNormalColor:[UIColor grayColor]
                                                          lineSelectedColor:[UIColor lightGrayColor]];
    [self.view addSubview:pageDefault];
    [pageDefault setCenter:CGPointMake(self.view.frame.size.width/2, 200)];
    [pageDefault addTarget:self
                    action:@selector(changePageDefault:)
          forControlEvents:UIControlEventValueChanged];
    self.pageDefault = pageDefault;
    
    UILabel *labelDefault = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [labelDefault setTextAlignment:NSTextAlignmentCenter];
    [labelDefault setCenter:CGPointMake(self.view.frame.size.width/2, 170)];
    [self.view addSubview:labelDefault];
    self.labelDefault = labelDefault;
    [self.labelDefault setText:@"默认PageControl"];
}

- (void)setupPageCustom
{
    STPageControl *pageCustom = [STPageControl pageControlWithFrame:CGRectMake(0, 0, 0, 0)
                                                      numberOfPages:5
                                                           gapWidth:20
                                                           diameter:30
                                                          lineWidth:2
                                                    coreNormalColor:[UIColor whiteColor]
                                                  coreSelectedColor:[UIColor lightGrayColor]
                                                    lineNormalColor:[UIColor grayColor]
                                                  lineSelectedColor:[UIColor grayColor]
                                                    textNormalColor:[UIColor blackColor]
                                                  textSelectedColor:[UIColor redColor]
                                                 hidesForSinglePage:YES
                                                         ShowNumber:YES];
    [self.view addSubview:pageCustom];
    [pageCustom setCenter:CGPointMake(self.view.frame.size.width/2, 310)];
    [pageCustom addTarget:self
                   action:@selector(changePageCustom:)
         forControlEvents:UIControlEventValueChanged];
    self.pageCustom = pageCustom;
    
    UILabel *labelCustom = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [labelCustom setTextAlignment:NSTextAlignmentCenter];
    [labelCustom setCenter:CGPointMake(self.view.frame.size.width/2, 270)];
    [self.view addSubview:labelCustom];
    self.labelCustom = labelCustom;
    [self.labelCustom setText:@"自定义PageControl"];
}

#pragma mark - Delegate 视图委托

#pragma mark - event response 事件相应

#pragma mark - private methods 私有方法

- (void)changePageSystem:(STPageControl*)pageControl
{
    self.labelSystem.text = [NSString stringWithFormat:@"仿系统UIPageControl:%ld",(long)pageControl.currentPage];
}

- (void)changePageDefault:(STPageControl*)pageControl
{
    self.labelDefault.text = [NSString stringWithFormat:@"默认PageControl:%ld",(long)pageControl.currentPage];
}

- (void)changePageCustom:(STPageControl*)pageControl
{
    self.labelCustom.text = [NSString stringWithFormat:@"自定义PageControl:%ld",(long)pageControl.currentPage];
}
#pragma mark - getters and setters 属性

@end
