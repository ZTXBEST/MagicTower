//
//  MTMainScene.h
//  MagicTower
//
//  Created by 赵天旭 on 2017/8/22.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MTHeroSprite.h"
@interface MTMainScene : SKScene

//主视图控制英雄移动
- (void)heroMoveTo:(enumHeroMove)move;
//飞行到某层
- (void)flyToMapWithIndex:(int)index;
//获得是否有飞行器
- (BOOL)getCanFlyFlag;
//获得能飞往的最大楼层
- (NSInteger)getMaxCanFlyIndex;
//获得当前楼层
- (NSInteger)getCurMapIndex;

//保存游戏
- (void)saveGame;
- (void)restartGame;
@end
