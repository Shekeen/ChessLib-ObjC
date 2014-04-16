//
//  ChessLibTests.m
//  ChessLibTests
//
//  Created by Anton Guryanov on 09.04.14.
//
//

#import <XCTest/XCTest.h>
#import "ChessPiece.h"

@interface ChessLibTests : XCTestCase

@end

@implementation ChessLibTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testKingMoveChecker {
    King* kingPiece = [[King alloc] initWithOwner:0];

    Cell from = { .row = 5, .col = 0 };
    Cell to = { .row = 5, .col = 1 };
    XCTAssert([kingPiece isMovePossibleFrom:from To:to]);
    
    from.col = 2;
    XCTAssert([kingPiece isMovePossibleFrom:from To:to]);
    
    to.row = 3;
    XCTAssertFalse([kingPiece isMovePossibleFrom:from To:to]);
}

-(void)testQueenMoveChecker {
    Queen* queenPiece = [[Queen alloc] initWithOwner:0];
    
    Cell from = { .row = 3, .col = 0 };
    Cell to = { .row = 6, .col = 3 };
    XCTAssert([queenPiece isMovePossibleFrom:from To:to]);
    
    to.row = 1;
    to.col = 2;
    XCTAssert([queenPiece isMovePossibleFrom:from To:to]);
    
    to.col = 3;
    XCTAssertFalse([queenPiece isMovePossibleFrom:from To:to]);
}

@end
