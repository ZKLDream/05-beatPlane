//
//  Wenben.m
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "Wenben.h"

@implementation Wenben

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)changeText{
    [self setText:@"GAME OVER"];
    [self setFont:[UIFont systemFontOfSize:30]];
    [self setTextColor:[UIColor redColor]];
    
}
@end
