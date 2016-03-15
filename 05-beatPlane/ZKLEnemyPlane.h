//
//  ZKLEnemyPlane.h
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKLEnemyPlane : UIImageView

@property (nonatomic,assign)BOOL isOnScreen;

@property (nonatomic,assign)int speed;

@property (nonatomic,assign)int liveCount;

//爆炸
-(void)bombing;

@end
