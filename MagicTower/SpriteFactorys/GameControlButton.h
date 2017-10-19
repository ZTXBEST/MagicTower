//
//  GameControlButton.h
//  MagicTower
//
//  Created by 赵天旭 on 2017/8/18.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GameControlButtonDelegate <NSObject>

/**
 hero方向

 @param direction 上0，下1，左2，右3
 */
- (void)didSelectClick:(NSInteger)direction;

@end

@interface GameControlButton : UIControl
@property(nonatomic, weak)id<GameControlButtonDelegate> delegate;
@end
