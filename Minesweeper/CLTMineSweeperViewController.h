//
//  CLTMineSweeperViewController.h
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineSweeperGame.h"

@interface CLTMineSweeperViewController : UIViewController

@property (nonatomic,strong,readonly) MineSweeperGame *game;

@end
