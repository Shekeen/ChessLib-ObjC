//
//  ChessBoard.h
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface ChessBoard : NSObject {
    NSMutableArray *board;
}

+(int)stringToBoardCoord:(NSString*)str;
+(NSString*)boardCoordToString:(int)coord;

-(id)init;
-(id)initWithFENPosition:(NSString*)fen;
-(void)moveFrom:(size_t)from To:(size_t)to;

@end
