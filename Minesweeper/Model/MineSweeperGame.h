//
//  MineSweeperGame.h
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

#define BOARD_SIZE 8
#define TOTAL_MINES 10

@interface MineSweeperGame : NSObject

@property (nonatomic,strong) NSArray *board; // of rows of Tiles

// indicators that the game is over
@property (nonatomic) BOOL playerWon;
@property (nonatomic) BOOL playerLost;

// return or choose the Tile at (y,x)
- (Tile *)tileAtLocation:(NSIndexPath *)location;
- (void)revealLocationAt:(NSIndexPath *)location;

- (void)newGame;
// check if the player has selected all non-mine tiles
- (void)validate;
// reveal mines
- (void)cheat;

@end
