AYVibrantButton
===============

AYVibrantButton is a stylish button with iOS 8 vibrancy effect. It is a subclass of `UIButton` that has a simple yet elegant appearance and built-in support for `UIVisualEffectView` and `UIVibrancyEffect` classes introduced in iOS 8. Yet, it can be used on iOS 7 without the vibrancy effect.

![Screenshot](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/screenshot.png?raw=true)

## Configurations

Vibrant buttons can be configured with one of the three supported button styles, **invert**, **translucent** and **fill** (see examples below).

Some basic properties like **icon**, **text**, **font**, **alpha**, **corner radius**, **border width** and **background color** (for no vibrancy effect) can all be changed easily.

The default vibrancy effect is for blur effect `UIBlurEffectStyleLight`. It could be set to any `UIVibrancyEffect` instance. For today extensions, it should be set to `[UIVibrancyEffect notificationCenterVibrancyEffect]`.

## Note

Though vibrant buttons can be placed anywhere, it is recommended that vibrant buttons with vibrancy effects should be placed in the `contentView` of `UIVisualEffectView` (except in today view).

`UIVisualEffectView` can be created as follows.

```objective-c
UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
effectView.frame = self.view.bounds;
[self.view addSubview:effectView];
```

## Installation

### CocoaPods

Add the following line to the `Podfile`.

```
pod "AYVibrantButton"
```

### Manual Installation

Simply add `AYVibrantButton.h` and `AYVibrantButton.m` to your project.

## Examples

The following images show the normal and highlighted (being pressed) button appearances.

### Invert style with vibrancy effect

![Invert Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert2-dark.gif?raw=true)
![Invert Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert2-extralight.gif?raw=true)

![Invert Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert-dark.gif?raw=true)
![Invert Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert-extralight.gif?raw=true)

````objective-c
AYVibrantButton *invertButton = [[AYVibrantButton alloc] initWithFrame:CGRectZero style:AYVibrantButtonStyleInvert];
invertButton.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
invertButton.text = @"Invert";
invertButton.font = [UIFont systemFontOfSize:18.0];
[effectView.contentView addSubview:invertButton];
```

### Translucent style with vibrancy effect

![Translucent Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/translucent-dark.gif?raw=true)
![Translucent Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/translucent-extralight.gif?raw=true)

````objective-c
AYVibrantButton *translucentButton = [[AYVibrantButton alloc] initWithFrame:CGRectZero style:AYVibrantButtonStyleTranslucent];
translucentButton.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
translucentButton.text = @"Translucent";
translucentButton.font = [UIFont systemFontOfSize:18.0];
[effectView.contentView addSubview:translucentButton];
```

### Translucent style without vibrancy effect

![Translucent Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/anycolor-dark.gif?raw=true)
![Translucent Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/anycolor-extralight.gif?raw=true)

````objective-c
AYVibrantButton *button = [[AYVibrantButton alloc] initWithFrame:CGRectZero style:AYVibrantButtonStyleTranslucent];
button.vibrancyEffect = nil;
button.text = @"Any Color";
button.font = [UIFont systemFontOfSize:18.0];
button.backgroundColor = [UIColor blackColor];
[effectView.contentView addSubview:button];
```

## Changelog

### 1.0.3
* Added a new button style `AYVibrantButtonStyleFill`
* Fixed an issue that setting button alpha removes the vibrancy effect

### 1.0.2
* Support setting icon image

## Creator

**Alan Yip**
* [http://alanyip.me](http://alanyip.me)
* [@tweakcc](https://twitter.com/tweakcc)

## License
```
The MIT License (MIT)

Copyright (c) 2014 Alan Yip

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```