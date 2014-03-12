//
//  MineSweeperGame.h
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BOARD_SIZE 8
#define TOTAL_MINES 10

@interface MineSweeperGame : NSObject

@property (nonatomic,strong) NSArray *board; // of rows of Tiles
@property (nonatomic) BOOL playerWon;
@property (nonatomic) BOOL playerLost;

- (void)revealLocationAt:(NSIndexPath *)location;

- (IBAction)newGame:(id)sender;
- (IBAction)validate:(id)sender;
- (IBAction)cheat:(id)sender;

@end
