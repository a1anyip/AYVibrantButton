//
//  AYVibrantButton.m
//  AYVibrantButton
//
//  http://github.com/a1anyip/AYVibrantButton
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Alan Yip
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "AYVibrantButton.h"

#define kAYVibrantButtonDefaultAnimationInterval 0.15
#define kAYVibrantButtonDefaultTranslucencyAlpha 0.6
#define kAYVibrantButtonDefaultCornerRadius 4.0
#define kAYVibrantButtonDefaultBorderWidth 0.6
#define kAYVibrantButtonDefaultFontSize 14.0
#define kAYVibrantButtonDefaultBackgroundColor [UIColor whiteColor]

@interface AYVibrantButton () {
	
	__strong UIColor *_backgroundColor;
}

@property (nonatomic, assign) AYVibrantButtonStyle style;

#ifdef __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
#endif

@property (nonatomic, strong) AYVibrantButtonOverlay *normalOverlay;
@property (nonatomic, strong) AYVibrantButtonOverlay *highlightedOverlay;

- (void)createOverlays;

@end

@implementation AYVibrantButton

- (instancetype)init {
	NSLog(@"AYVibrantButton must be initialized with initWithFrame:style:");
	return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
	NSLog(@"AYVibrantButton must be initialized with initWithFrame:style:");
	return nil;
}

- (instancetype)initWithFrame:(CGRect)frame style:(AYVibrantButtonStyle)style {
	if (self = [super initWithFrame:frame]) {
		
		self.style = style;
		self.opaque = NO;
		self.userInteractionEnabled = YES;
		
		// default values
		_animated = YES;
		_animationInterval = kAYVibrantButtonDefaultAnimationInterval;
		_cornerRadius = kAYVibrantButtonDefaultCornerRadius;
		_borderWidth = kAYVibrantButtonDefaultBorderWidth;
		_translucencyAlpha = kAYVibrantButtonDefaultTranslucencyAlpha;
		
		// create overlay views
		[self createOverlays];
		
#ifdef __IPHONE_8_0
		// add the default vibrancy effect
		self.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
#endif
		
		[self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragInside];
		[self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchCancel];
	}
	return self;
}

- (void)layoutSubviews {
#ifdef __IPHONE_8_0
	self.visualEffectView.frame = self.bounds;
#endif
	self.normalOverlay.frame = self.bounds;
	self.highlightedOverlay.frame = self.bounds;
}

- (void)createOverlays {
	
	self.normalOverlay = [[AYVibrantButtonOverlay alloc] initWithStyle:AYVibrantButtonOverlayStyleNormal];
	
	if (self.style == AYVibrantButtonStyleInvert) {
		self.highlightedOverlay = [[AYVibrantButtonOverlay alloc] initWithStyle:AYVibrantButtonOverlayStyleInvert];
		self.highlightedOverlay.alpha = 0.0;
	} else if (self.style == AYVibrantButtonStyleTranslucent) {
		self.normalOverlay.alpha = self.translucencyAlpha;
	}
	
#ifndef __IPHONE_8_0
	// for iOS 8, these two overlay views will be added as subviews in setVibrancyEffect:
	[self addSubview:self.normalOverlay];
	[self addSubview:self.highlightedOverlay];
#endif

}

#pragma mark - Control Event Handlers

- (void)touchDown {
	
	void(^update)(void) = ^(void) {
		if (self.style == AYVibrantButtonStyleInvert) {
			self.normalOverlay.alpha = 0.0;
			self.highlightedOverlay.alpha = 1.0;
		} else if (self.style == AYVibrantButtonStyleTranslucent) {
			self.normalOverlay.alpha = 1.0;
		}
	};
	
	if (self.animated) {
		[UIView animateWithDuration:self.animationInterval animations:update];
	} else {
		update();
	}
}

- (void)touchUp {
	
	void(^update)(void) = ^(void) {
		if (self.style == AYVibrantButtonStyleInvert) {
			self.normalOverlay.alpha = 1.0;
			self.highlightedOverlay.alpha = 0.0;
		} else if (self.style == AYVibrantButtonStyleTranslucent) {
			self.normalOverlay.alpha = self.translucencyAlpha;
		}
	};
	
	if (self.animated) {
		[UIView animateWithDuration:self.animationInterval animations:update];
	} else {
		update();
	}
}

#pragma mark - Override Getters

- (UIColor *)backgroundColor {
	return _backgroundColor == nil ? kAYVibrantButtonDefaultBackgroundColor : _backgroundColor;
}

