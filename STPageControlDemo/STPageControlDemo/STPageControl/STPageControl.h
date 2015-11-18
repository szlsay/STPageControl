//
//  STPageControl.h
//  STPageControlDemo
//
//  Created by shentian on 15/11/17.
//  Copyright © 2015年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPageControl : UIControl

/** 1.内部的普通色 */
@property (nonatomic, strong, nullable) UIColor *coreNormalColor;
/** 2.内部的选中色 */
@property (nonatomic, strong, nullable) UIColor *coreSelectedColor;
/** 3.边线的普通色 */
@property (nonatomic, strong, nullable) UIColor *lineNormalColor;
/** 4.边线的选中色 */
@property (nonatomic, strong, nullable) UIColor *lineSelectedColor;
/** 5.字体的普通色 */
@property (nonatomic, strong, nullable) UIColor *textNormalColor;
/** 6.字体的选中色 */
@property (nonatomic, strong, nullable) UIColor *textSelectedColor;


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
 *
 *  @param frame                     <#frame description#>
 *  @param numberOfPages             <#numberOfPages description#>
 *  @param pageIndicatorColor        <#pageIndicatorColor description#>
 *  @param currentPageIndicatorColor <#currentPageIndicatorColor description#>
 *
 *  @return <#return value description#>
 */
+ (STPageControl *_Nonnull)pageControlSystemWithFrame:(CGRect)frame
                                        numberOfPages:(NSInteger)numberOfPages
                                   pageIndicatorColor:(UIColor *__nullable)pageIndicatorColor
                            currentPageIndicatorColor:(UIColor *__nullable)currentPageIndicatorColor;

/**
 *  2.类实例化的一个可以自定义边线属性、字体颜色、间隔宽度等功能的PageControl,，
 *
 *  @param frame              <#frame description#>
 *  @param numberOfPages      <#numberOfPages description#>
 *  @param gapWidth           <#gapWidth description#>
 *  @param diameter           <#diameter description#>
 *  @param lineWidth          <#lineWidth description#>
 *  @param coreNormalColor    <#coreNormalColor description#>
 *  @param coreSelectedColor  <#coreSelectedColor description#>
 *  @param lineNormalColor    <#lineNormalColor description#>
 *  @param lineSelectedColor  <#lineSelectedColor description#>
 *  @param textNormalColor    <#textNormalColor description#>
 *  @param textSelectedColor  <#textSelectedColor description#>
 *  @param hidesForSinglePage <#hidesForSinglePage description#>
 *  @param isShowNumber       <#isShowNumber description#>
 *
 *  @return <#return value description#>
 */
+ (STPageControl * _Nonnull)pageControlWithFrame:(CGRect)frame
                                   numberOfPages:(NSInteger)numberOfPages
                                        gapWidth:(NSInteger)gapWidth
                                        diameter:(NSInteger)diameter
                                       lineWidth:(NSInteger)lineWidth
                                 coreNormalColor:(UIColor *__nullable)coreNormalColor
                               coreSelectedColor:(UIColor *__nullable)coreSelectedColor
                                 lineNormalColor:(UIColor *__nullable)lineNormalColor
                               lineSelectedColor:(UIColor *__nullable)lineSelectedColor
                                 textNormalColor:(UIColor *__nullable)textNormalColor
                               textSelectedColor:(UIColor *__nullable)textSelectedColor
                              hidesForSinglePage:(BOOL)hidesForSinglePage
                                      ShowNumber:(BOOL)isShowNumber;

/**
 *  3.类实例化的一个可以自定义边线颜色和内部颜色,默认间距的PageControl,，
 *
 *  @param frame             <#frame description#>
 *  @param numberOfPages     <#numberOfPages description#>
 *  @param coreNormalColor   <#coreNormalColor description#>
 *  @param coreSelectedColor <#coreSelectedColor description#>
 *  @param lineNormalColor   <#lineNormalColor description#>
 *  @param lineSelectedColor <#lineSelectedColor description#>
 *
 *  @return <#return value description#>
 */
+ (STPageControl * _Nonnull)pageControlDefaultWithFrame:(CGRect)frame
                                          numberOfPages:(NSInteger)numberOfPages
                                        coreNormalColor:(UIColor *__nullable)coreNormalColor
                                      coreSelectedColor:(UIColor *__nullable)coreSelectedColor
                                        lineNormalColor:(UIColor *__nullable)lineNormalColor
                                      lineSelectedColor:(UIColor *__nullable)lineSelectedColor;


@end


