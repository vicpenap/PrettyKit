//
//  PrettyTabBar.m
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


#import "PrettyTabBar.h"
#import "PrettyDrawing.h"
#import "PrettyTabBarButton.h"

#define default_upwards_shadow_opacity          0.5
#define default_downwards_shadow_opacity        0.5
#define default_gradient_start_color            [UIColor colorWithHex:0x444444]
#define default_gradient_end_color              [UIColor colorWithHex:0x060606]
#define default_separator_line_color            [UIColor colorWithHex:0x666666]

#define default_text_shadow_offset              CGSizeMake(0,-1)
#define default_text_shadow_opacity             0.5
#define default_font                            [UIFont fontWithName:@"HelveticaNeue-Bold" size:10]
#define default_text_color                      [UIColor colorWithWhite:0.2 alpha:1.0]
#define default_highlighted_text_color          [UIColor colorWithWhite:0.90 alpha:1.0]
#define default_badge_font                      [UIFont fontWithName:@"HelveticaNeue-Bold" size:11]
#define default_badge_gradient_start_color      [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:1.000]
#define default_badge_gradient_end_color        [UIColor colorWithRed:0.6 green:0.000 blue:0.000 alpha:1.000]
#define default_badge_border_color              [UIColor whiteColor]
#define default_badge_shadow_opacity            0.75
#define default_badge_shadow_offset             CGSizeMake(0,2)
#define default_badge_text_color                [UIColor whiteColor]
#define default_highlight_gradient_start_color  [UIColor colorWithWhite:0.4 alpha:1.0] 
#define default_highlight_gradient_end_color    [UIColor colorWithWhite:0.1 alpha:1.0]

@interface PrettyTabBar (/* Private Methods */)
@property (nonatomic, retain) NSMutableArray *_prettyTabBarButtons;
@property (nonatomic, retain) NSMutableArray *_originalTabBarButtons;
-(void)_prettyTabBarButtonTapped:(id)sender;
@end

@implementation PrettyTabBar
@synthesize upwardsShadowOpacity, downwardsShadowOpacity, gradientStartColor, gradientEndColor, separatorLineColor;
@synthesize prettyTabBarButtons = _prettyTabBarButtons;

@synthesize prettyButtonTitleFont, prettyButtonTitleTextColor, prettyButtonTitleHighlightedTextColor, prettyButtonTitleTextShadowOpacity, prettyButtonTitleTextShadowOffset;
@synthesize prettyButtonHighlightGradientStartColor, prettyButtonHighlightGradientEndColor, prettyButtonHighlightImage;
@synthesize prettyButtonBadgeBorderColor, prettyButtonBadgeGradientStartColor, prettyButtonBadgeGradientEndColor, prettyButtonBadgeShadowOpacity, prettyButtonBadgeShadowOffset, prettyButtonBadgeFont, prettyButtonBadgeTextColor;

@synthesize _prettyTabBarButtons = __prettyTabBarButtons, _originalTabBarButtons = __originalTabBarButtons;

#pragma mark - Object Life Cycle

- (void) dealloc {
    self.gradientStartColor = nil;
    self.gradientEndColor = nil;
    self.separatorLineColor = nil;
    
    self._originalTabBarButtons = nil;
    self._prettyTabBarButtons = nil;
    
    [super dealloc];
}

