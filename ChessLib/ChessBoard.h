//
//  ChessBoard.h
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "ChessPiece.h"

@interface ChessBoard : NSObject {
    NSMutableArray *board;
}

+(int)stringToBoardCoord:(NSString*)str;
+(NSString*)boardCoordToString:(int)coord;
+(NSString*)chessPieceToString:(ChessPiece*)chessPiece;

-(id)init;
-(id)initWithFENPosition:(NSString*)fen;
-(id)moveFrom:(size_t)from To:(size_t)to;
-(NSString*)dumpToFENPosition;

@end
