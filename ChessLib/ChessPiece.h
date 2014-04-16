//
//  ChessPiece.h
//  ChessLib
//
//  Created by Anton Guryanov on 14.04.14.
//
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface ChessPiece : NSObject {
    int ownerId;
}

@property BOOL hasMoved;

-(id)initWithOwner:(int)owner;
-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(BOOL)isCapturePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end

@interface King : ChessPiece

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end

@interface Queen : ChessPiece

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end

@interface Rook : ChessPiece

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end

@interface Knight : ChessPiece

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end

@interface Bishop : ChessPiece

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end

@interface Pawn : ChessPiece

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to;
-(BOOL)isCapturePossibleFrom:(Cell)from To:(Cell)to;
-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to;

@end
