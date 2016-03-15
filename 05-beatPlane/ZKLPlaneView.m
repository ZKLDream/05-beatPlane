//
//  ZKLPlaneView.m
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "ZKLPlaneView.h"
#import "ZKLBulletView.h"

//在@interface到@end之间可以声明私有的成员变量、属性和成员方法
@interface ZKLPlaneView()

@property (nonatomic,strong)NSMutableArray * bulletArray;

@end

@implementation ZKLPlaneView

//懒加载(实质就是重写成员变量的get方法)   必须是属性 :使用的时候才去加载
//如果用到了懒加载 以后在使用成员变量的时候 必须通过点语法使用(不能直接使用带下划线的成员变量)

-(NSMutableArray *)bulletArray{
    if (_bulletArray==nil) {
        _bulletArray=[[NSMutableArray alloc]init];
        //在这儿写 创建的时候需要做的一些额外的事情(只在创建的时候操作一次)
        
        //创建50个子弹
        for (int i=0; i<10; i++)
        {
            ZKLBulletView *bullet=[[ZKLBulletView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            //设置图片
            bullet.image=[UIImage imageNamed:@"zidan2"];
            bullet.isOnScreen=NO;
            bullet.speed=3;
                //设置子弹的tag值
            bullet.tag=bullet_tag;
            
            [_bulletArray addObject:bullet];
        }
    
        for (int i=0; i<10; i++)
        {
            ZKLBulletView *bullet1=[[ZKLBulletView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            //设置图片
            bullet1.image=[UIImage imageNamed:@"zidan3"];
            bullet1.isOnScreen=NO;
            bullet1.speed=3;
            //设置子弹的tag值
            bullet1.tag=bullet1_tag;
            
            [_bulletArray addObject:bullet1];
        }
        for (int i=0; i<10; i++)
        {
            ZKLBulletView *bullet1=[[ZKLBulletView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            //设置图片
            bullet1.image=[UIImage imageNamed:@"zidan3"];
            bullet1.isOnScreen=NO;
            bullet1.speed=3;
            //设置子弹的tag值
            bullet1.tag=bullet2_tag;
            
            [_bulletArray addObject:bullet1];
        }
        
    }
    return _bulletArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setDirection:(PlayerDirection)direction{
    
    _direction=direction;
    
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        NSMutableArray *images=[[NSMutableArray alloc]init];
        for (int i=1; i<4; i++) {
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"planeBaoza%d",i]];
            
            [images addObject:image];
            
        }
        
        self.animationImages=images;
        self.animationRepeatCount=1;
        self.animationDuration=0.25f;
    }
    return self;
}
-(void)bombing1{
    
    [self startAnimating];
    
    //延时一段时间后调用选择器的方法
    //参数1：消息(时间到了以后 需要调用的方法
    //参数2：参数
    //参数3:延时时间 单位s
    [self performSelector:@selector(endBombing) withObject:nil afterDelay:0.25];
}
-(void)endBombing{
    [self removeFromSuperview];
}


//发射子弹
-(void)shootBullet:(UIView *)place{
    
    //遍历子弹数组 找到一个不再屏幕上的子弹，发射出去
 
    for (ZKLBulletView *bullet in self.bulletArray)
    {
     
        if (!bullet.isOnScreen&&(bullet.tag=bullet_tag))
        {
            //将子弹显示在指定的位置
            bullet.center=CGPointMake(self.center.x+4, self.center.y-self.frame.size.height/2.0f-12);
            //放在屏幕上
            [place addSubview:bullet];
            
            //改变子弹状态
            bullet.isOnScreen=YES;
            break;
        }
    }
    for (ZKLBulletView *bullet in self.bulletArray)
    {
        if (!bullet.isOnScreen&&(bullet.tag==bullet1_tag))
        {
            //将子弹显示在指定的位置
            bullet.center=CGPointMake(self.center.x-20, self.center.y-self.frame.size.height/2.0f-12);
            //放在屏幕上
            [place addSubview:bullet];
            
            //改变子弹状态
            bullet.isOnScreen=YES;
            
            //拿到一个就行
            break;
        }
    
    }
    for (ZKLBulletView *bullet in self.bulletArray)
    {
        if (!bullet.isOnScreen&&(bullet.tag==bullet2_tag))
        {
            //将子弹显示在指定的位置
            bullet.center=CGPointMake(self.center.x+20, self.center.y-self.frame.size.height/2.0f-12);
            //放在屏幕上
            [place addSubview:bullet];
            
            //改变子弹状态
            bullet.isOnScreen=YES;
            
            //拿到一个就行
            break;
        }
        
    }
        
}

@end
