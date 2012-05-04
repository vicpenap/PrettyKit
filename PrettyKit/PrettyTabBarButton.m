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

#define default_want_text_shadow          YES
#define default_text_shadow_offset        CGSizeMake(0,1)
#define default_text_shadow_opacity       0.5
#define default_font                      [UIFont fontWithName:@"HelveticaNeue-Bold" size:11]
#define default_text_color                [UIColor colorWithWhite:0.20 alpha:1.0]
#define default_highlighted_text_color    [UIColor colorWithWhite:0.10 alpha:1.0]
#define default_badge_font                [UIFont fontWithName:@"HelveticaNeue-Bold" size:13]
#define default_badge_color               [UIColor redColor]
#define default_badge_border_color        [UIColor whiteColor]
#define default_badge_shadow_opacity      0.5
#define default_badge_shadow_offset       CGSizeMake(0,1)

@implementation PrettyTabBarButton
@synthesize title = _title, image = _image, badgeValue = _badgeValue;
@synthesize selected = _selected;
@synthesize textColor, font, highlightedTextColor, highlightedImage;
@synthesize wantTextShadow, textShadowOpacity, textShadowOffset;
@synthesize badgeBorderColor, badgeColor, badgeFont, badgeShadowOffset, badgeShadowOpacity;

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
    
    self.font = nil;
    self.textColor = nil;
    self.highlightedTextColor = nil;
    self.highlightedImage = nil;
    self.badgeBorderColor = nil;
    self.badgeColor = nil;
    self.badgeFont = nil;
    
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
    self.wantTextShadow = default_want_text_shadow;
    self.textShadowOpacity = default_text_shadow_opacity;
    self.textShadowOffset = default_text_shadow_offset;
    self.badgeBorderColor = default_badge_border_color;
    self.badgeColor = default_badge_color;
    self.badgeShadowOffset = default_badge_shadow_offset;
    self.badgeShadowOpacity = default_badge_shadow_opacity;
    self.badgeFont = default_badge_font;
    
    // intialize values;
    self.tag = -1;
    
    self.title = nil;
    self.image = nil;
    self.badgeValue = nil;
    
    self.selected = NO;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];

}

-(void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

-(void)setBadgeValue:(NSString *)badgeValue {
    if (_badgeValue != badgeValue) {
        [_badgeValue release];
        _badgeValue = [badgeValue copy];
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    // draw selection background
    if (self.selected) {
        if (self.highlightedImage) {
            
        } else {            
            [PrettyDrawing drawGradient:rect fromColor:[UIColor colorWithWhite:0.9 alpha:1.0] toColor:[UIColor colorWithWhite:0.8 alpha:1.0]];
        }
    }
    
    // draw text
    CGContextSaveGState(context);

    if (self.wantTextShadow) {
        CGContextSetShadow(context, self.textShadowOffset, self.textShadowOpacity);
    }
    
    if (self.selected) {
        [self.highlightedTextColor setFill];
    } else {
        [self.textColor setFill];
    }
    
    CGSize titleSize = [_title sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 10.0)];
    [_title drawInRect:CGRectMake((self.frame.size.width - titleSize.width)/2, self.frame.size.height - titleSize.height, titleSize.width, titleSize.height) withFont:self.font];

    CGContextRestoreGState(context);
    
    // draw badge
    if (self.badgeValue) {
        CGSize badgeTextSize = [self.badgeValue sizeWithFont:self.badgeFont forWidth:(self.frame.size.width * 0.5) lineBreakMode:UILineBreakModeTailTruncation];
        CGFloat badgeWidth = badgeTextSize.width;
        CGFloat badgeHeight = badgeTextSize.height + 4;
        
        if ((badgeHeight - badgeWidth) < 0)
            badgeWidth += badgeHeight * 0.8;
        
        if (badgeWidth < (badgeHeight * 2))
            badgeWidth = badgeHeight * 2;
        
        CGRect badgeFrame = CGRectMake(self.frame.size.width - badgeWidth - 2, 2, badgeWidth, badgeHeight);
                
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeHeight, badgeFrame.origin.y + badgeHeight, badgeHeight, M_PI / 2, M_PI * 3 / 2, NO);
        CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeFrame.size.width - badgeHeight, badgeFrame.origin.y + badgeHeight, badgeHeight, M_PI * 3 / 2, M_PI / 2, NO);
        
        CGContextSaveGState(context);
        
        CGContextSetShadow(context, self.badgeShadowOffset, self.badgeShadowOpacity);
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFill);
        CGPathRelease(path);
        
        CGContextRestoreGState(context);
        
        path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeHeight, badgeFrame.origin.y + badgeHeight, badgeHeight - 2, M_PI / 2, M_PI * 3 / 2, NO);
        CGPathAddArc(path, NULL, badgeFrame.origin.x + badgeFrame.size.width - badgeHeight, badgeFrame.origin.y + badgeHeight, badgeHeight - 2, M_PI * 3 / 2, M_PI / 2, NO);
        CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFill);
        CGPathRelease(path);

        
        [[UIColor whiteColor] setFill];
        [self.badgeValue drawInRect:CGRectMake(badgeFrame.origin.x + (badgeFrame.size.width - badgeTextSize.width)/2, badgeFrame.origin.y + (badgeFrame.size.height - badgeTextSize.height)/2, badgeTextSize.width, badgeTextSize.height)
                           withFont:self.badgeFont
                      lineBreakMode:UILineBreakModeTailTruncation];

    }
    
}

@end
