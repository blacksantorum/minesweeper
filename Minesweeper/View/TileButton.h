//
//  TileButton.h
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileButton : UIButton

@property (nonatomic,strong) NSIndexPath *location;

// add a location to go with our button for quick synchronization with the game object
// also added initializer to set the Button's frame based on indexPath and clean up
// the VC code a bit

- (instancetype)initWithLocation:(NSIndexPath *)location;

@end
