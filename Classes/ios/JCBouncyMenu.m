//
//  JCBouncyMenu.m
//  JCBouncyMenu
//
//  Created by JFClifton on 5/30/14.
//  Copyright (c) 2014 Jordan Clifton. All rights reserved.
//

#import "JCBouncyMenu.h"
#import <POP/POP.h>

@interface JCBouncyMenu ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger totalBtnHt;
@end

@implementation JCBouncyMenu

- (id)initOriginPoint:(CGPoint)point andButtonImages:(NSArray*)buttonImgArray;
{
    self = [super init];
    if (self) {
        // Initialization code
        self.isOpen = YES;
        self.backgroundColor = [UIColor clearColor];
        self.buttonArray = [[NSMutableArray alloc] init];
        self.buttonImages = [NSArray arrayWithArray:buttonImgArray];
        [self layoutButtons];
        CGRect menuFrame = self.frame;
        menuFrame.origin.x = point.x;
        menuFrame.origin.y = point.y;
        [self setFrame:menuFrame];
    }
    return self;
}

#pragma mark - Set up the buttons in view

- (void)layoutButtons
{
    NSInteger yPlacement = 0;
    CGFloat maxBtnWidth = 0;
    for (int i=0; i<self.buttonImages.count; i++) {
        UIImage *buttonImage = [UIImage imageNamed:[self.buttonImages objectAtIndex:i]];
        UIButton *button = [[UIButton alloc] init];
        [button setFrame:CGRectMake(0, yPlacement, buttonImage.size.width, buttonImage.size.height)];
        [button setBackgroundImage:[UIImage imageNamed:[self.buttonImages objectAtIndex:i]] forState:UIControlStateNormal];
        button.tag = i;
        if (i==self.buttonImages.count-1) {
            [button addTarget:self action:@selector(toggleOpenCloseMenu) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        // Add to frame height
        CGRect newFrame = self.frame;
        newFrame.size.height += button.frame.size.height;
        // Make sure menu's frame width is wide enough
        if (button.frame.size.width > maxBtnWidth) {
            maxBtnWidth = button.frame.size.width;
            newFrame.size.width = maxBtnWidth;
        }
        [self setFrame:newFrame];
        
        [self addSubview:button];
        [self.buttonArray addObject:button];
        yPlacement += buttonImage.size.height;
        
    }
    self.totalBtnHt = [self getTotalButtonHeight];
}

-(void)onButtonClicked:(id)sender
{
    id<JCBouncyMenuDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(bouncyMenu:didSelectButton:)]) {
        [delegate bouncyMenu:self didSelectButton:sender];
    }
}

#pragma mark - Open/Close action menu

- (void)toggleOpenCloseMenu
{
    // open/close button pressed
    UIButton *lastBtn = [self.buttonArray lastObject];
    // Disable button until the animation is done
    lastBtn.userInteractionEnabled = NO;
    CGRect lastBtnFrame = lastBtn.frame;
    NSInteger allButtonHeight = [self getTotalButtonHeight];
    
    for (int i=0; i<self.buttonArray.count; i++) {
        UIButton *button = [self.buttonArray objectAtIndex:i];
        
        if (self.isOpen) {
            // Close buttons
            if (i != self.buttonArray.count-1) {
                POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
                anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                anim.fromValue = [NSValue valueWithCGRect:button.frame];
                CGRect toFrame = CGRectMake(lastBtnFrame.origin.x, lastBtnFrame.origin.y, button.frame.size.width, button.frame.size.height);
                anim.toValue = [NSValue valueWithCGRect:toFrame];
                anim.duration = 0.15;
                [anim setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
                    
                }];
                [button pop_addAnimation:anim forKey:@"slideClose"];
            }
        }
        else
        {
            // Open buttons
            if (i != self.buttonArray.count-1) {
                POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
                anim.fromValue = [NSValue valueWithCGRect:CGRectMake(lastBtnFrame.origin.x, lastBtnFrame.origin.y, button.frame.size.width, button.frame.size.height)];
                CGRect toFrame = CGRectMake(lastBtnFrame.origin.x, lastBtnFrame.origin.y - allButtonHeight, button.frame.size.width, button.frame.size.height);
                anim.toValue = [NSValue valueWithCGRect:toFrame];
                anim.dynamicsFriction = 17.0;
                anim.dynamicsMass = 3.0;
                anim.springBounciness = 12;
                anim.springSpeed = 13;
                [anim setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
                    
                }];
                [button pop_addAnimation:anim forKey:@"buttonBounceOpen"];
                
                allButtonHeight = allButtonHeight - button.frame.size.height;
            }
        }
    }
    
    // Give some bounce to the whole view if it's closing and rotate last button
    POPSpringAnimation *rotateBtn = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotateBtn.dynamicsFriction = 17.0;
    rotateBtn.dynamicsMass = 1.0;
    rotateBtn.springBounciness = 5;
    rotateBtn.springSpeed = 9;
    if (self.isOpen) {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        CGRect nFrame = CGRectMake(self.frame.origin.x, lastBtnFrame.size.height+10, self.frame.size.width, self.frame.size.height);
        anim.fromValue = [NSValue valueWithCGRect:nFrame];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        anim.dynamicsFriction = 6.0;
        anim.dynamicsMass = 3.0;
        anim.springBounciness = 13;
        anim.springSpeed = 5;
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
            id<JCBouncyMenuDelegate> delegate = self.delegate;
            if ([delegate respondsToSelector:@selector(bouncyMenuDidClose:)]) {
                [delegate bouncyMenuDidClose:self];
            }
        }];
        [self pop_addAnimation:anim forKey:@"viewBounce"];
        
        // rotate button for open
        rotateBtn.toValue = @(M_PI);
        
    } else {
        // rotate button for close
        rotateBtn.toValue = @(M_PI*2);
        id<JCBouncyMenuDelegate> delegate = self.delegate;
        if ([delegate respondsToSelector:@selector(bouncyMenuDidOpen:)]) {
            [delegate bouncyMenuDidOpen:self];
        }
    }
    [rotateBtn setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        lastBtn.userInteractionEnabled = YES;
    }];
    [lastBtn.layer pop_addAnimation:rotateBtn forKey:@"btnRotate"];
    
    // After buttons collapse - bring the last button (hide/show menu) to front
    [self bringSubviewToFront:lastBtn];
    
    // reset the flag
    self.isOpen = (self.isOpen) ? NO : YES;
}

#pragma mark - helper method(s)

- (NSInteger)getTotalButtonHeight
{
    NSInteger height = 0;
    for (int i=0; i<self.buttonArray.count-1; i++) {
        UIButton *btn = [self.buttonArray objectAtIndex:i];
        height += btn.frame.size.height;
    }
    return height;
}

@end
