//
//  MTTileMap.m
//  MagicTower
//
//  Created by 赵天旭 on 2017/8/22.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import "MTTileMap.h"

@implementation MTTileMap

-(id)initWithIndex:(int)index {
    self = [super initWithMapNamed:[NSString stringWithFormat:@"%d.tmx", index]];
    if (self) {
        _road = [self layerNamed:@"road"];
        _upfloor = [self layerNamed:@"upfloor"];
        _downfloor = [self layerNamed:@"downfloor"];
        _item = [self layerNamed:@"item"];
        _enemy = [self layerNamed:@"enemy"];
        _door = [self layerNamed:@"door"];
        _npc = [self layerNamed:@"npc"];
        _other = [self layerNamed:@"other"];
        _heroPoint = [self layerNamed:@"heroPoint"];
    }
    [self titledMapAnalytic];
    return self;
}

-(void)titledMapAnalytic {
//    坐标
    for (int x = 0; x <= 10; x++) {
        for (int y = 0; y <= 10; y++) {
            CGPoint towerLoc = CGPointMake(x, y);
            int heroPoint_tileGid = [_heroPoint tileGidAt:towerLoc];
            if (heroPoint_tileGid) {
                NSDictionary *props = [self propertiesForGid:heroPoint_tileGid];
                NSString *value = [props valueForKey:@"point"];
                int type = [value intValue];
                if (type == 1) {
                    self.up = towerLoc;
                } else {
                    self.down = towerLoc;
                }
                [_heroPoint removeTileAtCoord:[_heroPoint coordForPoint:towerLoc]];
            }
        }
    }
    NSLog(@"英雄初始化位置%f,%f", self.down.x, self.down.y);
}

@end
