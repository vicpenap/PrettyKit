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

#define default_text_shadow_offset                      CGSizeMake(0,-1)
#define default_text_shadow_opacity                     0.5
#define default_font                                    [UIFont fontWithName:@"HelveticaNeue-Bold" size:10]
#define default_text_color                              [UIColor colorWithWhite:0.2 alpha:1.0]
#define default_highlighted_text_color                  [UIColor colorWithWhite:0.90 alpha:1.0]
#define default_badge_font                              [UIFont fontWithName:@"HelveticaNeue-Bold" size:11]
#define default_badge_gradient_start_color              [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:1.000]
#define default_badge_gradient_end_color                [UIColor colorWithRed:0.6 green:0.000 blue:0.000 alpha:1.000]
#define default_badge_border_color                      [UIColor whiteColor]
#define default_badge_shadow_opacity                    0.75
#define default_badge_shadow_offset                     CGSizeMake(0,2)
#define default_badge_text_color                        [UIColor whiteColor]
#define default_highlight_gradient_start_color          [UIColor colorWithWhite:0.4 alpha:1.0] 
#define default_highlight_gradient_end_color            [UIColor colorWithWhite:0.1 alpha:1.0]
#define default_highlighted_image_gradient_start_color  [UIColor colorWithRed:0.276 green:0.733 blue:1.000 alpha:1.000]
#define default_highlighted_image_gradient_end_color    [UIColor colorWithRed:0.028 green:0.160 blue:0.332 alpha:1.000]

#define IMAGE_HEIGHT 33.0
#define IMAGE_WIDTH 33.0

@interface PrettyTabBarButton (/* Pirvate Method */)
-(CGSize)_sizeForWidth:(CGFloat)width height:(CGFloat)height;
@end

@implementation PrettyTabBarButton
@synthesize title = _title, image = _image, badgeValue = _badgeValue;
@synthesize highlightedImage, highlightedImageGradientStartColor, highlightedImageGradientEndColor;
@synthesize textColor, font, highlightedTextColor;
@synthesize highlightImage, highlightGradientStartColor, highlightGradientEndColor;
@synthesize textShadowOpacity, textShadowOffset;
@synthesize badgeBorderColor, badgeGradientEndColor, badgeGradientStartColor, badgeFont, badgeShadowOffset, badgeShadowOpacity, badgeTextColor;

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

- (void) initializeVars 
{
    self.contentMode = UIViewContentModeRedraw;

    // default configuration
    self.font = default_font;
    self.textColor = default_text_color;
    self.highlightedTextColor = default_highlighted_text_color;
    self.highlightedImage = nil;
    self.textShadowOpacity = default_text_shadow_opacity;
    self.textShadowOffset = default_text_shadow_offset;
    self.badgeBorderColor = default_badge_border_color;
    self.badgeGradientStartColor = default_badge_gradient_start_color;
    self.badgeGradientEndColor = default_badge_gradient_end_color;
    self.badgeShadowOffset = default_badge_shadow_offset;
    self.badgeShadowOpacity = default_badge_shadow_opacity;
    self.badgeFont = default_badge_font;
    self.badgeTextColor = default_badge_text_color;
    self.highlightImage = nil;
    self.highlightGradientStartColor = default_highlight_gradient_start_color;
    self.highlightGradientEndColor = default_highlight_gradient_end_color;
    self.highlightedImageGradientStartColor = default_highlighted_image_gradient_start_color;
    self.highlightedImageGradientEndColor = default_highlighted_image_gradient_end_color;
    
    // intialize values;
    self.tag = -1;
    
    self.title = nil;
    self.image = nil;
    self.badgeValue = nil;
    
    self.selected = NO;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];

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

    CGContextSaveGState(context);
    
    // draw image
    if (self.image) {

        CGSize imageSize = [self _sizeForWidth:self.image.size.width height:self.image.size.height];
        
        CGRect imageRect = CGRectMake((self.frame.size.width - imageSize.width)/2, (self.frame.size.height - titleSize.height - imageSize.height)/2, imageSize.width, imageSize.height);

        if (self.selected) {
            // do the tint... or use the highlight image
            if (self.highlightedImage) {
                CGSize highlightedImageSize = [self _sizeForWidth:self.highlightedImage.size.width height:self.highlightedImage.size.height];
                
                [self.highlightedImage drawInRect:CGRectMake((self.frame.size.width - highlightedImageSize.width)/2, (self.frame.size.height - titleSize.height - highlightedImageSize.height)/2, highlightedImageSize.width, highlightedImageSize.height)];
                
            } else {
                
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
                                            fromColor:self.highlightedImageGradientEndColor
                                              toColor:self.highlightedImageGradientStartColor];

            }
            
        } else {
            // draw the image as per normal                
            [self.image drawInRect:imageRect];
        }
    }    
    
    CGContextRestoreGState(context);
    
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
                
        // draw inner badge color
        CGContextSaveGState(context);
        
        path = CGPathCreateMutable();
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
        
        // draw badgeValue
        [self.badgeTextColor setFill];
        [self.badgeValue drawInRect:CGRectMake(badgeFrame.origin.x + (badgeFrame.size.width - badgeTextSize.width)/2, badgeFrame.origin.y + (badgeFrame.size.height - badgeTextSize.height)/2, badgeTextSize.width, badgeTextSize.height)
                           withFont:self.badgeFont
                      lineBreakMode:UILineBreakModeTailTruncation];

    }
    
}

@end
