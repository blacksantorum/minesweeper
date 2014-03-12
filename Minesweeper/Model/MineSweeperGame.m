//
//  MineSweeperGame.m
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "MineSweeperGame.h"

@interface MineSweeperGame ()

@property NSInteger numberOfMines;

// set all tiles to selected, show mines and adjacent counts
- (void)endGame;

// set mines randomly on the board
- (void)setMines;

// iterate through tiles, marking the amount of adjacent mines
- (void)setAdjacentCounts;

@end

@implementation MineSweeperGame

- (instancetype)init
{
    if (self = [super init]) {
        [self newGame];
    }
    return self;
}

- (void)endGame
{
    for (NSArray *rowOfTiles in self.board) {
        for (Tile *t in rowOfTiles) {
            t.selected = YES;
        }
    }
}

- (void)setMines
{
    int mines = 0;
    // pick a random indexPath and set a mine there, until the mine limit is reached
    while (mines < TOTAL_MINES) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:arc4random_uniform(BOARD_SIZE) inSection:arc4random_uniform(BOARD_SIZE)];
        Tile *tile = [(NSArray *)[self.board objectAtIndex:path.row] objectAtIndex:path.section];
        if (!tile.hasMine) {
            tile.hasMine = YES;
            mines++;
        }
    }
}

- (void)setAdjacentCounts
{
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE;j++) {
            Tile *tile = (Tile *)[(NSArray *)[self.board objectAtIndex:i] objectAtIndex:j];
            
            // for each tile, look at every adjacent Tile and increment the adjacent mines count if that Tile has a mine
            NSInteger adjacentCount = 0;
            for (int row = i-1; row < i + 2; row++) {
                if (row >= 0 && row < BOARD_SIZE) {
                    for (int section = j-1; section < j + 2; section++) {
                        if (section >= 0 && section < BOARD_SIZE) {
                            if ([self tileAtLocation:[NSIndexPath indexPathForRow:row inSection:section]].hasMine) {
                                adjacentCount++;
                            }
                        }
                    }
                }
            }
            
            tile.adjacentMines = adjacentCount;
        }
    }
}

- (Tile *)tileAtLocation:(NSIndexPath *)location
{
    return (Tile *)[(NSArray *)[self.board objectAtIndex:location.row] objectAtIndex:location.section];
}

- (void)revealLocationAt:(NSIndexPath *)location
{
    Tile *tile = [self tileAtLocation:location];
    tile.selected = YES;
    
    if (tile.hasMine) {
        [self endGame];
        self.playerLost = YES;
    }
    // if the tile has no adjacent mines, we must select all adjacent tiles, and continue on any other
    // adjacent tiles recursively
    else if (!tile.adjacentMines) {
        int i =  location.row;
        int j = location.section;
        for (int row = i-1; row < i + 2; row++) {
            if (row >= 0 && row < BOARD_SIZE) {
                for (int section = j-1; section < j + 2; section++) {
                    if (section >= 0 && section < BOARD_SIZE) {
                        NSIndexPath *adjacentLocation = [NSIndexPath indexPathForRow:row inSection:section];
                        if (![self tileAtLocation:adjacentLocation].selected) {
                            [self revealLocationAt:adjacentLocation];
                        }
                    }
                }
            }
        }
    }
}

- (void)newGame
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
    self.playerWon = NO;
    self.playerLost = NO;
    self.board = boardArray;
    [self setMines];
    [self setAdjacentCounts];
}

- (void)validate
{
    for (NSArray *rowOfTiles in self.board) {
        for (Tile *t in rowOfTiles) {
            // if any tiles are unselected and don't contain mines, validate failed
            if (!t.selected && !t.hasMine) {
                self.playerLost = YES;
                [self endGame];
                break;
            }
        }
        self.playerWon = YES;
    }
}

- (void)cheat
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
