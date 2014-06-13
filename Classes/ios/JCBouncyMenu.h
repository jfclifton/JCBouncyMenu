//
//  JCBouncyMenu.h
//  JCBouncyMenu
//
//  Created by JFClifton on 5/30/14.
//  Copyright (c) 2014 Jordan Clifton. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCBouncyMenuDelegate;

@interface JCBouncyMenu : UIView

- (id)initOriginPoint:(CGPoint)point andButtonImages:(NSArray*)buttonImgArray;
@property (nonatomic, strong) NSArray *buttonImages;
@property (nonatomic, weak) id<JCBouncyMenuDelegate> delegate;

@end

@protocol JCBouncyMenuDelegate <NSObject>

- (void)bouncyMenu:(JCBouncyMenu *)menu didSelectButton:(UIButton *)button;
- (void)bouncyMenuDidClose:(JCBouncyMenu *)menu;
- (void)bouncyMenuDidOpen:(JCBouncyMenu *)menu;

@end
