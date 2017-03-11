//
//  AYViewController.m
//  AYVibrantButton Example
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


#pragma mark - Imports

#import "AYViewController.h"


#pragma mark - Constants

// Name of the background image
static NSString * const backgroundImageName = @"background";

// Button font size
static const CGFloat fontSize = 18.0;


#pragma mark - AYViewController Class Extension

@interface AYViewController ()

// Displays a background image
@property (nonatomic) UIImageView *backgroundImageView;

// Visual effect view with dark blur effect, left side of view
@property (nonatomic) UIVisualEffectView *leftVisualEffectView;

// Visual effect view with light blur effect, right side of view
@property (nonatomic) UIVisualEffectView *rightVisualEffectView;

// Button with vibrancy effect, inverts style on selection
@property (nonatomic) AYVibrantButton *leftInvertVibrancyButton;

// Button with vibrancy effect, inverts style on selection
@property (nonatomic) AYVibrantButton *rightInvertVibrancyButton;

// Button with vibrancy effect, translucent style on selection
@property (nonatomic) AYVibrantButton *leftTranslucentVibrancyButton;

// Button with vibrancy effect, translucent style on selection
@property (nonatomic) AYVibrantButton *rightTranslucentVibrancyButton;

// Button with translucent effect, no vibrancy
@property (nonatomic) AYVibrantButton *leftTranslucentButton;

// Button with translucent effect, no vibrancy
@property (nonatomic) AYVibrantButton *rightTranslucentButton;

@end


#pragma mark - AYViewController Implementation

@implementation AYViewController
            
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:backgroundImageName]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    /**
     Left side of the view contains buttons over a a dark blur effect 
     */
    UIBlurEffect *leftBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.leftVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:leftBlurEffect];
    self.leftVisualEffectView.frame = CGRectMake(0.0, 0.0, 0.5 * CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    [self.view addSubview:self.leftVisualEffectView];
    
    // Invert vibrancy
    self.leftInvertVibrancyButton = ({
        AYVibrantButton *button = [[AYVibrantButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 128.0, 44.0) style:AYVibrantButtonStyleInvert];
        button.center = CGPointMake(0.25 * CGRectGetWidth(self.view.bounds), 0.25 * CGRectGetHeight(self.view.bounds));
        button.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:leftBlurEffect];
        button.font = [UIFont systemFontOfSize:fontSize];
        button.text = @"Invert";
        button;
    });
    [self.leftVisualEffectView.contentView addSubview:self.leftInvertVibrancyButton];
    
    // Translucent vibrancy
    self.leftTranslucentVibrancyButton = ({
        AYVibrantButton *button = [[AYVibrantButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 128.0, 44.0) style:AYVibrantButtonStyleTranslucent];
        button.center = CGPointMake(0.25 * CGRectGetWidth(self.view.bounds), 0.50 * CGRectGetHeight(self.view.bounds));
        button.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:leftBlurEffect];
        button.font = [UIFont systemFontOfSize:fontSize];
        button.text = @"Translucent";
        button;
    });
    [self.leftVisualEffectView.contentView addSubview:self.leftTranslucentVibrancyButton];
    
    // Translucent
    self.leftTranslucentButton = ({
        AYVibrantButton *button = [[AYVibrantButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 128.0, 44.0) style:AYVibrantButtonStyleTranslucent];
        button.center = CGPointMake(0.25 * CGRectGetWidth(self.view.bounds), 0.75 * CGRectGetHeight(self.view.bounds));
        button.font = [UIFont systemFontOfSize:fontSize];
        button.backgroundColor = [UIColor whiteColor];
        button.vibrancyEffect = nil;
        button.text = @"Any Color";
        button;
    });
    [self.leftVisualEffectView.contentView addSubview:self.leftTranslucentButton];
    
    
    /** 
     Right side of the view contains buttons over a a light blur effect 
     */
    UIBlurEffect *rightBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.rightVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:rightBlurEffect];
    self.rightVisualEffectView.frame = CGRectMake(0.5 * CGRectGetWidth(self.view.bounds), 0.0,
                                                  0.5 * CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    [self.view addSubview:self.rightVisualEffectView];
    
    // Invert vibrancy
    self.rightInvertVibrancyButton = ({
        AYVibrantButton *button = [[AYVibrantButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 128.0, 44.0) style:AYVibrantButtonStyleInvert];
        button.center = CGPointMake(0.25 * CGRectGetWidth(self.view.bounds), 0.25 * CGRectGetHeight(self.view.bounds));
        button.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:rightBlurEffect];
        button.font = [UIFont systemFontOfSize:fontSize];
        button.text = @"Invert";
        button;
    });
    [self.rightVisualEffectView.contentView addSubview:self.rightInvertVibrancyButton];
    
    // Translucent vibrancy
    self.rightTranslucentVibrancyButton = ({
        AYVibrantButton *button = [[AYVibrantButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 128.0, 44.0) style:AYVibrantButtonStyleTranslucent];
        button.center = CGPointMake(0.25 * CGRectGetWidth(self.view.bounds), 0.50 * CGRectGetHeight(self.view.bounds));
        button.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:rightBlurEffect];
        button.font = [UIFont systemFontOfSize:fontSize];
        button.text = @"Translucent";
        button;
    });
    [self.rightVisualEffectView.contentView addSubview:self.rightTranslucentVibrancyButton];
    
    // Translucent
    self.rightTranslucentButton = ({
        AYVibrantButton *button = [[AYVibrantButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 128.0, 44.0) style:AYVibrantButtonStyleTranslucent];
        button.center = CGPointMake(0.25 * CGRectGetWidth(self.view.bounds), 0.75 * CGRectGetHeight(self.view.bounds));
        button.backgroundColor = [UIColor whiteColor];
        button.font = [UIFont systemFontOfSize:fontSize];
        button.vibrancyEffect = nil;
        button.text = @"Any Color";
        button;
    });
    [self.rightVisualEffectView.contentView addSubview:self.rightTranslucentButton];
}

@end
