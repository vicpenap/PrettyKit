//
//  PrettyToolbar.h
//  PrettyExample
//
//  Created by Seth Gholson on 4/25/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

/** `PrettyToolbar` is a subclass of `UIToolbar` that removes the
 glossy effect and lets you customize its colors.
 
 You can change the toolbar appearance as follows:
 
 - shadow opacity
 - gradient start color
 - gradient end color
 - top line volor
 - bottom line color
*/

@interface PrettyToolbar : UIToolbar

/** Specifies the toolbar shadow's opacity.
 
 By default is `0.5`. */
@property (nonatomic, assign) float shadowOpacity;

/** Specifies the gradient's start color.
 
 By default is a blue tone. */
@property (nonatomic, retain) UIColor *gradientStartColor;

/** Specifies the gradient's end color.
 
 By default is a blue tone. */
@property (nonatomic, retain) UIColor *gradientEndColor;

/** Specifies the gradient's top line color.
 
 By default is a blue tone. */
@property (nonatomic, retain) UIColor *topLineColor;

/** Specifies the gradient's bottom line color.
 
 By default is a blue tone. */
@property (nonatomic, retain) UIColor *bottomLineColor;

@end