#pragma mark - Override Setters

- (void)setCornerRadius:(CGFloat)cornerRadius {
	self.normalOverlay.cornerRadius = cornerRadius;
	self.highlightedOverlay.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	self.normalOverlay.borderWidth = borderWidth;
	self.highlightedOverlay.borderWidth = borderWidth;
}

- (void)setText:(NSString *)text {
	self.normalOverlay.text = text;
	self.highlightedOverlay.text = text;
}

- (void)setFont:(UIFont *)font {
	self.normalOverlay.font = font;
	self.highlightedOverlay.font = font;
}

#ifdef __IPHONE_8_0
- (void)setVibrancyEffect:(UIVibrancyEffect *)vibrancyEffect {
	
	[self.normalOverlay removeFromSuperview];
	[self.highlightedOverlay removeFromSuperview];
	[self.visualEffectView removeFromSuperview];
	
	if (vibrancyEffect != nil) {
		self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
		self.visualEffectView.userInteractionEnabled = NO;
		[self.visualEffectView.contentView addSubview:self.normalOverlay];
		[self.visualEffectView.contentView addSubview:self.highlightedOverlay];
		[self addSubview:self.visualEffectView];
	} else {
		[self addSubview:self.normalOverlay];
		[self addSubview:self.highlightedOverlay];
	}
}
#endif

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	self.normalOverlay.backgroundColor = backgroundColor;
	self.highlightedOverlay.backgroundColor = backgroundColor;
}

@end

@interface AYVibrantButtonOverlay () {
	
	__strong UIFont *_font;
	__strong UIColor *_backgroundColor;
}

@property (nonatomic, assign) AYVibrantButtonOverlayStyle style;
@property (nonatomic, assign) CGFloat textHeight;

- (void)_updateTextHeight;

@end

@implementation AYVibrantButtonOverlay

- (instancetype)initWithStyle:(AYVibrantButtonOverlayStyle)style {
	if (self = [self init]) {
		self.style = style;
	}
	return self;
}

- (instancetype)init {
	if (self = [super init]) {
		
		_cornerRadius = kAYVibrantButtonDefaultCornerRadius;
		_borderWidth = kAYVibrantButtonDefaultBorderWidth;
		
		self.opaque = NO;
		self.userInteractionEnabled = NO;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	
	[super drawRect:rect];
	
	if (self.bounds.size.width == 0 || self.bounds.size.height == 0) return;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, self.bounds);
	
	// draw background and border
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth) cornerRadius:self.cornerRadius];
	path.lineWidth = self.borderWidth;
	[self.backgroundColor setStroke];
	[path stroke];
	
	if (self.style == AYVibrantButtonOverlayStyleInvert) {
		// fill the rounded rectangle area
		[self.backgroundColor setFill];
		[path fill];
	}
	
	// draw text
	if (self.text != nil) {
		
		NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		style.lineBreakMode = NSLineBreakByTruncatingTail;
		style.alignment = NSTextAlignmentCenter;
		
		if (self.style == AYVibrantButtonOverlayStyleInvert) {
			// this will make the drawInRect method below clear the text area
			CGContextSetBlendMode(context, kCGBlendModeClear);
		}
		
		[self.text drawInRect:CGRectMake(0.0, (self.bounds.size.height - self.textHeight) / 2, self.bounds.size.width, self.textHeight) withAttributes:@{ NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.backgroundColor, NSParagraphStyleAttributeName:style }];
	}
}

#pragma mark - Override Getters

- (UIFont *)font {
	if (_font == nil) _font = [UIFont systemFontOfSize:kAYVibrantButtonDefaultFontSize];
	return _font;
}

- (UIColor *)backgroundColor {
	return _backgroundColor == nil ? kAYVibrantButtonDefaultBackgroundColor : _backgroundColor;
}

#pragma mark - Override Setters

- (void)setCornerRadius:(CGFloat)cornerRadius {
	_cornerRadius = cornerRadius;
	[self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	_borderWidth = borderWidth;
	[self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
	_text = text;
	[self _updateTextHeight];
	[self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
	_font = font;
	[self _updateTextHeight];
	[self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	_backgroundColor = backgroundColor;
	[self setNeedsDisplay];
}

#pragma mark - Private Methods

- (void)_updateTextHeight {
	CGRect bounds = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:self.font } context:nil];
	self.textHeight = bounds.size.height;
}

@end
