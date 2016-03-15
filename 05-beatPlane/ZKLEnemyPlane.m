//
//  ZKLEnemyPlane.m
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "ZKLEnemyPlane.h"

@implementation ZKLEnemyPlane


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
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
    
    //延时一段时间后调用选择器的方法
    //参数1：消息(时间到了以后 需要调用的方法
    //参数2：参数
    //参数3:延时时间 单位s
    [self performSelector:@selector(endBombing) withObject:nil afterDelay:0.25];
}
-(void)endBombing{
    [self removeFromSuperview];
    self.isOnScreen=NO;
}

@end
