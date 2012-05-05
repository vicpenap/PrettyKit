//
//  Drawing.m
//  PrettyExample
//
//  Created by Víctor on 01/03/12.

// Copyright (c) 2012 Victor Pena Placer (@vicpenap)
// http://www.victorpena.es/
// 
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


#import "PrettyDrawing.h"
#import <QuartzCore/QuartzCore.h>

@implementation PrettyDrawing

CGMutablePathRef PrettyKitCreateMutablePathForRoundedRect(CGRect rect, CGFloat radius) {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, rect.origin.x + radius, rect.origin.y + radius, radius, (180) * M_PI/180, (-90) * M_PI/180, 0);
    CGPathAddArc(path, NULL, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, (-90) * M_PI/180, (0) * M_PI/180, 0);
    CGPathAddArc(path, NULL, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, (0) * M_PI/180, (-270) * M_PI/180, 0);
    CGPathAddArc(path, NULL, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, (-270) * M_PI/180, (-180) * M_PI/180, 0);

    return path;
}

+ (void)drawRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius color:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGMutablePathRef path = PrettyKitCreateMutablePathForRoundedRect(rect, radius);
    CGContextAddPath(context, path);

    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextRestoreGState(context);
    CGPathRelease(path);
}

+ (void)drawGradientRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius fromColor:(UIColor *)from toColor:(UIColor *)to {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGMutablePathRef path = PrettyKitCreateMutablePathForRoundedRect(rect, radius);
    CGContextAddPath(context, path);    
    CGContextClip(context);
    
    [PrettyDrawing drawGradientForContext:context 
                               startPoint:CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y)
                                 endPoint:CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height)
                                fromColor:from
                                  toColor:to];
    
    CGContextRestoreGState(context);
    CGPathRelease(path);

}

+ (void)drawGradientForContext:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat locations[] = {0.0, 1.0};
    
    // iOS 4.3 safe way of drawing gradients. not as awesome as CGGradientCreateWithColors
    CGFloat fromComponents[4];
    [fromColor getRGBColorComponents:fromComponents];
    
    CGFloat toComponents[4];
    [toColor getRGBColorComponents:toComponents];
    
    CGFloat colors[8] = {   fromComponents[0], fromComponents[1], fromComponents[2], fromComponents[3], 
                            toComponents[0], toComponents[1], toComponents[2], toComponents[3]};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 2);
    
    /////////////////////////////////////////////////////////////////////////
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void) drawGradient:(CGRect)rect fromColor:(UIColor *)from toColor:(UIColor *)to {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGContextAddRect(ctx, rect);
    CGContextClip(ctx);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    [PrettyDrawing drawGradientForContext:ctx startPoint:startPoint endPoint:endPoint fromColor:from toColor:to];
        
    CGContextRestoreGState(ctx);
}

+ (void) drawLineAtPosition:(LinePosition)position rect:(CGRect)rect color:(UIColor *)color {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    float y = 0;
    switch (position) {
        case LinePositionTop:
            y = CGRectGetMinY(rect) + 0.5;
            break;
        case LinePositionBottom:
            y = CGRectGetMaxY(rect) - 0.5;
        default:
            break;
    }
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), y);
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), y);
    
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx, 1.5);
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
}

+ (void) drawLineAtHeight:(float)height rect:(CGRect)rect color:(UIColor *)color width:(float)width {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    float y = height;
    
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), y);
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), y);
    
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx, width);
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
}

+ (void) drawGradient:(CGGradientRef)gradient rect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(ctx);
}


@end


@implementation UIView (PrettyKit)

- (void) dropShadowOffset:(CGSize)offset withOpacity:(float)opacity {
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void) dropShadowWithOpacity:(float)opacity {
    [self dropShadowOffset:CGSizeMake(0, 0) withOpacity:opacity];
    
}


@end


@implementation UIColor (PrettyKit)

// http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
+ (UIColor *) colorWithHex:(int)hex {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0 
                            blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

-(void)getRGBColorComponents:(CGFloat [4])components {
    if (CGColorGetNumberOfComponents([self CGColor]) == 4) {
        const CGFloat *actualComponents = CGColorGetComponents([self CGColor]);
        
        components[0] = actualComponents[0];
        components[1] = actualComponents[1];
        components[2] = actualComponents[2];
        components[3] = actualComponents[3];

        return;
    }
    
    components[3] = CGColorGetAlpha([self CGColor]);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}


@end