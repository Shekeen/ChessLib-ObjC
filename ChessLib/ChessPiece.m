//
//  ChessPiece.m
//  ChessLib
//
//  Created by Anton Guryanov on 14.04.14.
//
//

#import "ChessPiece.h"

@implementation ChessPiece

@synthesize hasMoved;

-(id)initWithOwner:(int)owner {
    ownerId = owner;
    [self setHasMoved:FALSE];
    return self;
}

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    return FALSE;
}

-(BOOL)isCapturePossibleFrom:(Cell)from To:(Cell)to {
    return [self isMovePossibleFrom:from To:to];
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    return [[NSArray alloc] init];
}

@end

@implementation King

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    return abs(from.col - to.col) <= 1 && abs(from.row - to.row) <= 1;
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    return [NSArray array];
}

@end

@implementation Queen

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    BOOL isMoveVertical = from.col == to.col;
    BOOL isMoveHorizontal = from.row == to.row;
    BOOL isMoveDiagonal = abs(from.col - to.col) == abs(from.row - to.row);
    return isMoveVertical || isMoveHorizontal || isMoveDiagonal;
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    NSMutableArray* cells = [NSMutableArray array];
    
    BOOL isMoveVertical = from.col == to.col;
    if (isMoveVertical) {
        int fromRow = MIN(from.row, to.row) + 1;
        int toRow = MAX(from.row, to.row);
        for (int i = fromRow; i < toRow; i++) {
            Cell cell = { .row = i, .col = from.col };
            NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
            [cells addObject:val];
        }
        return (NSArray*)cells;
    }
    
    BOOL isMoveHorizontal = from.row == to.row;
    if (isMoveHorizontal) {
        int fromCol = MIN(from.col, to.col) + 1;
        int toCol = MAX(from.col, to.col);
        for (int i = fromCol; i < toCol; i++) {
            Cell cell = { .row = from.row, .col = i };
            NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
            [cells addObject:val];
        }
        return (NSArray*)cells;
    }
    
    BOOL isMoveDiagonal = abs(from.col - to.col) == abs(from.row - to.row);
    if (isMoveDiagonal) {
        int fromRow = MIN(from.row, to.row) + 1;
        int toRow = MAX(from.row, to.row);
        for (int i = fromRow; i < toRow; i++) {
            int idx = i - fromRow + 1;
            int col = from.col + (from.col < to.col ? idx : -idx);
            Cell cell = { .row = i, .col = col };
            NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
            [cells addObject:val];
        }
        return (NSArray*)cells;
    }
    
    return (NSArray*)cells;
}

@end

@implementation Rook

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    return from.col == to.col || from.row == to.row;
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    NSMutableArray* cells = [NSMutableArray array];
    
    BOOL isMoveVertical = from.col == to.col;
    if (isMoveVertical) {
        int fromRow = MIN(from.row, to.row) + 1;
        int toRow = MAX(from.row, to.row);
        for (int i = fromRow; i < toRow; i++) {
            Cell cell = { .row = i, .col = from.col };
            NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
            [cells addObject:val];
        }
        return (NSArray*)cells;
    }
    
    BOOL isMoveHorizontal = from.row == to.row;
    if (isMoveHorizontal) {
        int fromCol = MIN(from.col, to.col) + 1;
        int toCol = MAX(from.col, to.col);
        for (int i = fromCol; i < toCol; i++) {
            Cell cell = { .row = from.row, .col = i };
            NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
            [cells addObject:val];
        }
        return (NSArray*)cells;
    }
    
    return (NSArray*)cells;
}

@end

@implementation Knight

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    return (abs(from.row - to.row) == 2 && abs(from.col - to.col) == 1) ||
           (abs(from.row - to.row) == 1 && abs(from.col - to.col) == 2);
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    return [NSArray array];
}

@end

@implementation Bishop

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    return abs(from.col - to.col) == abs(from.row - to.row);
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    NSMutableArray* cells = [NSMutableArray array];
    
    BOOL isMoveDiagonal = abs(from.col - to.col) == abs(from.row - to.row);
    if (isMoveDiagonal) {
        int fromRow = MIN(from.row, to.row) + 1;
        int toRow = MAX(from.row, to.row);
        for (int i = fromRow; i < toRow; i++) {
            int idx = i - fromRow + 1;
            int col = from.col + (from.col < to.col ? idx : -idx);
            Cell cell = { .row = i, .col = col };
            NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
            [cells addObject:val];
        }
        return (NSArray*)cells;
    }
    
    return (NSArray*)cells;
}

@end

@implementation Pawn

-(BOOL)isMovePossibleFrom:(Cell)from To:(Cell)to {
    return from.col == to.col &&
          (to.row - from.row == 1 || (to.row - from.row == 2 && [self hasMoved] == FALSE));
}

-(BOOL)isCapturePossibleFrom:(Cell)from To:(Cell)to {
    return abs(from.col - to.col) == 1 && to.row - from.row == 1;
}

-(NSArray*)getIntermediateCoordsFrom:(Cell)from To:(Cell)to {
    NSMutableArray* cells = [NSMutableArray array];
    
    BOOL isEnPassant = from.col == to.col && to.row - from.row == 2;
    if (isEnPassant) {
        Cell cell = { .row = from.row + 1, .col = from.col };
        NSValue* val = [NSValue valueWithBytes:&cell objCType:@encode(Cell)];
        [cells addObject:val];
    }
    
    return (NSArray*)cells;
}

@end
