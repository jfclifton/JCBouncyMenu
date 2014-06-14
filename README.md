# JCBouncyMenu

[![Version](https://img.shields.io/cocoapods/v/JCBouncyMenu.svg?style=flat)](http://cocoadocs.org/docsets/JCBouncyMenu)
[![License](https://img.shields.io/cocoapods/l/JCBouncyMenu.svg?style=flat)](http://cocoadocs.org/docsets/JCBouncyMenu)
[![Platform](https://img.shields.io/cocoapods/p/JCBouncyMenu.svg?style=flat)](http://cocoadocs.org/docsets/JCBouncyMenu)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

All you need to do to get going is:

First import
```
#import JCBouncyMenu.h
```

Then Add a new menu
```
NSArray *buttonImages = @[@"1.png", @"2.png", @"3.png", @"4.png", @"arrow.png"];
JCBouncyMenu *menu = [[JCBouncyMenu alloc] initOriginPoint:CGPointMake(50, 50) andButtonImages:buttonImages];
[self.view addSubview:menu];
```

Delegate Methods
```
<JCBouncyMenuDelegate>
```

Add logic for selected button
```
- (void)bouncyMenu:(JCBouncyMenu *)menu didSelectButton:(UIButton *)button
```

Add logic for menu opening/closing
```
- (void)bouncyMenuDidOpen:(JCBouncyMenu *)menu
- (void)bouncyMenuDidClose:(JCBouncyMenu *)menu
```

## Requirements

## Installation

JCBouncyMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "JCBouncyMenu"

## Author

Jordan Clifton, jfc1254@gmail.com

## License

JCBouncyMenu is available under the MIT license. See the LICENSE file for more info.

