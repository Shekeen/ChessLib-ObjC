//
//  ChessBoard.h
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import <Foundation/Foundation.h>

@interface ChessBoard : NSObject {
    NSMutableArray *board;
}

+(int)stringToCellCoord:(NSString*)str;
+(NSString*)cellCoordToString:(int)coord;

-(id)init;
-(id)initWithFENPosition:(NSString*)fen;
-(void)moveFrom:(size_t)from To:(size_t)to;

@end
