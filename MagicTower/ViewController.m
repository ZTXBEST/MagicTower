//
//  ViewController.m
//  MagicTower
//
//  Created by 赵天旭 on 2017/8/18.
//  Copyright © 2017年 ZTX. All rights reserved.
//

#import "ViewController.h"
#import "MTMainScene.h"
#import "GameControlButton.h"


#define ControlButtonTag 120
#define ScrollButtonTag 313

@interface ViewController ()<GameControlButtonDelegate>
@property(nonatomic, strong)MTMainScene *mainScene;
@property(nonatomic, strong)UIScrollView *scrollerView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRunToFloor:) name:NOTI_RunToFloor object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveGame) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    // Configure the view.
    
    [self initScene];
    [self initControllerButton];
    [self initFlyController];
}

- (void)initScene {
    SKView * skView = (SKView *)self.view;
    
    //    skView.showsFPS = YES;
    //    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    _mainScene = [MTMainScene sceneWithSize:CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    _mainScene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:_mainScene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)initControllerButton {
    GameControlButton *button = [[GameControlButton alloc] initWithFrame:CGRectMake(15, KSCREEN_HEIGHT-185, 150, 150)];
    button.delegate = self;
    [self.view addSubview:button];
    
    if (KSCREEN_WIDTH < 568) {
        button.alpha = 0.7;
    }
}

- (void)initFlyController {
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH-32, 0, 32, KSCREEN_HEIGHT)];
    [_scrollerView setBackgroundColor:[UIColor clearColor]];
    for (int i=0; i<=21; i++) {
        UILabel *button = [[UILabel alloc] initWithFrame:CGRectMake(0, i*32, 32, 32)];
        [button setText:[NSString stringWithFormat:@"%d", i]];
        [button setTag:i+ScrollButtonTag];
        if (i <= [_mainScene getMaxCanFlyIndex]) {
            [button setTextColor:[UIColor whiteColor]];
        } else {
            [button setTextColor:[UIColor lightGrayColor]];
        }
        [button setTextAlignment:NSTextAlignmentCenter];
        [_scrollerView addSubview:button];
    }
    [_scrollerView setContentSize:CGSizeMake(32, 32*22)];
    [_scrollerView setShowsVerticalScrollIndicator:NO];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flyButtonClick:)];
    [_scrollerView setUserInteractionEnabled:YES];
    [_scrollerView addGestureRecognizer:tapGesture];
    [self.view addSubview:_scrollerView];
}

- (void)runToFloor:(int)floorIndex {
    if (_scrollerView.isHidden && [_mainScene getCanFlyFlag]) {
        [_scrollerView setHidden:NO];
    } else if(![_mainScene getCanFlyFlag]) {
        [_scrollerView setHidden:YES];
    }
    
    for (int i=0; i<=21; i++) {
        UILabel *button = (UILabel *)[_scrollerView viewWithTag:i+ScrollButtonTag];
        if (button && i == floorIndex) {
            [button setBackgroundColor:[UIColor greenColor]];
        } else if (button) {
            [button setBackgroundColor:[UIColor clearColor]];
        }
        
        if (i <= [_mainScene getMaxCanFlyIndex]) {
            [button setTextColor:[UIColor whiteColor]];
        } else {
            [button setTextColor:[UIColor lightGrayColor]];
        }
    }
    
    int offset = floorIndex*32;
    if (offset>_scrollerView.contentOffset.y && offset<_scrollerView.contentOffset.y+KSCREEN_HEIGHT) {
        //在显示范围内
    } else if (offset<=_scrollerView.contentOffset.y) {
        [_scrollerView setContentOffset:CGPointMake(0, offset) animated:YES];
    } else if (offset>=_scrollerView.contentOffset.y+KSCREEN_HEIGHT) {
        [_scrollerView setContentOffset:CGPointMake(0, offset-KSCREEN_HEIGHT+32) animated:YES];
    }
    
}

- (void)didRunToFloor:(NSNotification *)notification {
    NSNumber *floor = notification.object;
    [self runToFloor:[floor intValue]];
}

- (void)flyButtonClick:(UITapGestureRecognizer *)tapGesture {
    //
    CGPoint point = [tapGesture locationInView:_scrollerView];
    int index = (int)(point.y/32);
    if (index <= [_mainScene getMaxCanFlyIndex]) {
        [_mainScene flyToMapWithIndex:index];
    }
}

- (void)saveGame {
    SKView *skView = (SKView *)self.view;
    skView.paused = YES;
    
    [_mainScene saveGame];
}

- (void)becomeActive {
    SKView *skView = (SKView *)self.view;
    skView.paused = NO;
}

- (void)didSelectClick:(NSInteger)index
{
    [_mainScene heroMoveTo:(enumHeroMove)index];
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
