#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"
#import "CRCityColor.h"

typedef enum {
    crCityOrientationX,
    crCityOrientationY,
} CRCityOrientation;


typedef enum {
    crRailFormNil = 0,
    crRailFormX = 1,
    crRailFormY = 2,
    crRailFormTurnX_Y = 3,
    crRailFormTurnXY = 4,
    crRailFormTurn_XY = 5,
    crRailFormTurn_X_Y = 6
} CRRailForm;

#define CR_RAIL_FORM_MAX crRailFormTurn_X_Y

typedef enum {
    crRailTypeRail,
    crRailTypeCity
} CRRailType;

struct CRRailPoint {
    CEIPoint tile;
    CRRailForm form;
    CRRailType type;
    CGFloat x;
};
typedef struct CRRailPoint CRRailPoint;

typedef enum {
    crForward = 1,
    crBackward = -1
} CRDirection;


struct CRRailVector {
    CRRailPoint railPoint;
    CRDirection direction;
};
typedef struct CRRailVector CRRailVector;


typedef enum {
    crCarType1
} CRCarType;

struct CRMoveRailPointResult {
    CRRailPoint railPoint;
    CGFloat error;
    CRDirection direction;
};
typedef struct CRMoveRailPointResult CRMoveRailPointResult;


@class CRRailroad;
@class CRLevel;
@class CRCity;
@class CRRail;
@class CRCar;
@class CRTrain;

