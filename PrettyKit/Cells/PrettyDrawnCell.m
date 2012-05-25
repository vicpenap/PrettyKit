//
//  PrettyDrawnCell.m
//  PrettyExample
//
//  Created by Víctor on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrettyDrawnCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PrettyDrawing.h"

#define VIEW_TAG 1234

#define image_margin 10
#define deselection_delay 0
#define deselection_animation 0.5
#define shadow_width 2

@implementation PrettyDrawnCellThumbnail
@synthesize shown, size, drawBlock;

- (void) dealloc
{
    self.drawBlock = nil;
    
    [super dealloc];
}

@end



@interface PrettyDrawnCell ()

- (BOOL) showsImage;
- (CGSize) imageSize;

@end


@interface CellSubview : UIView

@property (nonatomic, retain) PrettyDrawnCell *cell;

@end

@implementation CellSubview
@synthesize cell;

- (void)dealloc {
    self.cell = nil;
    
    [super dealloc];
}

- (float) drawLabel:(UILabel *)label
               rect:(CGRect)rect
             height:(float)height
      lineBreakMode:(UILineBreakMode)mode
{
    if (self.cell.selected || self.cell.highlighted) 
    {
        [[UIColor whiteColor] set];
    }
    else {
        [label.textColor set];
    }
    
    float width = rect.size.width;
    if ([self.cell showsImage])
    {
        width -= [self.cell imageSize].width + image_margin * 2;
    }
    CGSize constrainedSize = CGSizeMake(width, self.frame.size.height);
    CGSize neededSize = [label.text sizeWithFont:label.font constrainedToSize:constrainedSize lineBreakMode:mode];
    CGRect textRect = CGRectMake([self.cell showsImage] ? [self.cell imageSize].width + image_margin + shadow_width*2 : 0,
                                 image_margin + height,
                                 neededSize.width, neededSize.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetShadowWithColor(ctx, label.shadowOffset, 1, label.shadowColor.CGColor);
    [label.text drawInRect:textRect withFont:label.font lineBreakMode:mode alignment:UITextAlignmentLeft];
    CGContextRestoreGState(ctx);

    return neededSize.height + height;
}


- (CGFloat) drawTextLabel:(CGRect)rect height:(CGFloat)height
{
    return [self drawLabel:self.cell.prettyTextLabel rect:rect height:height lineBreakMode:UILineBreakModeClip];
}

- (CGFloat) drawDetailTextLabel:(CGRect)rect height:(CGFloat)height
{
    return [self drawLabel:self.cell.prettyDetailTextLabel rect:rect height:height lineBreakMode:UILineBreakModeClip];
}


- (UIImage *) drawRoundedImage:(UIImage *)image rect:(CGRect)rect
{
    UIImage *newImage;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect 
                                cornerRadius:self.cell.prettyImageRadius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) drawImage
{
    CGRect rect = CGRectMake(shadow_width, image_margin + shadow_width, [self.cell imageSize].width, [self.cell imageSize].height);

    if (!self.cell.prettyImage || self.cell.prettyImageShadow)
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:UIRectCornerAllCorners 
                                                         cornerRadii:CGSizeMake(self.cell.prettyImageRadius, self.cell.prettyImageRadius)];
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGContextAddPath(ctx, path.CGPath);
        
        if (self.cell.selected || self.cell.highlighted) 
        {
            [[UIColor whiteColor] set];
        }
        else {
            [[UIColor lightGrayColor] set];
        }
        if (self.cell.prettyImageShadow) 
        {
            CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 3, [UIColor blackColor].CGColor);
        }
        CGContextStrokePath(ctx);        
        CGContextRestoreGState(ctx);        
    }


    
    if ([self.cell showsImage])
    {
        CGRect roundedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
        UIImage *image = [self drawRoundedImage:self.cell.prettyImage rect:roundedRect];
        [image drawInRect:rect];
    }
}

- (void) drawBackground:(CGRect)rect
{
    if (self.cell.gradientStartColor && self.cell.gradientEndColor
        && !self.cell.selected && !self.cell.highlighted) 
    {
        CGGradientRef gradient = [self.cell createNormalGradient];
        [PrettyDrawing drawGradient:gradient rect:rect];
    }
}



