//
//  STPageControl.h
//  STPageControlDemo
//
//  Created by shentian on 15/11/17.
//  Copyright © 2015年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface STPageControl : UIControl
/** 1.内部的普通色 */
@property (nonatomic, strong) UIColor *coreNormalColor;
/** 2.内部的选中色 */
@property (nonatomic, strong) UIColor *coreSelectedColor;
/** 3.边线的普通色 */
@property (nonatomic, strong) UIColor *lineNormalColor;
/** 4.边线的选中色 */
@property (nonatomic, strong) UIColor *lineSelectedColor;
/** 5.字体的普通色 */
@property (nonatomic, strong) UIColor *textNormalColor;
/** 6.字体的选中色 */
@property (nonatomic, strong) UIColor *textSelectedColor;


/** 7.当前页,default is 0 */
@property (nonatomic) NSInteger currentPage;
/** 8.总页数,default is 0. value pinned to 0..numberOfPages-1 */
@property (nonatomic) NSInteger numberOfPages;
/** 9.边线宽,default is 2  */
@property (nonatomic) NSInteger lineWidth;
/** 10.圆圈直径,default is 10  */
@property (nonatomic) NSInteger diameter;
/** 11.间隔宽度,default is 10 */
@property (nonatomic) NSInteger gapWidth;
/** 12.单页的时候是否隐藏,hide the the indicator if there is only one page. default is NO*/
@property (nonatomic) BOOL hidesForSinglePage;
/** 13.是否显示数字,default is NO  */
@property (nonatomic) BOOL isShowNumber;

/**
 *  1.类实例化一个系统的UIPageControl
 */
+ (STPageControl *)pageControlSystemWithFrame:(CGRect)frame
                                        numberOfPages:(NSInteger)numberOfPages
                                   pageIndicatorColor:(UIColor *)pageIndicatorColor
                            currentPageIndicatorColor:(UIColor *)currentPageIndicatorColor;

/**
 *  2.类实例化的一个可以自定义边线属性、字体颜色、间隔宽度等功能的PageControl,，
 */
+ (STPageControl * )pageControlWithFrame:(CGRect)frame
                                   numberOfPages:(NSInteger)numberOfPages
                                        gapWidth:(NSInteger)gapWidth
                                        diameter:(NSInteger)diameter
                                       lineWidth:(NSInteger)lineWidth
                                 coreNormalColor:(UIColor *)coreNormalColor
                               coreSelectedColor:(UIColor *)coreSelectedColor
                                 lineNormalColor:(UIColor *)lineNormalColor
                               lineSelectedColor:(UIColor *)lineSelectedColor
                                 textNormalColor:(UIColor *)textNormalColor
                               textSelectedColor:(UIColor *)textSelectedColor
                              hidesForSinglePage:(BOOL)hidesForSinglePage
                                      ShowNumber:(BOOL)isShowNumber;

/**
 *  3.类实例化的一个可以自定义边线颜色和内部颜色,默认间距的PageControl,，
 */
+ (STPageControl * )pageControlDefaultWithFrame:(CGRect)frame
                                          numberOfPages:(NSInteger)numberOfPages
                                        coreNormalColor:(UIColor *)coreNormalColor
                                      coreSelectedColor:(UIColor *)coreSelectedColor
                                        lineNormalColor:(UIColor *)lineNormalColor
                                      lineSelectedColor:(UIColor *)lineSelectedColor;


@end
NS_ASSUME_NONNULL_END
