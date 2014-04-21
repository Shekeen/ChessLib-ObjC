//
//  ChessBoard.m
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import "ChessBoard.h"

static NSString* FEN_STARTING_POSITION = @"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR";
static size_t BOARD_SIZE = 64;

@implementation ChessBoard

+(int)stringToBoardCoord:(NSString*)str {
    char coord[3];
    if (![[str lowercaseString] getCString:coord
                                maxLength:3
                                encoding:NSASCIIStringEncoding])
    {
        return -1;
    }
    
    int col = coord[0] - 'a';
    int row = coord[1] - '1';
    if (col < 0 || col > 7 || row < 0 || row > 7)
        return -1;
    
    return row + 8*col;
}

+(NSString*)boardCoordToString:(int)coord {
    if (coord < 0 || coord > 63)
        return nil;
    
    char coordStr[3];
    coordStr[0] = (char)(coord / 8) + 'a';
    coordStr[1] = (char)(coord % 8) + '1';
    coordStr[2] = '\0';
    
    return [NSString stringWithCString:coordStr encoding:NSASCIIStringEncoding];
}

-(id)init {
    return [self initWithFENPosition:FEN_STARTING_POSITION];
}

-(id)initWithFENPosition:(NSString *)fen {
    self = [super init];
    board = [[NSMutableArray alloc] initWithCapacity:BOARD_SIZE];
    for (size_t i = 0; i < BOARD_SIZE; i++) {
        [board addObject:nil];
    }
    return self;
}

-(void)moveFrom:(size_t)from To:(size_t)to {
}

@end
