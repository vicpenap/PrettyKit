//
//  PrettyTabBarButton.h
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

#import <UIKit/UIKit.h>

@interface PrettyTabBarButton : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic) BOOL selected;

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *highlightedTextColor;

@property (nonatomic) CGFloat textShadowOpacity;
@property (nonatomic) CGSize textShadowOffset;
@property (nonatomic) BOOL wantTextShadow;

@property (nonatomic, retain) UIImage *highlightedImage;

@property (nonatomic, retain) UIColor *badgeBorderColor;
@property (nonatomic, retain) UIColor *badgeGradientStartColor;
@property (nonatomic, retain) UIColor *badgeGradientEndColor;
@property (nonatomic) CGFloat badgeShadowOpacity;
@property (nonatomic) CGSize badgeShadowOffset;
@property (nonatomic, retain) UIFont *badgeFont;
@property (nonatomic, retain) UIColor *badgeTextColor;

-(id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag;

@end