- (void) drawRect:(CGRect)rect
{
    [self drawBackground:rect];
    
    float height = 0;
    height = [self drawTextLabel:rect height:height];
    [self drawDetailTextLabel:rect height:height];    
    
    if ([self.cell showsImage])
    {
        [self drawImage];
    }
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end



@implementation PrettyDrawnCell
@synthesize prettyImageRadius, prettyImageShadow;
@synthesize prettyTextLabel;
@synthesize prettyDetailTextLabel;
@synthesize prettyImage;
@synthesize prettyThumbnail;

- (BOOL) showsImage
{
    return self.prettyImage || self.prettyThumbnail.shown;
}

- (CGSize) imageSize
{
    if (![self showsImage])
    {
        return CGSizeZero;
    }
    
    if (self.prettyImage)
    {
        return self.prettyImage.size;
    }
    
    return self.prettyThumbnail.size;
}

- (void)dealloc 
{
    self.prettyImage = nil;
    if (prettyDetailTextLabel != nil) {
        [prettyDetailTextLabel release];
        prettyDetailTextLabel = nil;
    }
    if (prettyTextLabel != nil) {
        [prettyTextLabel release];
        prettyTextLabel = nil;
    }
    if (prettyThumbnail != nil) {
        [prettyThumbnail release];
        prettyThumbnail = nil;
    }
    [self.contentView removeObserver:self forKeyPath:@"frame"];
    
    [super dealloc];
}

- (void)setSubview
{
    // Initialization code
    CellSubview *subview = [[CellSubview alloc] initWithFrame:CGRectZero];
    subview.tag = VIEW_TAG;
    subview.contentMode = UIViewContentModeRedraw;
    subview.cell = self;
    [self.contentView addSubview:subview];
    [self.contentView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
    [subview release];
}

- (void) setCustomBackgroundColor:(UIColor *)customBackgroundColor
{
    [super setCustomBackgroundColor:customBackgroundColor];
    
    [[self.contentView viewWithTag:VIEW_TAG] setBackgroundColor:customBackgroundColor];
}

- (void) setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    [[self.contentView viewWithTag:VIEW_TAG] setBackgroundColor:backgroundColor];
}

- (void) setLabels
{
    prettyTextLabel = [[UILabel alloc] init];
    self.prettyTextLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    self.prettyTextLabel.textColor = [UIColor darkTextColor];
    prettyDetailTextLabel = [[UILabel alloc] init];
    self.prettyDetailTextLabel.font = [UIFont systemFontOfSize:15];
    self.prettyDetailTextLabel.textColor = [UIColor grayColor];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubview];
        [self setLabels];
        prettyThumbnail = [[PrettyDrawnCellThumbnail alloc] init];
    }
    return self;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    
    [[self.contentView viewWithTag:VIEW_TAG] setNeedsDisplay];
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"frame" isEqualToString:keyPath]) 
    {
        CGRect frame = self.innerFrame;
        // leave room for the corners
        float widthDiff = (self.cornerRadius < 8 ? 8 : self.cornerRadius)*2;
        frame.size.width -= widthDiff;
        if (self.tableViewStyle == UITableViewStylePlain)
        {
            frame.origin.x += widthDiff/2; 
        }
        
        // leave room for top and/or bottom lines
        frame.size.height--;
        
        [[self.contentView viewWithTag:VIEW_TAG] setFrame:frame];
        return;
    }
}

- (UIImage *) renderSelectionImage 
{
    // http://stackoverflow.com/questions/4965036/uigraphicsgetimagefromcurrentimagecontext-retina-resolution
    
    CGSize size = self.frame.size;

    
    UIGraphicsBeginImageContextWithOptions(size,YES,0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.isSelected && !selected && animated) 
    {
        // transition from selected to unselected
        UIImageView *selectedContentView = [[UIImageView alloc] initWithFrame:self.bounds];
        selectedContentView.image = [self renderSelectionImage];
        [self addSubview:selectedContentView];
        
        [UIView animateWithDuration:deselection_animation 
                              delay:deselection_delay
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             selectedContentView.alpha = 0;
                         } 
                         completion:^(BOOL finished) {
                             [selectedContentView removeFromSuperview];
                         }];
        
        [selectedContentView release];
    }
    
    [super setSelected:selected animated:NO];
}

+ (CGFloat) neededHeightForWidth:(float)width 
                       imageSize:(CGSize)imageSize 
                            text:(NSString *)text
                        textFont:(UIFont *)textFont
                      detailText:(NSString *)detailText
                  detailTextFont:(UIFont *)detailTextFont
{
    float minHeight = image_margin*2 + shadow_width*2;
    float height = minHeight;
    float realWidth = width - imageSize.width - (imageSize.width ? image_margin*3 + shadow_width*2 : 0);
    
    CGSize maxSize = CGSizeMake(realWidth, MAXFLOAT);
    
    CGSize neededSize = [text sizeWithFont:textFont
                         constrainedToSize:maxSize
                             lineBreakMode:UILineBreakModeClip];
    height += neededSize.height;
    
    neededSize = [detailText sizeWithFont:detailTextFont
                        constrainedToSize:maxSize
                            lineBreakMode:UILineBreakModeClip];
    height += neededSize.height;
    
    float minImageHeight = imageSize.height + minHeight; // image is expected to be squared
    
    return height < minImageHeight ? minImageHeight : height;
}


@end
