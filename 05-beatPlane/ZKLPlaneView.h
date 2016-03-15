//
//  ZKLPlaneView.h
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#define bullet_tag 100
#define bullet1_tag 50
#define bullet2_tag 30
typedef enum : NSUInteger {
    Left=1,
    Right,
    
} PlayerDirection;



@interface ZKLPlaneView : UIImageView
//是否移动
@property (nonatomic,assign)BOOL isMoving;

//移动速度
@property (nonatomic,assign)BOOL isOnScreen;
@property (nonatomic,assign)int speed;

@property (nonatomic,assign)PlayerDirection direction;

//发射子弹
-(void)shootBullet:(UIView *)place;
-(void)bombing1;
-(void)endBombing;
@end
