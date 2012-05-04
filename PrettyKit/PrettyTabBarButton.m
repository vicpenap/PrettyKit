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

#define default_text_color                [UIColor colorWithWhite:0.20 alpha:1.0]
#define default_highlighted_text_color    [UIColor colorWithWhite:8.20 alpha:1.0]

@implementation PrettyTabBarButton
@synthesize title = _title, image = _image, badgeValue = _badgeValue;
@synthesize selected = _selected;
@synthesize textColor, highlightedTextColor, highlightedImage;

-(id)initWithTitle:(NSString *)title image:(UIImage *)image {
    if ((self = [super init])) {
        [self initializeVars];

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

    self.title = nil;
    self.image = nil;
    self.badgeValue = nil;
    
    self.selected = NO;
    
    self.textColor = default_text_color;
    self.highlightedTextColor = default_highlighted_text_color;
    self.highlightedImage = nil;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

@end
