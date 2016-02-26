//
//  quartz2D.m
//  Learn-Quartz2D
//
//  Created by MAC on 16/2/26.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "quartz2D.h"

@implementation quartz2D

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}


/*
绘图的核心步骤：
获得上下文
绘制/拼接绘图路径
将路径添加到上下文
渲染上下文
 */

- (void)drawRect:(CGRect)rect {
    [self drawLine];
}

- (void)drawLine
{
    //1.获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);//将上下文复制一份到栈中
    
    CGContextSetLineWidth(context, 2);//设置宽度
    /**
     kCGLineCapButt,
     kCGLineCapRound,
     kCGLineCapSquare
     */
    CGContextSetLineCap(context, kCGLineCapRound);//设置线条样式
    
    //2.绘制/拼接绘图路径
    CGContextMoveToPoint(context, 10, 10);//设置线条起点(CGContextRef  _Nullable c, CGFloat x, CGFloat y)
    CGContextAddLineToPoint(context, 100, 100);//画线(CGContextRef  _Nullable c, CGFloat x, CGFloat y)
    //设置颜色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    
    //渲染上下文
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
//    [[UIColor redColor] set];
    
    //设置线段转折点的样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //画线
    CGContextMoveToPoint(context, 100, 120);
    
    CGContextAddLineToPoint(context, 150, 120);
    CGContextAddLineToPoint(context, 150, 180);
    
    //3.显示到view
    CGContextStrokePath(context);
    
}
@end
