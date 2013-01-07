#import <Foundation/Foundation.h>
#import "CEEnum.h"
#import "crBase.h"


#define CR_RAIL_FORMS_COUNT 6

@interface CRRailForm : CEEnum
@property (nonatomic, readonly)CGFloat length;
@property (nonatomic, readonly) CRDirectionVector v1;
@property (nonatomic, readonly) CRDirectionVector v2;

- (id)initWithName:(NSString *)name length:(CGFloat)length v1:(CRDirectionVector)v1 v2:(CRDirectionVector)v2;

- (CEIPoint)nextTilePoint:(CEIPoint)point direction:(CRDirection)direction;

- (BOOL)couldBeNextForm:(CRRailForm *)form direction:(CRDirection)direction;

- (BOOL)shouldInvertDirectionForNextForm:(CRRailForm *)form direction:(CRDirection)direction;
@end

CRRailForm * crRailFormX;
CRRailForm * crRailFormY;
CRRailForm * crRailFormTurnX_Y;
CRRailForm * crRailFormTurnXY;
CRRailForm * crRailFormTurn_XY;
CRRailForm * crRailFormTurn_X_Y;