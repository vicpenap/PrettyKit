//
//  PrettyTabBarButton.m
//  PrettyExample
//
//  Created by Jeremy Foo on 4/5/12.

//  Copyright (c) 2012 Jeremy Foo. (@echoz)
//  http://ornyx.net
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

#import "PrettyTabBarButton.h"
#import "PrettyDrawing.h"


#define IMAGE_HEIGHT 33.0
#define IMAGE_WIDTH 33.0

@interface PrettyTabBarButton (/* Private Method */)
-(CGSize)_sizeForWidth:(CGFloat)width height:(CGFloat)height;
@end

@implementation PrettyTabBarButton
@synthesize title = _title, image = _image, badgeValue = _badgeValue;
@synthesize highlightedImage, highlightedImageGradientStartColor, highlightedImageGradientEndColor;
@synthesize textColor, font, highlightedTextColor;
@synthesize highlightImage, highlightGradientStartColor, highlightGradientEndColor;
@synthesize textShadowOpacity, textShadowOffset;
@synthesize badgeBorderColor, badgeGradientEndColor, badgeGradientStartColor, badgeFont, badgeShadowOffset, badgeShadowOpacity, badgeTextColor;

- (void) initializeVars 
{
    self.contentMode = UIViewContentModeRedraw;
    
    // default configuration
    
    self.tag = -1;
    
    self.title = nil;
    self.image = nil;
    self.badgeValue = nil;
    
    self.selected = NO;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
}

-(id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag {
    if ((self = [super init])) {
        [self initializeVars];

        self.tag = tag;
        self.title = title;
        self.image = image;
        
    }
    return self;
}

-(id)init {
    if ((self = [super init])) {
        [self initializeVars];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self initializeVars];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initializeVars];
    }
    return self;
}

-(void)dealloc {
    [_title release], _title = nil;
    [_image release], _image = nil;
    [_badgeValue release], _badgeValue = nil;

    self.highlightedImage = nil;
    self.highlightedImageGradientStartColor = nil;
    self.highlightedImageGradientEndColor = nil;

    self.font = nil;
    self.textColor = nil;
    self.highlightedTextColor = nil;
    self.badgeBorderColor = nil;
    self.badgeGradientStartColor = nil;
    self.badgeGradientEndColor = nil;
    self.badgeFont = nil;
    self.badgeTextColor = nil;    

    self.highlightImage = nil;
    self.highlightGradientStartColor = nil;
    self.highlightGradientEndColor = nil;
    
    [super dealloc];
}



#pragma mark - Selection and Accessors

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsDisplay];
}

-(void)setBadgeValue:(NSString *)badgeValue {
    if (_badgeValue != badgeValue) {
        [_badgeValue release];
        _badgeValue = [badgeValue copy];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing

-(CGSize)_sizeForWidth:(CGFloat)width height:(CGFloat)height {
    CGFloat returnWidth = IMAGE_WIDTH;
    CGFloat returnHeight = IMAGE_HEIGHT;
    
    if (width < IMAGE_WIDTH)
        returnWidth = self.image.size.width;
    
    if (height < IMAGE_HEIGHT)
        returnHeight = self.image.size.height;
    
    return CGSizeMake(returnWidth, returnHeight);
}

- (CGSize)drawText:(CGContextRef)context
{
    // draw text
    CGContextSaveGState(context);
    
    if (self.selected)
        CGContextSetShadow(context, self.textShadowOffset, self.textShadowOpacity);
    
    if (self.selected) {
        [self.highlightedTextColor setFill];
    } else {
        [self.textColor setFill];
    }
    
    CGSize titleSize = [_title sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 10.0)];
    [_title drawInRect:CGRectMake((self.frame.size.width - titleSize.width)/2, self.frame.size.height - titleSize.height, titleSize.width, titleSize.height) withFont:self.font];
    
    CGContextRestoreGState(context);
    return titleSize;
}

- (void)tintImage:(CGContextRef)context 
        titleSize:(CGSize)titleSize
        imageSize:(CGSize)imageSize
        imageRect:(CGRect)imageRect
        fromColor:(UIColor *)from
          toColor:(UIColor *)to
{
    // draw tint using gradient
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect flippedImageRect = imageRect;
    flippedImageRect.origin.y = ((self.frame.size.height - titleSize.height)/2 - (imageSize.height/2)) + titleSize.height;
    
    CGContextClipToMask(context, flippedImageRect, [self.image CGImage]);
    
    // because the context has been flipped, the gradient start and end colors also has to be flipped;
    [PrettyDrawing drawGradientForContext:context 
                               startPoint:CGPointMake(flippedImageRect.origin.x + flippedImageRect.size.width/2, 0) 
                                 endPoint:CGPointMake(flippedImageRect.origin.x + flippedImageRect.size.width/2, flippedImageRect.origin.y + flippedImageRect.size.height)
                                fromColor:from
                                  toColor:to];
}

- (void)drawImage:(CGContextRef)context titleSize:(CGSize)titleSize
{
    // draw image
    CGContextSaveGState(context);
    
    if (self.image) {
        
        CGSize imageSize = [self _sizeForWidth:self.image.size.width height:self.image.size.height];
        
        CGRect imageRect = CGRectMake((self.frame.size.width - imageSize.width)/2, (self.frame.size.height - titleSize.height - imageSize.height)/2, imageSize.width, imageSize.height);
        
        if (self.selected) {
            if (self.highlightedImage) {
                CGSize highlightedImageSize = [self _sizeForWidth:self.highlightedImage.size.width height:self.highlightedImage.size.height];
                
                [self.highlightedImage drawInRect:CGRectMake((self.frame.size.width - highlightedImageSize.width)/2, (self.frame.size.height - titleSize.height - highlightedImageSize.height)/2, highlightedImageSize.width, highlightedImageSize.height)];
                
            } else {
                [self tintImage:context 
                      titleSize:titleSize
                      imageSize:imageSize
                      imageRect:imageRect
                      fromColor:self.highlightedImageGradientEndColor 
                        toColor:self.highlightedImageGradientStartColor];
            }            
        } else {
            // draw the image as per normal                
            [self tintImage:context
                  titleSize:titleSize
                  imageSize:imageSize
                  imageRect:imageRect
                  fromColor:self.textColor
                    toColor:self.textColor];
        }
    }    
    
    CGContextRestoreGState(context);
}

- (void)drawBadgeFrame:(CGFloat)badgeHeight badgeFrame:(CGRect)badgeFrame context:(CGContextRef)context
{
    // draw outter border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeHeight/2, badgeFrame.origin.y + badgeHeight/2, badgeHeight/2, M_PI / 2, M_PI * 3 / 2, NO);
    CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeFrame.size.width - badgeHeight/2, badgeFrame.origin.y + badgeHeight/2, badgeHeight/2, M_PI * 3 / 2, M_PI / 2, NO);
    
    CGContextSaveGState(context);
    
    CGContextSetShadow(context, self.badgeShadowOffset, self.badgeShadowOpacity);
    CGContextSetFillColorWithColor(context, [self.badgeBorderColor CGColor]);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFill);
    CGPathRelease(path);
    
    CGContextRestoreGState(context);
}

