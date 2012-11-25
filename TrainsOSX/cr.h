#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

typedef enum {
    crOrange,
    crGreen,
} CRCityColor;

typedef enum {
    crCityOrientationX,
    crCityOrientationY,
} CRCityOrientation;


typedef enum {
    crRailFormUnknown,
    crRailFormX,
    crRailFormY,
    crRailFormTurnX_Y,
    crRailFormTurnXY,
    crRailFormTurn_XY,
    crRailFormTurn_X_Y
} CRRailForm;

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

