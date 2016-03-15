//
//  ViewController.m
//  05-beatPlane
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "ViewController.h"
#import "ZKLPlaneView.h"
#import "ZKLBulletView.h"
#import "ZKLEnemyPlane.h"
#import "BackView.h"
#import "Wenben.h"
#import "BigEnemy.h"
#define ScreenW  (int)[UIScreen mainScreen].bounds.size.width
#define ScreenH  (int)[UIScreen mainScreen].bounds.size.height
#define Enemy_tag 200
#define Enemy1_tag 150
@interface ViewController (){
    ZKLPlaneView *_plane;
    NSTimer *_timer;
    NSTimer * _timer1;
     int t;
}

@property (nonatomic,strong)NSMutableArray *enemyPlaneArray;

@end

@implementation ViewController

#pragma  mark  -懒记载
-(NSMutableArray *)enemyPlaneArray{
    if (_enemyPlaneArray==nil) {
        _enemyPlaneArray=[[NSMutableArray alloc]init];
        for (int i=0; i<5; i++) {
            ZKLEnemyPlane *enemyPlane=[[ZKLEnemyPlane alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            
            enemyPlane.image=[UIImage imageNamed:@"diji"];
            enemyPlane.isOnScreen=NO;
            enemyPlane.speed=1;
            
            //设置tag值
            enemyPlane.tag=Enemy_tag;
            [_enemyPlaneArray addObject:enemyPlane];
            
        }
        for (int i=0; i<5; i++) {
            ZKLEnemyPlane *enemyPlane=[[ZKLEnemyPlane alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            
            enemyPlane.image=[UIImage imageNamed:@"diji2"];
            enemyPlane.isOnScreen=NO;
            enemyPlane.speed=1;
            
            //设置tag值
            enemyPlane.tag=Enemy1_tag;
            [_enemyPlaneArray addObject:enemyPlane];
            
        }
    }
    return _enemyPlaneArray;
}



#pragma mark -生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.创建界面
    [self creatUI];
    
//    2.启动定时器
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    _timer1=[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(gameLoop1) userInfo:nil repeats:YES];
}
#pragma mark -创建界面
-(void)creatUI{
//    =========背景图=======
    BackView *background=[[BackView alloc]initWithFrame:self.view.frame];
    background.image=[UIImage imageNamed:@"bg_02.jpg"];
    [self.view addSubview:background];
    
    //添加游戏结束
    Wenben *lable=[[Wenben alloc]initWithFrame:CGRectMake(ScreenW/2.0f-100, 200, 200, 200)];
    [self.view addSubview:lable];
    
    [lable setTag:9];
    
    //添加下一局
    
   
    
//    ========创建玩家=========
    
    //创建对象
    if (_plane.isOnScreen==NO) {
        
    _plane=[[ZKLPlaneView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_plane setCenter:CGPointMake(ScreenW/2.0f, ScreenH-120)];
    [_plane setImage:[UIImage imageNamed:@"feiji"]];
    [_plane setTag:10];
    //设置初始状态
    [_plane setIsMoving:NO];
    [_plane setIsOnScreen:YES];
    [_plane setSpeed:3];
    [self.view addSubview:_plane];
    }
    
//    ==========按钮========
//向左
    UIButton *leftbn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    leftbn.center=CGPointMake(ScreenW/4.0f, ScreenH-50);
    [leftbn setImage:[UIImage imageNamed:@"button_left"] forState:UIControlStateNormal];
//    添加按下事件
    [leftbn addTarget:self action:@selector(planeStartMove:) forControlEvents:UIControlEventTouchDown];
//    添加弹起事件
    [leftbn addTarget:self action:@selector(planeEndMove:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftbn];
    leftbn.tag=Left;
//    向右
    UIButton *rightbn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    rightbn.center=CGPointMake(ScreenW/4.0f*3, ScreenH-50);
    [rightbn setImage:[UIImage imageNamed:@"button_right"] forState:UIControlStateNormal];
    //    添加按下事件
    [rightbn addTarget:self action:@selector(planeStartMove:) forControlEvents:UIControlEventTouchDown];
    //    添加弹起事件
    [rightbn addTarget:self action:@selector(planeEndMove:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightbn];
    
    rightbn.tag=Right;
    
    //添加按钮暂停 开始
    UIButton *start=[[UIButton alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
    [start setImage:[UIImage imageNamed:@"jixu"] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(starttime:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    [start setTag:400];
    
    UIButton *stop=[[UIButton alloc]initWithFrame:CGRectMake(ScreenW-100, 300, 100, 100)];
    [stop setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stoptime:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
    [stop setTag:401];
    
    
//    添加积分
    Wenben *Score=[[Wenben alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    [Score setTextColor:[UIColor redColor]];
    [self.view addSubview:Score];
    Score.tag=7;
    
    Wenben *good=[[Wenben alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
    [good setTextColor:[UIColor blueColor]];
    [self.view addSubview:good];
    [good setFont:[UIFont systemFontOfSize:40]];
    good.tag=17;
}

-(void)starttime:(UIButton *)button{
    [_timer setFireDate:[NSDate distantPast]];
    [_timer1 setFireDate:[NSDate distantPast]];
}
-(void)stoptime:(UIButton *)button{
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer1 setFireDate:[NSDate distantFuture]];
}

#pragma mark -按钮点击
//玩家开始移动
-(void)planeStartMove:(UIButton *)button{
    
//    让玩家移动
    _plane.isMoving=YES;
    
   _plane.direction=button.tag;
    
}
//玩家停止移动
-(void)planeEndMove:(UIButton *)button{
    
    //停止移动
    _plane.isMoving=NO;
    
}
-(void)gameLoop{
    
    static long time=0;
    time++;
   
    
    //1.让玩家移动
    [self planeMove];
    
    //2.发射子弹
    
    if (time%10==0) {
        [_plane shootBullet:self.view];
        if (time%100==0) {
            time=0;
            [self creatEnemy];
        }
        
    }
//    3.让子弹飞
    [self bulletFly];
//    4.敌机出现
    [self creatEnemy];
//    让敌机进攻
    [self enemyAttack];
    CGRect rect1=self.view.frame;
    rect1.origin.y-=1;
    CGRect rect=_plane.frame;
    rect.origin.y-=_plane.speed;
}
#pragma mark -boss
-(void)gameLoop1{
    BigEnemy *big=[[BigEnemy alloc]initWithFrame:CGRectMake(ScreenW/2.0f-100, 0, 200, 200)];
    big.image=[UIImage imageNamed:@"dafeiji1"];
    [self.view addSubview:big];
}

#pragma mark -敌机进攻
-(void)enemyAttack{
    NSArray *subviews=[self.view subviews];
    for (UIView *subview in subviews) {
        if (subview.tag==Enemy_tag||subview.tag==Enemy1_tag) {
            ZKLEnemyPlane *enemyPlane=(ZKLEnemyPlane *)subview;
            CGRect enemyrect=enemyPlane.frame;
            enemyrect.origin.y+=enemyPlane.speed;
            
            enemyPlane.frame=enemyrect;
            
            //判断是否和子弹相撞
            //a.遍历所有的子弹
            for (UIView *view2 in subviews) {
                
                if (view2.tag ==bullet_tag||view2.tag==bullet1_tag||view2.tag==bullet2_tag)
                {
                    ZKLBulletView *bullet=(ZKLBulletView *)view2;
                    //b.判断子弹和滴剂是否有交集
                    if (CGRectIntersectsRect(enemyPlane.frame, bullet.frame))
                    {
                         [bullet removeFromSuperview];
                       [enemyPlane bombing];
                       
                        t++;
                        Wenben *Score=[self.view viewWithTag:7];
                  Wenben *good=[self.view viewWithTag:17];
                  //      for (int i=1; i<100; i++) {
                     //       if (t/(10*i)==1) {
                                
                     //           good.text=@"Great";
                    //        }
                   //     }
                        if (t%10==0) {
                            good.text=@"Great";
                        }else{
                            good.text=nil;
                        }
                        
                        [Score setText:[NSString stringWithFormat:@"%d",t*100]];
                  //      [enemyPlane removeFromSuperview];
                        [Score setFont:[UIFont systemFontOfSize:50]];
               //         enemyPlane.isOnScreen=NO;
                        
                        bullet.isOnScreen=NO;
                        break;
                    }
                }
                
            }
            
            for (UIView *view3 in subviews) {
                if (view3.tag ==10)
                {
                    ZKLPlaneView *plane=(ZKLPlaneView *)view3;
                    //b.判断子弹和滴剂是否有交集
                    if (CGRectIntersectsRect(enemyPlane.frame, plane.frame))
                    {
                        [enemyPlane bombing];
                        [plane bombing1];
                        plane.isOnScreen=NO;
                        //      [enemyPlane removeFromSuperview];
                        
                        //         enemyPlane.isOnScreen=NO;
                        Wenben *lable=(Wenben *)[self.view viewWithTag:9];
                        [lable performSelector:@selector(changeText) withObject:nil afterDelay:0.5];
                        [_timer setFireDate:[NSDate distantFuture]];
                        [_timer1 setFireDate:[NSDate distantFuture]];
                        UIButton *button=[self.view viewWithTag:400];
                          UIButton *button1=[self.view viewWithTag:401];
                        
                        [button removeFromSuperview];
                        [button1 removeFromSuperview];
                        
                        UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenW/2.0f-50, 200, 100, 50)];
                        [button2 setTitle:@"开始下一局" forState:UIControlStateNormal];
                        [self.view addSubview:button2];
                        button2.backgroundColor=[UIColor redColor];
                        [button2 addTarget:self action:@selector(changeback:) forControlEvents:UIControlEventTouchUpInside];
                        
                        break;
                    }
                }
                
            }
            
            
            //判断是否飞出屏幕
            
            if (enemyrect.origin.y>ScreenH) {
                [enemyPlane removeFromSuperview];
                enemyPlane.isOnScreen=NO;
            }
        }
    }
}
-(void)changeback:(UIButton *)button{
    
    NSArray *subviews=[self.view subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
        if (subview.tag==Enemy_tag||subview.tag==Enemy1_tag) {
           ZKLEnemyPlane *enemyplane=[self.view viewWithTag:subview.tag];
            enemyplane.isOnScreen=NO;
        }
        if (subview.tag==7) {
            t=0;
        }
    }
    [self viewDidLoad];
 //   [_timer setFireDate:[NSDate distantPast]];
  //  [_timer1 setFireDate:[NSDate distantPast]];
    
}




#pragma mark -让敌机出现
-(void)creatEnemy{
    
    for (ZKLEnemyPlane *enemyPlane in self.enemyPlaneArray) {
        if (!enemyPlane.isOnScreen) {
            //
            enemyPlane.frame=CGRectMake(arc4random()%(ScreenW-(int)enemyPlane.frame.size.width), 0, enemyPlane.frame.size.width, enemyPlane.frame.size.height);
            [self.view addSubview:enemyPlane];
            enemyPlane.isOnScreen=YES;
            break;
            
            
        }
    }
    
}

#pragma mark -让子弹飞
-(void)bulletFly{
    
    //拿到屏幕上所有的子弹
 
    NSArray *subviews=[self.view subviews];
    for (UIView *subview in subviews) {
        if (subview.tag==bullet_tag)
        {
            ZKLBulletView *bullet=(ZKLBulletView *)subview;
            CGRect rect=bullet.frame;
            rect.origin.y-=bullet.speed;
            
            bullet.frame=rect;

            //判断子弹是否飞出屏幕
            if (rect.origin.y+rect.size.height<0)
            {
                [bullet removeFromSuperview];
                bullet.isOnScreen=NO;
            }
            
        }
        if (subview.tag==bullet1_tag)
       {
      ZKLBulletView *bullet1=(ZKLBulletView *)subview;
            CGRect rect=bullet1.frame;
            rect.origin.y-=bullet1.speed;
            rect.origin.x-=bullet1.speed;
            bullet1.frame=rect;
           if (rect.origin.y+rect.size.height<0)
           {
               [bullet1 removeFromSuperview];
               bullet1.isOnScreen=NO;
           }
        }
        if (subview.tag==bullet2_tag)
        {
            ZKLBulletView *bullet1=(ZKLBulletView *)subview;
            CGRect rect=bullet1.frame;
            rect.origin.y-=bullet1.speed;
            rect.origin.x+=bullet1.speed;
            bullet1.frame=rect;
            if (rect.origin.y+rect.size.height<0)
            {
                [bullet1 removeFromSuperview];
                bullet1.isOnScreen=NO;
            }
        }
    }
    
}

#pragma  mark -玩家移动
-(void)planeMove{
    
    //判断玩家是否能移动
    
    
   
    if (_plane.isMoving) {
        //向左移动
         CGRect rect=_plane.frame;
      //  rect.origin.y-=_plane.speed;
        if (_plane.direction==Left)
        {
            rect.origin.x-=_plane.speed;
            
        }else
        {
            rect.origin.x+=_plane.speed;
        }
        if (!(rect.origin.x<=0||rect.origin.x+rect.size.width>=ScreenW)) {
             _plane.frame=rect;
        }
       
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
