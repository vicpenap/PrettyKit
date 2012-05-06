//
//  PrettyTabBar.h
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


#import <UIKit/UIKit.h>

/** `PrettyTabBar` is a subclass of `UITabBar` that removes the
 glossy effect and lets you customize its colors.
 
 ![](../docs/Screenshots/tabbar.png)
 
 You can change the tab bar appearance as follows:
 
 - gradient start color
 - gradient end color
 - separator line volor

 */
@interface PrettyTabBar : UITabBar

/** Specifies the navigation bar upwards shadow's opacity.
 
 By default is `0.5`. */
@property (nonatomic, assign) float upwardsShadowOpacity;

/** Specifies the navigation bar downwards shadow's opacity.
 
 By default is `0.5`. */
@property (nonatomic, assign) float downwardsShadowOpacity;

/** Specifies the gradient's start color.
 
 By default is a black tone. */
@property (nonatomic, retain) UIColor *gradientStartColor;

/** Specifies the gradient's end color.
 
 By default is a black tone. */
@property (nonatomic, retain) UIColor *gradientEndColor;

/** Specifies the top separator's color.
 
 By default is a black tone. */
@property (nonatomic, retain) UIColor *separatorLineColor;

/////////////////////////////////////////////////////////////////////////////
// Pretty Tab Bar Button Implementation & Customization
/////////////////////////////////////////////////////////////////////////////

/** Specifies that PrettyTabBarButtons should be used instead of the default UITabBarButtons
 
 By default is NO. */
@property (nonatomic) BOOL prettyTabBarButtons;

/** Specifies that images to display when a button is selected.
 Use [NSNull null] if that particular button should use the gradient tints specified.
 Otherwise supply a UIImage of the appropriate size.
 
 Images must be added at the same index that the relevant UITabBarItem's index
 
 By default is `nil`. */
@property (nonatomic, copy) NSArray *prettyButtonHighlightedImages;

/** Specifies the start color for the gradient tint over the image when selected
 
 By default is `[UIColor colorWithRed:0.276 green:0.733 blue:1.000 alpha:1.000]`. */
@property (nonatomic, retain) UIColor *prettyButtonHighlightedImageGradientStartColor;

/** Specifies the end color for the gradient tint over the image when selected
 
 By default is `[UIColor colorWithRed:0.028 green:0.160 blue:0.332 alpha:1.000]`. */
@property (nonatomic, retain) UIColor *prettyButtonHighlightedImageGradientEndColor;

/** Specifies the font to use for the title of the button
 
 By default is `[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]`. */
@property (nonatomic, retain) UIFont *prettyButtonTitleFont;

/** Specifies the color for the title of the button
 
 By default is `[UIColor colorWithWhite:0.2 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *prettyButtonTitleTextColor;

/** Specifies the color for the title of the button when its been selected
 
 By default is `[UIColor colorWithWhite:0.90 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *prettyButtonTitleHighlightedTextColor;

/** Specifies the opacity of the title's shadow
 
 By default is `0.5`. */
@property (nonatomic) CGFloat prettyButtonTitleTextShadowOpacity;

/** Specifies the offset for the title's shadow
 
 By default is `CGSizeMake(0,-1)`. */
@property (nonatomic) CGSize prettyButtonTitleTextShadowOffset;

/** Specifies the start color for the highlight's gradient (when selected)
 
 By default is `[UIColor colorWithWhite:0.4 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *prettyButtonHighlightGradientStartColor;

/** Specifies the end color for the highlight's gradient (when selected)
 
 By default is `[UIColor colorWithWhite:0.1 alpha:1.0]`. */
@property (nonatomic, retain) UIColor *prettyButtonHighlightGradientEndColor;

/** Specifies the image to use in place of the highlight gradient.
 
 By default is `nil`. */
@property (nonatomic, retain) UIImage *prettyButtonHighlightImage;

/** Specifies the border color for the badge
 
 By default is `[UIColor whiteColor]`. */
@property (nonatomic, retain) UIColor *prettyButtonBadgeBorderColor;

/** Specifies the start color for the badge's gradient
 
 By default is `[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:1.000]`. */
@property (nonatomic, retain) UIColor *prettyButtonBadgeGradientStartColor;

/** Specifies the end color for the badge's gradient
 
 By default is `[UIColor colorWithRed:0.6 green:0.000 blue:0.000 alpha:1.000]`. */
@property (nonatomic, retain) UIColor *prettyButtonBadgeGradientEndColor;

/** Specifies the shadow opacity for the badge
 
 By default is `0.75`. */
@property (nonatomic) CGFloat prettyButtonBadgeShadowOpacity;

/** Specifies the shadow offset for the badge
 
 By default is `CGSizeMake(0,2)`. */
@property (nonatomic) CGSize prettyButtonBadgeShadowOffset;

/** Specifies the font used for the value of the badge
 
 By default is `[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]`. */
@property (nonatomic, retain) UIFont *prettyButtonBadgeFont;

/** Specifies the color used for the text in the badge's value
 
 By default is `[UIColor whiteColor]`. */
@property (nonatomic, retain) UIColor *prettyButtonBadgeTextColor;

@end
