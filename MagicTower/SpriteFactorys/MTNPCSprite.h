//
//  MTNPCSprite.h
//  MagicTower
//
//  Created by 赵天旭 on 2017/9/4.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NPCCompleteBlock)(void);

@interface MTNPCSprite : NSObject
- (id)initWithType:(int)type;

- (void)talkToNpcWithComplete:(NPCCompleteBlock)block;

@end
