//
//  CLTMineSweeperViewController.m
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "CLTMineSweeperViewController.h"
#import "TileButton.h"

@interface CLTMineSweeperViewController ()

@property (nonatomic,strong,readwrite) MineSweeperGame *game;
@property (nonatomic,strong) NSArray *tileButtons;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)newGame:(id)sender;
- (IBAction)validate:(id)sender;
- (IBAction)cheat:(id)sender;

@end

@implementation CLTMineSweeperViewController

// lazy instantiaton of game object
- (MineSweeperGame *)game
{
    if (!_game) {
        _game = [[MineSweeperGame alloc] init];
    }
    return _game;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // draw the board, storing TileButtons in an array for fast enumeration
    NSMutableArray *tileButtons = [NSMutableArray array];
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            TileButton *button = [[TileButton alloc] initWithLocation:[NSIndexPath indexPathForRow:i inSection:j]];
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor grayColor]];
            [tileButtons addObject:button];
            [self.view addSubview:button];
        }
    }
    self.tileButtons = tileButtons;
}

- (void)selectButton:(TileButton *)sender
{
    [self.game revealLocationAt:sender.location];
    [self updateUI];
}

- (void)updateUI
{
    if (self.game.playerLost) {
        [self.resultLabel setText:@"You lost!"];
    } else if (self.game.playerWon) {
        [self.resultLabel setText:@"You won!"];
    }
    
    // iterate over titleButtons, updating their state to jive with the game
    
    for (TileButton *tb in self.tileButtons) {
        Tile * tile = [self.game tileAtLocation:tb.location];
        if (tile.selected) {
            tb.enabled = NO;
            [tb setBackgroundColor:[UIColor lightGrayColor]];
            if (tile.hasMine) {
                [tb setTitle:@"" forState:UIControlStateNormal];
                [tb setImage:[UIImage imageNamed:@"mine"] forState:UIControlStateNormal];
            } else {
                if (tile.adjacentMines) {
                    [tb setTitle:[NSString stringWithFormat:@"%d",tile.adjacentMines] forState:UIControlStateNormal];
                } else {
                    [tb setTitle:@"" forState:UIControlStateNormal];
                }
                [tb setImage:nil forState:UIControlStateNormal];
            }
        } else {
            [tb setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
            [tb setImage:nil forState:UIControlStateNormal];
            [tb setBackgroundColor:[UIColor grayColor]];
        }
    }
}

        
- (IBAction)newGame:(id)sender {
    [self.game newGame];
    for (TileButton *tb in self.tileButtons) {
        tb.enabled = YES;
    }
    self.resultLabel.text = @"";
    [self updateUI];
}

- (IBAction)validate:(id)sender {
    [self.game validate];
    [self updateUI];
}

- (IBAction)cheat:(id)sender {
    [self.game cheat];
    [self updateUI];
}
@end