- (void)drawInnerBadgeColor:(CGContextRef)context badgeHeight:(CGFloat)badgeHeight badgeFrame:(CGRect)badgeFrame
{
    // draw inner badge color
    CGContextSaveGState(context);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeHeight/2, badgeFrame.origin.y + badgeHeight/2, badgeHeight/2 - 2, M_PI / 2, M_PI * 3 / 2, NO);
    CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeFrame.size.width - badgeHeight/2, badgeFrame.origin.y + badgeHeight/2, badgeHeight/2 - 2, M_PI * 3 / 2, M_PI / 2, NO);
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextClip(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    NSArray *colors = [NSArray arrayWithObjects:(id)[self.badgeGradientStartColor CGColor], (id)[self.badgeGradientEndColor CGColor], nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(badgeFrame.origin.x + badgeFrame.size.width/2, badgeFrame.origin.y + 0), CGPointMake(badgeFrame.origin.x + badgeFrame.size.width/2, badgeFrame.origin.y + badgeFrame.size.height), 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    CGContextRestoreGState(context);
}

- (void)drawBadgeValue:(CGSize)badgeTextSize badgeFrame:(CGRect)badgeFrame
{
    // draw badgeValue
    [self.badgeTextColor setFill];
    [self.badgeValue drawInRect:CGRectMake(badgeFrame.origin.x + (badgeFrame.size.width - badgeTextSize.width)/2, badgeFrame.origin.y + (badgeFrame.size.height - badgeTextSize.height)/2, badgeTextSize.width, badgeTextSize.height)
                       withFont:self.badgeFont
                  lineBreakMode:UILineBreakModeTailTruncation];
}

- (void)drawBadge:(CGContextRef)context
{
    // draw badge
    if (self.badgeValue) {
        CGSize badgeTextSize = [self.badgeValue sizeWithFont:self.badgeFont forWidth:(self.frame.size.width * 0.45) lineBreakMode:UILineBreakModeTailTruncation];
        
        CGFloat badgeWidth = badgeTextSize.width;
        CGFloat badgeHeight = badgeTextSize.height + 4;
        
        if ((badgeHeight - badgeWidth) < 0)
            badgeWidth += badgeHeight * 0.8;
        
        if (badgeWidth < (badgeHeight))
            badgeWidth = badgeHeight;
        
        CGRect badgeFrame = CGRectMake((self.frame.size.width - badgeWidth)/2 + 20, 1, badgeWidth, badgeHeight);
        
        [self drawBadgeFrame:badgeHeight badgeFrame:badgeFrame context:context];
        
        [self drawInnerBadgeColor:context badgeHeight:badgeHeight badgeFrame:badgeFrame];
        
        [self drawBadgeValue:badgeTextSize badgeFrame:badgeFrame];
        
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    // draw selection background
    if (self.selected) {
        if (self.highlightImage) {
            [self.highlightImage drawInRect:CGRectMake(2, 1, self.frame.size.width - 2, self.frame.size.height - 1)];
            
        } else {            
            
            [PrettyDrawing drawGradientRoundedRect:CGRectMake(2, 3, self.frame.size.width - 4, self.frame.size.height - 5) 
                                      cornerRadius:3.0 
                                         fromColor:self.highlightGradientStartColor
                                           toColor:self.highlightGradientEndColor];
        }
    }
    
    CGSize titleSize;
    titleSize = [self drawText:context];

    [self drawImage:context titleSize:titleSize];
    
    [self drawBadge:context];
    
}

@end
