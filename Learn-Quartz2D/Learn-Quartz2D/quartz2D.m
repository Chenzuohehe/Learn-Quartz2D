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
//    [self drawLine];
//    [self drawLine2];
//    [self drawRef];
//    [self drawTriangle];
//    [self drawCircle];
//    [self drawString];
//    [self drawImage];
//    [self drawBezier];
    
//    [self drawPage];
//    [self drawArc];
    [self drawSectorGraph];
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
    
    
    // 2.画圆弧
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    // x/y 圆心
    // radius 半径
    // startAngle 开始的弧度
    // endAngle 结束的弧度
    // clockwise 画圆弧的方向 (0 顺时针, 1 逆时针)
    //    CGContextAddArc(context, 100, 100, 50, -M_PI_2, M_PI_2, 0);
    CGContextAddArc(context, 200, 200, 50, M_PI_2, M_PI, 1);
    CGContextClosePath(context);
    [[UIColor redColor] set];
    CGContextStrokePath(context);
//    CGContextFillPath(context);
    
    // 2.画饼状图
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    // 画线
    CGContextMoveToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 250, 250);
//    CGContextSetLineWidth(context, 20);
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);
    // 画圆弧
    CGContextAddArc(context, 250, 250, 50, M_PI_2, M_PI, 0);
//    //    CGContextAddArc(context, 100, 100, 50, -M_PI, M_PI_2, 1);
//    
//    // 关闭路径
//    CGContextClosePath(context);
    
    
    // 3.渲染 (注意, 画线只能通过空心来画)
//    CGContextFillPath(context);
    CGContextStrokePath(context);
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

- (void)drawBezier
{
    //1.获取图形上下文
//    CGContextRestoreGState(context);
//    CGContextSaveGState(context);
    //起点
    CGContextMoveToPoint(context, 210, 10);
    //2个控制点
    //CGContextAddCurveToPoint(context, 120, 100,   180, 50,  10, 190);
    //                               第一个控制点，第二个控制点，   终点
    
    //1个控制点
    CGContextAddQuadCurveToPoint(context, 150, 200, 200, 100);
    
    CGContextStrokePath(context);
}

//模仿页码的边角 的贝塞尔曲线
- (void)drawPage
{
    CGContextMoveToPoint(context, 275, 367);
    CGContextAddQuadCurveToPoint(context, 345, 337, 375 - 80, 375- 80);
    CGContextAddQuadCurveToPoint(context, 375-15, 367 - 20, 375, 375 -100);
    CGContextAddQuadCurveToPoint(context, 375, 367, 275, 367);
//    [[UIColor blackColor] set];
    CGContextStrokePath(context);
    
    
}

- (void)drawArc{
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 85, 85);
    
    CGContextAddLineToPoint(context, 150, 150);
    CGContextAddLineToPoint(context, 250, 50);
    
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 10);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGContextSetLineCap(context, kCGLineCapRound);
   
    CGContextDrawPath(context, kCGPathStroke);
//    CGContextFillPath(context);
}

//画饼状图
- (void)drawSectorGraph
{
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(100, 100, 200, 200));
    [[UIColor redColor] setFill];
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 200, 100);
//    CGContextSetLineWidth(context, 10);
    
    //弧线起点是最右
    CGContextAddArc(context, 200, 200, 101, - M_PI_2, M_PI, 0);
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setFill];
//    CGContextStrokePath(context);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(120, 120, 160, 160));
    [[UIColor whiteColor] setFill];
    CGContextFillPath(context);
    
}


@end
