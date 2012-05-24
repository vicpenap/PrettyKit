//
//  PrettyDrawnCell.h
//  PrettyExample
//
//  Created by Víctor on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyTableViewCell.h"

@interface PrettyDrawnCell : PrettyTableViewCell

@property (nonatomic, assign) float imageRadius;
@property (nonatomic, assign) BOOL imageShadow;

@property (nonatomic, readonly) UILabel *prettyTextLabel;
@property (nonatomic, readonly) UILabel *prettyDetailTextLabel;
@property (nonatomic, retain) UIImage *prettyImage;

+ (CGFloat) neededHeightForWidth:(float)width 
                      imageWidth:(float)imageWidth 
                            text:(NSString *)text
                        textFont:(UIFont *)textFont
                      detailText:(NSString *)detailText
                  detailTextFont:(UIFont *)detailTextFont;


@end
