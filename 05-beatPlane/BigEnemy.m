//
//  BigEnemy.m
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "BigEnemy.h"

@implementation BigEnemy

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
        for (int i=1; i<4; i++) {
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"baoza1_%d",i]];
            
            [images addObject:image];
            
        }
        
        self.animationImages=images;
        self.animationRepeatCount=1;
        self.animationDuration=0.25f;
    }
    return self;
}

-(void)bombing{
    
    [self startAnimating];
     [self performSelector:@selector(endBombing) withObject:nil afterDelay:1];
}
-(void)endBombing{
    [self removeFromSuperview];

}

@end
