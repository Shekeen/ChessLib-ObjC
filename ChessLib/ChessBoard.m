//
//  ChessBoard.m
//  ChessLib
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import "ChessBoard.h"

static const NSString* FEN_STARTING_POSITION = @"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR";
static const size_t BOARD_SIZE = 64;
static const int NOPLAYER = -1;
static const int PLAYER1 = 0;
static const int PLAYER2 = 1;

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
    
    return 8*row + col;
}

+(int)cellToBoardCoord:(Cell)cell {
    if (cell.row < 0 || cell.row > 7 || cell.col < 0 || cell.col > 7)
        return -1;

    return 8*cell.row + cell.col;
}

+(NSString*)boardCoordToString:(int)coord {
    if (coord < 0 || coord > 63)
        return nil;

    char coordStr[3];
    coordStr[0] = (char)(coord % 8) + 'a';
    coordStr[1] = (char)(coord / 8) + '1';
    coordStr[2] = '\0';

    return [NSString stringWithCString:coordStr encoding:NSASCIIStringEncoding];
}

+(NSString*)cellToString:(Cell)cell {
    return [self boardCoordToString: [self cellToBoardCoord: cell]];
}

+(Cell)stringToCell:(NSString*)str {
    char coord[3];
    [[str lowercaseString] getCString:coord
                           maxLength:3
                           encoding:NSASCIIStringEncoding];

    Cell cell = { .col = coord[0] - 'a', .row = coord[1] - '1' };
    if (cell.col < 0 || cell.col > 7 || cell.row < 0 || cell.row > 7)
        cell.row = cell.col = -1;

    return cell;
}

+(Cell)boardCoordToCell:(int)coord {
    return [self stringToCell: [self boardCoordToString: coord]];
}

+(NSString*)chessPieceToString:(ChessPiece*)chessPiece {
    if ([chessPiece isMemberOfClass:[King class]]) {
        return [chessPiece ownerId] == 0 ? @"k" : @"K";
    } else if ([chessPiece isMemberOfClass:[Queen class]]) {
        return [chessPiece ownerId] == 0 ? @"q" : @"Q";
    } else if ([chessPiece isMemberOfClass:[Bishop class]]) {
        return [chessPiece ownerId] == 0 ? @"b" : @"B";
    } else if ([chessPiece isMemberOfClass:[Knight class]]) {
        return [chessPiece ownerId] == 0 ? @"n" : @"N";
    } else if ([chessPiece isMemberOfClass:[Rook class]]) {
        return [chessPiece ownerId] == 0 ? @"r" : @"R";
    } else if ([chessPiece isMemberOfClass:[Pawn class]]) {
        return [chessPiece ownerId] == 0 ? @"p" : @"P";
    } else {
        return @"";
    }
}

-(id)init {
    return [self initWithFENPosition:FEN_STARTING_POSITION];
}

-(id)initWithFENPosition:(NSString *)fen {
    self = [super init];
    board = [[NSMutableArray alloc] initWithCapacity:BOARD_SIZE];

    const char* fen_str = [fen cStringUsingEncoding:NSASCIIStringEncoding];
    size_t fen_length = strlen(fen_str);
    for (size_t fen_idx = 0; fen_idx < fen_length; fen_idx++) {
        char cur_char = fen_str[fen_idx];
        if (islower(cur_char)) {
            switch (cur_char) {
            case 'r':
                [board addObject:[[Rook alloc] initWithOwner:PLAYER1]];
                break;
            case 'n':
                [board addObject:[[Knight alloc] initWithOwner:PLAYER1]];
                break;
            case 'b':
                [board addObject:[[Bishop alloc] initWithOwner:PLAYER1]];
                break;
            case 'q':
                [board addObject:[[Queen alloc] initWithOwner:PLAYER1]];
                break;
            case 'k':
                [board addObject:[[King alloc] initWithOwner:PLAYER1]];
                break;
            case 'p':
                [board addObject:[[Pawn alloc] initWithOwner:PLAYER1]];
                break;
            default:
                break;
            }
        } else if (isupper(cur_char)) {
            switch (cur_char) {
            case 'R':
                [board addObject:[[Rook alloc] initWithOwner:PLAYER2]];
                break;
            case 'N':
                [board addObject:[[Knight alloc] initWithOwner:PLAYER2]];
                break;
            case 'B':
                [board addObject:[[Bishop alloc] initWithOwner:PLAYER2]];
                break;
            case 'Q':
                [board addObject:[[Queen alloc] initWithOwner:PLAYER2]];
                break;
            case 'K':
                [board addObject:[[King alloc] initWithOwner:PLAYER2]];
                break;
            case 'P':
                [board addObject:[[Pawn alloc] initWithOwner:PLAYER2]];
                break;
            default:
                break;
            }
        } else if (isdigit(cur_char)) {
            size_t digit = cur_char - '0';
            for (size_t i = 0; i < digit; i++)
                [board addObject:[NSNull null]];
        }
    }
    assert([board count] == BOARD_SIZE);

    return self;
}

-(id)getPieceAtCoord:(size_t)coord {
    if (coord >= [board count])
        return [NSNull null];

    return board[coord];
}

-(id)moveFrom:(size_t)from To:(size_t)to {
    id destObject = board[to];
    board[to] = board[from];
    board[from] = [NSNull null];
    if ([board[to] isEqual:[NSNull null]]) {
        ChessPiece* piece = board[to];
        [piece setHasMoved:TRUE];
    }
    return destObject;
}

-(NSString*)dumpToFENPosition {
    NSMutableString* ans = [[NSMutableString alloc] initWithCapacity:70];
    size_t board_len = [board count];
    size_t empty_count = 0;

    for (size_t i = 0; i < board_len; i++) {
        if (i != 0 && i % 8 == 0) {
            if (empty_count > 0) {
                [ans appendFormat:@"%zu", empty_count];
                empty_count = 0;
            }
            [ans appendString:@"/"];
        }

        if (board[i] == [NSNull null]) {
            empty_count++;
        } else if ([board[i] isKindOfClass:[ChessPiece class]]) {
            if (empty_count > 0) {
                [ans appendFormat:@"%zu", empty_count];
                empty_count = 0;
            }
            [ans appendString:[ChessBoard chessPieceToString:(ChessPiece*)board[i]]];
        } else {
            empty_count++;
            NSLog(@"Strange stuff in board array at %zu: %@", i, board[i]);
        }
    }
    if (empty_count > 0)
        [ans appendFormat:@"%zu", empty_count];

    return (NSString*)ans;
}

@end
