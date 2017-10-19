//
//  MTTileMap.h
//  MagicTower
//
//  Created by 赵天旭 on 2017/8/22.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import "JSTileMap.h"
#import <Foundation/Foundation.h>

@interface MTTileMap : JSTileMap

@property(nonatomic, strong)TMXLayer *wall;
@property(nonatomic, strong)TMXLayer *road;
@property(nonatomic, strong)TMXLayer *enemy;
@property(nonatomic, strong)TMXLayer *item;
@property(nonatomic, strong)TMXLayer *upfloor;
@property(nonatomic, strong)TMXLayer *downfloor;
@property(nonatomic, strong)TMXLayer *door;
@property(nonatomic, strong)TMXLayer *other;
@property(nonatomic, strong)TMXLayer *npc;
@property(nonatomic, strong)TMXLayer *heroPoint;
@property(nonatomic, assign)CGPoint up;
@property(nonatomic, assign)CGPoint down;

-(id)initWithIndex:(int)index;

@end
