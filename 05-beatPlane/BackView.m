//
//  BackView.m
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "BackView.h"

@implementation BackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        NSMutableArray *images=[[NSMutableArray alloc]init];
        for (int i=1; i<3; i++) {
         
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"bg_0%d.jpg",i]];
        [images addObject:image];
        }
        self.animationImages=images;
        self.animationRepeatCount=0;
        self.animationDuration=2.0f;
        [self startAnimating];
        
        
    }
    return self;
}
@end