- (void) initializeVars 
{
    self.contentMode = UIViewContentModeRedraw;

    self.prettyTabBarButtons = NO;
    
    self.upwardsShadowOpacity = default_upwards_shadow_opacity;
    self.downwardsShadowOpacity = default_downwards_shadow_opacity;
    self.gradientStartColor = default_gradient_start_color;
    self.gradientEndColor = default_gradient_end_color;
    self.separatorLineColor = default_separator_line_color;
    
    // pretty button stuff
    __prettyTabBarButtons = [[NSMutableArray arrayWithCapacity:5] retain];
    __originalTabBarButtons = [[NSMutableArray arrayWithCapacity:0] retain];
    
    self.prettyButtonTitleFont = default_font;
    self.prettyButtonTitleTextColor = default_text_color;
    self.prettyButtonTitleHighlightedTextColor = default_highlighted_text_color;
    self.prettyButtonTitleTextShadowOpacity = default_text_shadow_opacity;
    self.prettyButtonTitleTextShadowOffset = default_text_shadow_offset;
    self.prettyButtonBadgeBorderColor = default_badge_border_color;
    self.prettyButtonBadgeGradientStartColor = default_badge_gradient_start_color;
    self.prettyButtonBadgeGradientEndColor = default_badge_gradient_end_color;
    self.prettyButtonBadgeShadowOffset = default_badge_shadow_offset;
    self.prettyButtonBadgeShadowOpacity = default_badge_shadow_opacity;
    self.prettyButtonBadgeFont = default_badge_font;
    self.prettyButtonBadgeTextColor = default_badge_text_color;
    self.prettyButtonHighlightImage = nil;
    self.prettyButtonHighlightGradientStartColor = default_highlight_gradient_start_color;
    self.prettyButtonHighlightGradientEndColor = default_highlight_gradient_end_color;
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

#pragma mark - Overrides to handle internal PrettyTabBarButton

-(void)setPrettyTabBarButtons:(BOOL)prettyTabBarButtons {
    _prettyTabBarButtons = prettyTabBarButtons;
    
    if (self.superview)
        [self setNeedsLayout];
}

-(void)_prettyTabBarButtonTapped:(id)sender {
    if (self.prettyTabBarButtons) {
        for (PrettyTabBarButton *button in __prettyTabBarButtons) {
            button.selected = NO;
        }
        
        ((PrettyTabBarButton *)sender).selected = YES;
        
        if ([sender isKindOfClass:[PrettyTabBarButton class]]) {
            if ([self.delegate isKindOfClass:[UITabBarController class]]) {
                [((UITabBarController *)self.delegate) setSelectedIndex:((PrettyTabBarButton *)sender).tag];
            }
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (([keyPath isEqualToString:@"badgeValue"]) && (self.prettyTabBarButtons)) {
        UITabBarItem *item = (UITabBarItem *)context;
        NSUInteger index = [self.items indexOfObject:item];
        
        [[self._prettyTabBarButtons objectAtIndex:index] setBadgeValue:[change objectForKey:NSKeyValueChangeNewKey]];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];    
    }
}

#pragma mark - Display
-(void)layoutSubviews {
    
    if (!self.prettyTabBarButtons) {
        for (UIView *view in __originalTabBarButtons) {
            [self addSubview:view];
        }
        
        [__originalTabBarButtons removeAllObjects];
    }

    [super layoutSubviews];

    if ([self.items count] > 5)
        self.prettyTabBarButtons = NO;

    for (UIView *view in self.subviews) {

        if (self.prettyTabBarButtons) {
            if (![view isKindOfClass:[PrettyTabBarButton class]]) {
                [__originalTabBarButtons addObject:view];
            }            
            [view removeFromSuperview];
        } else {
            if ([view isKindOfClass:[PrettyTabBarButton class]]) {
                [view removeFromSuperview];
            }
        }
    }
            
    if (self.prettyTabBarButtons) {
        [__prettyTabBarButtons removeAllObjects];

        // do stuff
        PrettyTabBarButton *button = nil;
        UITabBarItem *item = nil;
        
        CGFloat itemWidth = self.frame.size.width/[self.items count];
        
        for (int i=0;i<[self.items count];i++) {
            item = [self.items objectAtIndex:i];
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:item];
            
            button = [[PrettyTabBarButton alloc] initWithTitle:item.title image:item.image tag:i];
            button.frame = CGRectMake(i * itemWidth, 0, itemWidth, self.frame.size.height);
            button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            button.badgeValue = item.badgeValue;
            [button addTarget:self action:@selector(_prettyTabBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            // set button properties
            button.font = self.prettyButtonTitleFont;
            button.textColor =self.prettyButtonTitleTextColor;
            button.highlightedTextColor =self.prettyButtonTitleHighlightedTextColor;
            button.textShadowOpacity =self.prettyButtonTitleTextShadowOpacity;
            button.textShadowOffset =self.prettyButtonTitleTextShadowOffset;
            button.badgeBorderColor =self.prettyButtonBadgeBorderColor;
            button.badgeGradientStartColor =self.prettyButtonBadgeGradientStartColor;
            button.badgeGradientEndColor =self.prettyButtonBadgeGradientEndColor;
            button.badgeShadowOffset =self.prettyButtonBadgeShadowOffset;
            button.badgeShadowOpacity =self.prettyButtonBadgeShadowOpacity;
            button.badgeFont =self.prettyButtonBadgeFont;
            button.badgeTextColor =self.prettyButtonBadgeTextColor;
            button.highlightImage =self.prettyButtonHighlightImage;
            button.highlightGradientStartColor =self.prettyButtonHighlightGradientStartColor;
            button.highlightGradientEndColor =self.prettyButtonHighlightGradientEndColor;
            
            if (item == self.selectedItem) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
            
            [self addSubview:button];
            [__prettyTabBarButtons addObject:button];
            [button release];
        }
    }
    
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (self.upwardsShadowOpacity > 0)
        [self dropShadowOffset:CGSizeMake(0, -1) withOpacity:self.upwardsShadowOpacity];
    
    if (self.downwardsShadowOpacity > 0)
        [self dropShadowOffset:CGSizeMake(0, 0) withOpacity:self.downwardsShadowOpacity];
    
    [PrettyDrawing drawGradient:rect fromColor:self.gradientStartColor toColor:self.gradientEndColor];
    [PrettyDrawing drawLineAtHeight:0.5 rect:rect color:self.separatorLineColor width:2.5];
}

@end
