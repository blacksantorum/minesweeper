//
//  MineSweeperGame.m
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "MineSweeperGame.h"
#import "Tile.h"

@interface MineSweeperGame ()

- (void)endGame;
- (void)setMines;

@end

@implementation MineSweeperGame

- (void)endGame
{
    // end the game by marking all tiles as selected
    for (NSArray *rowOfTiles in self.board) {
        for (Tile *t in rowOfTiles) {
            t.selected = YES;
        }
    }
}

- (void)setMines
{
    int mines = 0;
    while (mines < TOTAL_MINES) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:arc4random_uniform(BOARD_SIZE) inSection:arc4random_uniform(BOARD_SIZE)];
        Tile *tile = [(NSArray *)[self.board objectAtIndex:path.row] objectAtIndex:path.section];
        if (!tile.hasMine) {
            tile.hasMine = YES;
            mines++;
        }
    }
}

- (void)revealLocationAt:(NSIndexPath *)location
{
    Tile *tile = [(NSArray *)[self.board objectAtIndex:location.row] objectAtIndex:location.section];
    tile.selected = YES;
    
    if (tile.hasMine) {
        [self endGame];
        self.playerLost = YES;
    }
}

- (IBAction)newGame:(id)sender
{
    NSMutableArray *boardArray = [NSMutableArray array];
    // create 8 rows of 8 tiles
    for (int i = 0; i < BOARD_SIZE; i++) {
        NSMutableArray *rowOfTiles = [NSMutableArray array];
        for (int j = 0; j < BOARD_SIZE;j++) {
            Tile *t = [[Tile alloc] init];
            [rowOfTiles addObject:t];
        }
        [boardArray addObject:rowOfTiles];
    }
    self.board = boardArray;
    [self setMines];
}

- (IBAction)validate:(id)sender
{
    for (NSArray *rowOfTiles in self.board) {
        for (Tile *t in rowOfTiles) {
            // if any tiles are unselected and don't contain mines, validate failed
            if (!t.selected && !t.hasMine) {
                self.playerLost = YES;
                break;
            }
        }
        self.playerWon = YES;
    }
}

- (IBAction)cheat:(id)sender
{
    for (NSArray *rowOfTiles in self.board) {
        for (Tile *t in rowOfTiles) {
            if (t.hasMine) {
                t.selected = YES;
            }
        }
    }
}

@end
