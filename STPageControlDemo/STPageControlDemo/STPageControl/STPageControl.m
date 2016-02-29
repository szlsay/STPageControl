//
//  STPageControl.m
//  STPageControlDemo
//
//  Created by shentian on 15/11/17.
//  Copyright © 2015年 ST. All rights reserved.
//

#import "STPageControl.h"

/**
 *  1.默认参数
 */

static CGFloat const  gapWidthDefault  = 10;
static CGFloat const  lineWidthDefault = 2;
static CGFloat const  diameterDefault  = 10;

/**
 *  2.系统的参数
 */
static CGFloat const  gapWidthSystem   = 9;
static CGFloat const  lineWidthSystem  = 1;
static CGFloat const  diameterSystem   = 7;

@implementation STPageControl

#pragma mark - --- init 视图初始化 ---
/**
 *  1.初始化
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setDefaultUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setDefaultUI];
    }
    return self;
}

/**
 *  2.设置默认属性值
 */
- (void)setDefaultUI{

    // 1.设置背景色
    self.backgroundColor = [UIColor clearColor];

    // 2.设置属性默认值
    _lineWidth = lineWidthDefault;
    _gapWidth  = gapWidthDefault;
    _diameter  = diameterDefault;

    _hidesForSinglePage = NO;
    _isShowNumber = NO;

    _currentPage = 0;
    _numberOfPages = 0;

    // 3.设置手势操作
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(onTapped:)];
    [self addGestureRecognizer:tap];
}


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
                                      ShowNumber:(BOOL)isShowNumber
{
    // 1.控件的最小的宽度
    NSInteger miniWidth = numberOfPages * (gapWidth + diameter) - gapWidth;

    // 2.控件的尺寸小于最小的尺寸时，将赋值最小的尺寸
    if (frame.size.width < miniWidth) {
        frame.size.width = miniWidth + gapWidth;
    }

    if (frame.size.height < diameter) {
        frame.size.height = diameter + gapWidth;
    }

    STPageControl *pageControl = [[STPageControl alloc]initWithFrame:frame];

    pageControl.numberOfPages = numberOfPages;
    pageControl.gapWidth      = gapWidth;
    pageControl.diameter      = diameter;
    pageControl.lineWidth     = lineWidth;

    pageControl.coreNormalColor   = coreNormalColor;
    pageControl.coreSelectedColor = coreSelectedColor;
    pageControl.lineNormalColor   = lineNormalColor;
    pageControl.lineSelectedColor = lineSelectedColor;
    pageControl.textNormalColor   = textNormalColor;
    pageControl.textSelectedColor = textSelectedColor;

    pageControl.hidesForSinglePage = hidesForSinglePage;
    pageControl.isShowNumber       = isShowNumber;

    return pageControl;
}

+ (STPageControl *)pageControlSystemWithFrame:(CGRect)frame
                                numberOfPages:(NSInteger)numberOfPages
                           pageIndicatorColor:(UIColor *)pageIndicatorColor
                    currentPageIndicatorColor:(UIColor *)currentPageIndicatorColor
{
    return [STPageControl pageControlWithFrame:frame
                                 numberOfPages:numberOfPages
                                      gapWidth:gapWidthSystem
                                      diameter:diameterSystem
                                     lineWidth:lineWidthSystem
                               coreNormalColor:pageIndicatorColor
                             coreSelectedColor:currentPageIndicatorColor
                               lineNormalColor:pageIndicatorColor
                             lineSelectedColor:currentPageIndicatorColor
                               textNormalColor:[UIColor clearColor]
                             textSelectedColor:[UIColor clearColor]
                            hidesForSinglePage:NO
                                    ShowNumber:NO];

}

+ (STPageControl * )pageControlDefaultWithFrame:(CGRect)frame
                                          numberOfPages:(NSInteger)numberOfPages
                                        coreNormalColor:(UIColor *)coreNormalColor
                                      coreSelectedColor:(UIColor *)coreSelectedColor
                                        lineNormalColor:(UIColor *)lineNormalColor
                                      lineSelectedColor:(UIColor *)lineSelectedColor
{
    return [STPageControl pageControlWithFrame:frame
                                 numberOfPages:numberOfPages
                                      gapWidth:gapWidthDefault
                                      diameter:diameterDefault
                                     lineWidth:lineWidthSystem
                               coreNormalColor:coreNormalColor
                             coreSelectedColor:coreSelectedColor lineNormalColor:lineNormalColor lineSelectedColor:lineSelectedColor
                               textNormalColor:[UIColor clearColor]
                             textSelectedColor:[UIColor clearColor]
                            hidesForSinglePage:NO
                                    ShowNumber:NO];
}

#pragma mark - --- delegate 视图委托 ---

#pragma mark - --- event response 事件相应 ---
/**
 *  1.点击事件
 *
 *  @param gesture <#gesture description#>
 */
