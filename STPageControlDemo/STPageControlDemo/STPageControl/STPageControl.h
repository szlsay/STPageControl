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
@property (nonatomic, strong, nullable) UIColor *strokeNormalColor;
/** 4.边线的选中色 */
@property (nonatomic, strong, nullable) UIColor *strokeSelectedColor;

/** 5.当前页,default is 0 */
@property (nonatomic) NSInteger currentPage;
/** 6.总页数,default is 0. value pinned to 0..numberOfPages-1  */
@property (nonatomic) NSInteger numberOfPages;
/** 7.边线宽,default is 2  */
@property (nonatomic) NSInteger lineWidth;
/** 8.圆圈直径,default is 10  */
@property (nonatomic) NSInteger diameter;
/** 9.间隔宽度,default is 10 */
@property (nonatomic) NSInteger gapWidth;

/** 10.单页的时候是否隐藏,hide the the indicator if there is only one page. default is NO*/
@property (nonatomic) BOOL hidesForSinglePage;
/** 11.是否显示数字,default is NO  */
@property (nonatomic) BOOL isShowNumber;


+ (STPageControl * _Nonnull)pageControlWithFrame:(CGRect)frame
                                   numberOfPages:(NSInteger)numberOfPages
                                        gapWidth:(NSInteger)gapWidth
                                        diameter:(NSInteger)diameter
                                       lineWidth:(NSInteger)lineWidth;

@end


