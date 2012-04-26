//
//  PrettyToolbar.m
//  PrettyExample
//
//  Created by Seth Gholson on 4/25/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "PrettyToolbar.h"
#import <QuartzCore/QuartzCore.h>
#import "PrettyDrawing.h"

@implementation PrettyToolbar
@synthesize shadowOpacity, gradientEndColor, gradientStartColor, topLineColor, bottomLineColor;

#define default_shadow_opacity 0.5
#define default_gradient_end_color      [UIColor colorWithHex:0x297CB7]
#define default_gradient_start_color    [UIColor colorWithHex:0x53A4DE]
#define default_top_line_color          [UIColor colorWithHex:0x84B7D5]
#define default_bottom_line_color       [UIColor colorWithHex:0x186399]
#define default_tint_color              [UIColor colorWithHex:0x3D89BF]

- (void)dealloc {
    self.gradientStartColor = nil;
    self.gradientEndColor = nil;
    self.topLineColor = nil;
    self.bottomLineColor = nil;
    
    [super dealloc];
}

- (void) initializeVars 
{
    self.contentMode = UIViewContentModeRedraw;
    self.shadowOpacity = default_shadow_opacity;
    self.gradientStartColor = default_gradient_start_color;
    self.gradientEndColor = default_gradient_end_color;
    self.topLineColor = default_top_line_color;
    self.bottomLineColor = default_bottom_line_color;
    self.tintColor = default_tint_color;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeVars];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeVars];
    }
    return self;
}


- (id)init {
    self = [super init];
    if (self) {
        [self initializeVars];
    }
    return self;
}



- (void) drawTopLine:(CGRect)rect {
    [PrettyDrawing drawLineAtPosition:LinePositionTop rect:rect color:self.topLineColor];
}


- (void) drawBottomLine:(CGRect)rect {
    [PrettyDrawing drawLineAtPosition:LinePositionBottom rect:rect color:self.bottomLineColor];
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self dropShadowWithOpacity:self.shadowOpacity];
    [PrettyDrawing drawGradient:rect fromColor:self.gradientStartColor toColor:self.gradientEndColor];
    [self drawTopLine:rect];        
    [self drawBottomLine:rect];
}

@end
