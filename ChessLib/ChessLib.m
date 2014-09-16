//
//  ChessLib.m
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import "ChessLib.h"
#import "ChessPiece.h"

static const int NOPLAYER = -1;
static const int PLAYER1 = 0;
static const int PLAYER2 = 1;

static const int BOARD_SIZE = 64;

@implementation ChessLib

-(id)init {
    self = [super init];
    board = [[ChessBoard alloc] init];
    player1LostPieces = [[NSMutableArray alloc] init];
    player2LostPieces = [[NSMutableArray alloc] init];
    return self;
}

-(size_t)findKingOfPlayer:(int)player {
    for (size_t i = 0; i < BOARD_SIZE; i++) {
        id obj = [board getPieceAtCoord:i];
        if ([obj isMemberOfClass:[King class]]) {
            King* kingPiece = obj;
            if ([kingPiece ownerId] == player)
                return i;
        }
    }
    return BOARD_SIZE;
}

-(NSString*)getFENPosition {
    return [board dumpToFENPosition];
}

-(NSArray*)getPlayerLostPieces:(int)player {
    NSMutableArray* lostPieces = player == 0 ? player1LostPieces
                                             : player2LostPieces;
    return (NSArray*)[lostPieces copy];
}

@end
