//
//  MTEnemySprite.h
//  MagicTower
//
//  Created by 赵天旭 on 2017/9/6.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MTEnemySprite : SKSpriteNode

//怪物编号
@property (nonatomic,assign) int enemyID;
//怪物名
@property (nonatomic,retain) NSString *enemyName;
//血量
@property (nonatomic,assign) int HP;
//攻击
@property (nonatomic,assign) int Attack;
//防御
@property (nonatomic,assign) int Defense;
//金币
@property (nonatomic,assign) int Coin;
//经验
@property (nonatomic,assign) int Experience;

+ (instancetype)initWithType:(int)typeID;

- (instancetype)initWithTexture:(SKTexture *)texture withType:(int)type;

@end
