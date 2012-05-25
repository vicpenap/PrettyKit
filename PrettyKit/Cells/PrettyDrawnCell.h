//
//  PrettyDrawnCell.h
//  PrettyExample
//
//  Created by Víctor on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyTableViewCell.h"

@interface PrettyDrawnCellThumbnail : NSObject

@property (nonatomic, assign) BOOL shown;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, copy) void (^drawBlock)(void);

@end





@interface PrettyDrawnCell : PrettyTableViewCell

@property (nonatomic, assign) float prettyImageRadius;
@property (nonatomic, assign) BOOL prettyImageShadow;

@property (nonatomic, readonly) UILabel *prettyTextLabel;
@property (nonatomic, readonly) UILabel *prettyDetailTextLabel;
@property (nonatomic, retain) UIImage *prettyImage;

@property (nonatomic, readonly) PrettyDrawnCellThumbnail *prettyThumbnail;

+ (CGFloat) neededHeightForWidth:(float)width 
                       imageSize:(CGSize)imageSize 
                            text:(NSString *)text
                        textFont:(UIFont *)textFont
                      detailText:(NSString *)detailText
                  detailTextFont:(UIFont *)detailTextFont;

@end




