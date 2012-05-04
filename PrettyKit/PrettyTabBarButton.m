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

@implementation PrettyTabBarButton
@synthesize title = _title, image = _image, badgeValue = _badgeValue;
@synthesize selected = _selected;
@synthesize textColor, font, highlightedTextColor, highlightedImage;
@synthesize wantTextShadow, textShadowOpacity, textShadowOffset;

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
}

@end
