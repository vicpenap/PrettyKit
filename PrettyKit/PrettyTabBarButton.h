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

@interface PrettyTabBarButton : UIControl

/** Specifies the image to use when the Button is selected. 
 If it is not specified, the button will use the normal image in another tint.
 
 By default is `nil`. */
@property (nonatomic, retain) UIImage *highlightedImage;

/** Specifies the font to use for the title of the button
 
 By default is `[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]`. */
@property (nonatomic, retain) UIFont *font;

/** Specifies the color for the title of the button
 
 By default is `[UIColor colorWithWhite:0.2 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *textColor;

/** Specifies the color for the title of the button when its been selected
 
 By default is `[UIColor colorWithWhite:0.90 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *highlightedTextColor;

/** Specifies the opacity of the title's shadow
 
 By default is `0.5`. */
@property (nonatomic) CGFloat textShadowOpacity;

/** Specifies the offset for the title's shadow
 
 By default is `CGSizeMake(0,-1)`. */
@property (nonatomic) CGSize textShadowOffset;

/** Specifies the start color for the highlight's gradient (when selected)
 
 By default is `[UIColor colorWithWhite:0.4 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *highlightGradientStartColor;

/** Specifies the end color for the highlight's gradient (when selected)
 
 By default is `[UIColor colorWithWhite:0.1 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *highlightGradientEndColor;

/** Specifies the image to use in place of the highlight gradient.
 
 By default is `nil`. */
@property (nonatomic, retain) UIImage *highlightImage;

/** Specifies the border color for the badge
 
 By default is `[UIColor whiteColor]`. */
@property (nonatomic, retain) UIColor *badgeBorderColor;

/** Specifies the start color for the badge's gradient
 
 By default is `[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:1.000]`. */
@property (nonatomic, retain) UIColor *badgeGradientStartColor;

/** Specifies the end color for the badge's gradient
 
 By default is `[UIColor colorWithRed:0.6 green:0.000 blue:0.000 alpha:1.000]`. */
@property (nonatomic, retain) UIColor *badgeGradientEndColor;

/** Specifies the shadow opacity for the badge
 
 By default is `0.75`. */
@property (nonatomic) CGFloat badgeShadowOpacity;

/** Specifies the shadow offset for the badge
 
 By default is `CGSizeMake(0,2)`. */
@property (nonatomic) CGSize badgeShadowOffset;

/** Specifies the font used for the value of the badge
 
 By default is `[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]`. */
@property (nonatomic, retain) UIFont *badgeFont;

/** Specifies the color used for the text in the badge's value
 
 By default is `[UIColor whiteColor]`. */
@property (nonatomic, retain) UIColor *badgeTextColor;

//////////////////////////////////////////////////////////////////////////////
// Internal Methods for Tight coupling with PrettyTabBar
//////////////////////////////////////////////////////////////////////////////

/** Specifies the title of the button
 
 By default is `nil`. */
@property (nonatomic, copy) NSString *title;

/** Specifies the value of the badge on the button
 
 By default is `nil`. */
@property (nonatomic, copy) NSString *badgeValue;

/** Specifies the image of the button
 
 By default is `nil`. */
@property (nonatomic, retain) UIImage *image;

-(id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag;

@end
