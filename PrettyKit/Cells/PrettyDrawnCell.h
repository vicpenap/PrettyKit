//
//  PrettyDrawnCell.h
//  PrettyExample
//
//  Created by Víctor on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyTableViewCell.h"

/** PrettyDrawnCellThumbnail holds setup information about the image's thumbnail
 on PrettyDrawnCell. */
@interface PrettyDrawnCellThumbnail : NSObject

/** This property indicates if the thumbnail should be shown when `prettyImage`
 property, on PrettyDrawnCell object, is nil. */
@property (nonatomic, assign) BOOL shown;

/** This property the thumbnail's size to be drawn when `prettyImage`
 property, on PrettyDrawnCell object, is nil. */
@property (nonatomic, assign) CGSize size;

@end




/** PrettyDrawnCell is a generic PrettyTableViewCell subclass that draws with
 CoreGraphics all its content. It mimics the UITableViewCellStyleSubtitle by 
 presenting a text, a gray text as subtitle, and, optionally, an image at left. */
@interface PrettyDrawnCell : PrettyTableViewCell

/** Indicates the image corner radius. 
 
 Default is 0. */
@property (nonatomic, assign) float prettyImageRadius;

/** Indicates whether the image should drop a shadow or not. 
 
 Default is NO. */
@property (nonatomic, assign) BOOL prettyImageShadow;

/** Returns the label used for the main textual content of the cell. (read-only)
 
 Default is similar to `UITableViewCell's.textLabel`. */
@property (nonatomic, readonly) UILabel *prettyTextLabel;

/** Returns the secondary label of the cell. (read-only)
 
 Default is similar to `UITableViewCell's.detailTextLabel`. */
@property (nonatomic, readonly) UILabel *prettyDetailTextLabel;

/** The image to use as content for the cell. 
 
 The default value of the property is `nil` (no image). Images are positioned 
 to the left of the title.
 */
@property (nonatomic, retain) UIImage *prettyImage;

/** Holds setup information about the image's thumbanil. */
@property (nonatomic, readonly) PrettyDrawnCellThumbnail *prettyThumbnail;


/** Returns the minimum needed height for a cell with the given parameters.
 
 This method takes into account all the information given and based on it,
 returns the needed height for a cell with that info. The number of lines
 configured in the text or detailText labels will not be taken into account.
 
 @param width expected cell width.
 @param imageSize expected image size.
 @param text expected cell text.
 @param textFontOrNil expected text font. If `nil`, default font will be used.
 @param detailText expected cell detail text.
 @param detailTextFontOrNil expected detail text font. If `nil`, default detail
 font will be used. */
+ (CGFloat) neededHeightForWidth:(float)width 
                       imageSize:(CGSize)imageSize 
                            text:(NSString *)text
                        textFont:(UIFont *)textFontOrNil
                      detailText:(NSString *)detailText
                  detailTextFont:(UIFont *)detailTextFontOrNil;

@end




