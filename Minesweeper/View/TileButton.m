//
//  TileButton.m
//  Minesweeper
//
//  Created by Chris Tibbs on 3/11/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "TileButton.h"

@implementation TileButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithLocation:(NSIndexPath *)location
{
    if (self = [super initWithFrame:CGRectMake(20 + location.section * 35.0, 20 + location.row * 35.0, 33.0, 33.0)]) {
        self.location = location;
    }
    return self;
}

@end
