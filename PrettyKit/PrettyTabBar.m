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

#define default_upwards_shadow_opacity      0.5
#define default_downwards_shadow_opacity    0.5
#define default_gradient_start_color        [UIColor colorWithHex:0x444444]
#define default_gradient_end_color          [UIColor colorWithHex:0x060606]
#define default_separator_line_color        [UIColor colorWithHex:0x666666]

@interface PrettyTabBar (/* Private Methods */)
@property (nonatomic, retain) NSMutableArray *_prettyTabBarButtons;
@property (nonatomic, retain) NSMutableArray *_originalTabBarButtons;
-(void)_prettyTabButtonTapped:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation PrettyTabBar
@synthesize upwardsShadowOpacity, downwardsShadowOpacity, gradientStartColor, gradientEndColor, separatorLineColor;
@synthesize prettyTabBarButtons = _prettyTabBarItems;

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
    
    __prettyTabBarButtons = [[NSMutableArray arrayWithCapacity:5] retain];
    __originalTabBarButtons = [[NSMutableArray arrayWithCapacity:0] retain];
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

#pragma mark - Overrides to handle internal PrettyTabBarButton if mode is set

-(void)setPrettyTabBarItems:(BOOL)prettyTabBarItems {
   
    _prettyTabBarItems = prettyTabBarItems;
    
    for (UIView *view in __originalTabBarButtons) {
        [self addSubview:view];
    }
    
    [__originalTabBarButtons removeAllObjects];
    
    [self setNeedsLayout];
}

-(void)setSelectedItem:(UITabBarItem *)selectedItem {
    if (self.prettyTabBarButtons) {
        // do stuff
        NSInteger index = [self.items indexOfObject:selectedItem];
        
        for (int i=0;i<[__prettyTabBarButtons count];i++) {
            if (i == index) {
                ((PrettyTabBarButton *)[__prettyTabBarButtons objectAtIndex:i]).selected = YES;
            } else {
                ((PrettyTabBarButton *)[__prettyTabBarButtons objectAtIndex:i]).selected = NO;
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
            [self.delegate tabBar:self didSelectItem:[self.items objectAtIndex:index]];
        }
        
    } else {
        [super setSelectedItem:selectedItem];
    }
    
}

-(void)_prettyTabButtonTapped:(UIGestureRecognizer *)gestureRecognizer {
    NSInteger index = gestureRecognizer.view.tag;
    [self setSelectedItem:[self.items objectAtIndex:index]];        
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
            
            UITapGestureRecognizer *tappedButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_prettyTabButtonTapped:)];
            tappedButton.numberOfTapsRequired = 1;
            [button addGestureRecognizer:tappedButton];
            [tappedButton release];
            
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
