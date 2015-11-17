//
//  STPageControl.m
//  STPageControlDemo
//
//  Created by shentian on 15/11/17.
//  Copyright © 2015年 ST. All rights reserved.
//

#import "STPageControl.h"

@implementation STPageControl


#define Width self.frame.size.width

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
    _coreNormalColor = [UIColor whiteColor];
//    _coreSelectedColor = 

    _lineWidth = 4;
    _gapWidth    = 20;
    _diameter    = 20;
        _coreSelectedColor = [UIColor whiteColor];
    
    _strokeNormalColor = [UIColor redColor];
    _strokeSelectedColor = [UIColor greenColor];
    
    
    // 2.设置手势操作
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(onTapped:)];
    [self addGestureRecognizer:tap];
}


///** 1.内部的普通色 */
//@property (nonatomic, strong, nullable) UIColor *coreNormalColor;
///** 2.内部的选中色 */
//@property (nonatomic, strong, nullable) UIColor *coreSelectedColor;
///** 3.边线的普通色 */
//@property (nonatomic, strong, nullable) UIColor *strokeNormalColor;
///** 4.边线的选中色 */
//@property (nonatomic, strong, nullable) UIColor *strokeSelectedColor;
//
///** 5.当前页,default is 0 */
//@property (nonatomic) NSInteger currentPage;
///** 6.总页数,default is 0. value pinned to 0..numberOfPages-1  */
//@property (nonatomic) NSInteger numberOfPages;
///** 7.边线宽,default is 2  */
//@property (nonatomic) NSInteger lineWidth;
///** 8.圆圈直径,default is 10  */
//@property (nonatomic) NSInteger diameter;
///** 9.间隔宽度,default is 10 */
//@property (nonatomic) NSInteger gapWidth;
//
///** 10.单页的时候是否隐藏,hide the the indicator if there is only one page. default is NO*/
//@property (nonatomic) BOOL hidesForSinglePage;
///** 11.是否显示数字,default is NO  */
//@property (nonatomic) BOOL isShowNumber;

/**
 *  3.点击事件
 *
 *  @param gesture <#gesture description#>
 */
- (void)onTapped:(UITapGestureRecognizer*)gesture
{
    // 0.获取触控的位置
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    // 1.设置当前页
    if (touchPoint.x < Width/2) // 1.点击控件的左边
    {
        if (self.currentPage>0)
        {
            self.currentPage -= 1;
        }
        
    } else {                    // 2.点击控件的右边
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

/**
 *  4.重新绘制
 *
 *  @param rect <#rect description#>
 */
- (void)drawRect:(CGRect)rect
{
    // 1.获得处理的上下文
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    // 2.控件的总宽度
    NSInteger totalWidth = self.numberOfPages*self.diameter + (self.numberOfPages-1)*self.gapWidth;
    
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
            
            // 1、填充整个
            CGContextSetFillColorWithColor(myContext, [self.coreSelectedColor CGColor]);
            CGContextFillEllipseInRect(myContext, circleFrame);
            
            // 2.填充边线
            CGContextSetStrokeColorWithColor(myContext, [self.strokeSelectedColor CGColor]);
            CGContextStrokeEllipseInRect(myContext, circleFrame);

            // 3.填充数字
            
            CGRect frame = circleFrame;
            frame.origin.y = circleY-2;
            NSString *pageNumber = [NSString stringWithFormat:@"%i", i+1];
            CGContextSetFillColorWithColor(myContext, [[UIColor whiteColor] CGColor]);
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.alignment = NSTextAlignmentCenter;
            [pageNumber drawInRect:frame
                    withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.diameter],
                                     NSForegroundColorAttributeName:[UIColor redColor],
                                     NSParagraphStyleAttributeName:paragraph}];
            
        }else {                         // 2.正常的视图的设置
            CGContextSetFillColorWithColor(myContext, [self.coreNormalColor CGColor]);
            CGContextFillEllipseInRect(myContext, circleFrame);
            
            CGContextSetStrokeColorWithColor(myContext, [self.strokeNormalColor CGColor]);
            CGContextStrokeEllipseInRect(myContext, circleFrame);
            
            // 3.填充数字
            NSString *pageNumber = [NSString stringWithFormat:@"%i", i+1];
            CGContextSetFillColorWithColor(myContext, [[UIColor whiteColor] CGColor]);
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.alignment = NSTextAlignmentCenter;
            [pageNumber drawInRect:circleFrame
                    withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.diameter-4],
                                     NSForegroundColorAttributeName:[UIColor redColor],
                                     NSParagraphStyleAttributeName:paragraph}];
        }
    }
}

+ (STPageControl *)pageControlWithFrame:(CGRect)frame
                          numberOfPages:(NSInteger)numberOfPages
                               gapWidth:(NSInteger)gapWidth
                               diameter:(NSInteger)diameter
                              lineWidth:(NSInteger)lineWidth

{
    STPageControl *pageControl = [[STPageControl alloc]initWithFrame:frame];
    pageControl.numberOfPages = numberOfPages;
    pageControl.gapWidth = gapWidth;
    pageControl.diameter = diameter;
    pageControl.lineWidth = lineWidth;
    return pageControl;
}

@end