- (void)onTapped:(UITapGestureRecognizer*)gesture
{
    // 0.获取触控的位置
    CGPoint touchPoint = [gesture locationInView:[gesture view]];

    // 1.设置当前页
    if (touchPoint.x < self.frame.size.width/2) // 1.点击控件的左边
    {
        if (touchPoint.x < (self.diameter+self.gapWidth)) {
            self.currentPage = 0;
        }

        if (self.currentPage>0)
        {
            self.currentPage -= 1;
        }

    } else {                    // 2.点击控件的右边

        if (touchPoint.x > self.frame.size.width-(self.diameter+self.gapWidth)) {
            self.currentPage = self.numberOfPages-1;
        }

        if (self.currentPage<self.numberOfPages-1)
        {
            self.currentPage += 1;
        }
    }


    // 2.显示绘图
    [self setNeedsDisplay];

    // 3.发送行为
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
#pragma mark - --- private methods 私有方法 ---
/**
 *  1.绘制图层
 *
 *  @param rect <#rect description#>
 */
- (void)drawRect:(CGRect)rect
{
    // 1.是否开启隐藏单页
    if (self.hidesForSinglePage && self.numberOfPages <= 1) {
        return;
    }

    // 1.获得处理的上下文
    CGContextRef myContext = UIGraphicsGetCurrentContext();

    // 2.控件的总宽度
    NSInteger totalWidth = self.numberOfPages * (self.gapWidth + self.diameter) - self.gapWidth;


    // 3.绘制图形
    for (int i = 0; i < self.numberOfPages; i++) {

        // 1.设置Rect
        CGFloat circleX = (self.frame.size.width-totalWidth)/2 + i*(self.diameter+self.gapWidth);
        CGFloat circleY = (self.frame.size.height - self.diameter)/2;
        CGFloat circleW = self.diameter;
        CGFloat circleH = self.diameter;
        CGRect  circleFrame = CGRectMake(circleX, circleY, circleW, circleH);

        // 2.设置线宽
        CGContextSetLineWidth(myContext, self.lineWidth);

        if (i == self.currentPage) {    // 1.选中的视图的设置

            // 1.填充整个
            CGContextSetFillColorWithColor(myContext, [self.coreSelectedColor CGColor]);
            CGContextFillEllipseInRect(myContext, circleFrame);

            // 2.填充边线
            CGContextSetStrokeColorWithColor(myContext, [self.lineSelectedColor CGColor]);
            CGContextStrokeEllipseInRect(myContext, circleFrame);

            // 3.填充数字
            if (self.isShowNumber) {

                // 3.1 显示的内容
                NSString *pageNumber = [NSString stringWithFormat:@"%i", i+1];

                // 3.2 设置居中
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentCenter;

                // 3.3 设置字体尺寸
                CGFloat fontSize     = (self.diameter -  self.lineWidth);
                CGFloat fontY        = (self.frame.size.height- fontSize)/ 2 - self.diameter/10;
                circleFrame.origin.y = fontY;


                [pageNumber drawInRect:circleFrame
                        withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                         NSForegroundColorAttributeName:self.textSelectedColor,
                                         NSParagraphStyleAttributeName:paragraph}];
            }

        }else {                         // 2.正常的视图的设置

            // 1.填充整个
            CGContextSetFillColorWithColor(myContext, [self.coreNormalColor CGColor]);
            CGContextFillEllipseInRect(myContext, circleFrame);

            // 2.填充边线
            CGContextSetStrokeColorWithColor(myContext, [self.lineNormalColor CGColor]);
            CGContextStrokeEllipseInRect(myContext, circleFrame);

            // 3.填充数字
            if (self.isShowNumber) {
                // 3.1 显示的内容
                NSString *pageNumber = [NSString stringWithFormat:@"%i", i+1];

                // 3.2 设置居中
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentCenter;

                // 3.3 设置字体尺寸
                CGFloat fontSize     = (self.diameter -  self.lineWidth)*0.8;
                CGFloat fontY        = (self.frame.size.height- fontSize)/ 2 - self.diameter/10;
                circleFrame.origin.y = fontY;

                [pageNumber drawInRect:circleFrame
                        withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                         NSForegroundColorAttributeName:self.textNormalColor,
                                         NSParagraphStyleAttributeName:paragraph}];
            }
        }
    }
}
#pragma mark - --- setters 属性 ---

- (void)setIsShowNumber:(BOOL)isShowNumber
{
    _isShowNumber = isShowNumber;
    [self setNeedsDisplay];
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self setNeedsDisplay];
}

- (void)setGapWidth:(NSInteger)gapWidth
{
    _gapWidth = gapWidth;
    [self setNeedsDisplay];
}

- (void)setDiameter:(NSInteger)diameter
{
    _diameter = diameter;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(NSInteger)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}
#pragma mark - --- getters 属性 —

@end

