//
//  ChessLib.h
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import <Foundation/Foundation.h>

#import "Cell.h"
#import "ChessBoard.h"

@interface ChessLib : NSObject {
    ChessBoard* board;
    NSMutableArray* player1LostPieces;
    NSMutableArray* player2LostPieces;
}

@property int currentMove;

-(id)init;
-(size_t)findKingOfPlayer:(int)player;
-(int)getCheck;
-(int)getCheckmate;
-(BOOL)makeMoveFrom:(size_t)from To:(size_t)to;
-(NSArray*)getPlayerLostPieces:(int)player;
-(NSArray*)getPossibleMoves:(size_t)coord;
-(BOOL)isEnPassantPossible:(size_t)coord;
-(BOOL)isCastlingPossible:(int)player;
-(NSString*)getFENPosition;

@end
