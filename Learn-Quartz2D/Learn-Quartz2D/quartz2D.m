//
//  quartz2D.m
//  Learn-Quartz2D
//
//  Created by MAC on 16/2/26.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "quartz2D.h"

@implementation quartz2D
{
    CGContextRef context;
}

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
    context = UIGraphicsGetCurrentContext();
    [self drawLine];
    [self drawLine2];
    [self drawRef];
    [self drawTriangle];
    [self drawCircle];
    [self drawString];
    [self drawImage];
}

- (void)drawLine
{
    //1.获得上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);//将上下文复制一份到栈中***
    
    CGContextSetLineWidth(context, 20);//设置宽度
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
    
    //4.渲染上下文
    CGContextStrokePath(context);
}

- (void)drawLine2
{
    CGContextRestoreGState(context);//将图形上下文出栈，替换当前的上下文***
    CGContextSaveGState(context);//复制一份到栈上
    [[UIColor blueColor] set];
    
    //设置线段转折点的样式
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    //画线
    CGContextMoveToPoint(context, 100, 120);
    
    CGContextAddLineToPoint(context, 150, 120);
    CGContextAddLineToPoint(context, 150, 180);
    CGContextAddLineToPoint(context, 400, 400);
    //这些线的起点就是上个终点
    
    //3.显示到view
    CGContextStrokePath(context);
}

- (void)drawRef
{
//    CGContextRef
    //绘制矩形
    CGContextRestoreGState(context);//图形上下文出栈
    CGContextSaveGState(context);
    //    CGContextMoveToPoint(context, 100, 100);
    CGContextAddRect(context, CGRectMake(100, 100, 100, 100));
    [[UIColor greenColor] set];
    //    [[UIColor whiteColor] setFill];//填满
    //    CGContextStrokePath(context);//显示的线条
    CGContextFillPath(context);//显示的是填充
}

- (void)drawTriangle
{
    //绘制三角形 1,自己画线 2.画一部分然后闭合
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    
    CGContextMoveToPoint(context, 0, 50);
    CGContextAddLineToPoint(context, 50, 0);
    CGContextAddLineToPoint(context, 50, 100);
//    CGContextMoveToPoint(context, 0, 50);
    CGContextAddLineToPoint(context, 0, 50);
    //    CGContextClosePath(context);//方法2
    
    CGContextStrokePath(context);
    //    CGContextFillPath(context);
}

//画圆
- (void)drawCircle
{
    //1.获取图形上下文
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    //2.绘制图形
    CGContextAddEllipseInRect(context, CGRectMake(50, 50, 100, 100));
    
    CGContextSetLineWidth(context, 2);
    [[UIColor blackColor] setFill];
    //3.显示在View上
//    CGContextStrokePath(context);
    CGContextFillPath(context);
}

- (void)drawString
{
    NSString * string = @"bike😂";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];//设置文字大小
    attributes[NSForegroundColorAttributeName] = [UIColor purpleColor];
    [string drawInRect:CGRectMake(100, 100, 100, 30) withAttributes:attributes];
}

- (void)drawImage
{
    //1.取得图片
    UIImage *img = [UIImage imageNamed:@"image"];
    //2.画
//    [img drawAtPoint:CGPointMake(20, 20)];//在(20,20)这个位置开始画原尺寸
    
//    [img drawInRect:CGRectMake(20, 20, 100, 100)];//设置起始点，和宽高,会自动拉伸图片
    
    [img drawAsPatternInRect:CGRectMake(300, 300, 50, 50)];//不会自动拉伸图片，不够时会自动平铺，类似于格子
    
    //增加文字，也可以设置水印
    NSString *str = @"测试文本";
    [str drawInRect:CGRectMake(0, 0, 100, 30) withAttributes:nil];
}
@end
