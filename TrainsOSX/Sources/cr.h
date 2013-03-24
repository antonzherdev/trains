#import <Foundation/Foundation.h>
#import "crBase.h"
#import "CRCityColor.h"
#import "CRRailForm.h"
#import "chain.h"

typedef enum {
    crCityOrientationX,
    crCityOrientationY,
} CRCityOrientation;


typedef enum {
    crRailTypeRail,
    crRailTypeCity
} CRRailType;

struct CRRailPoint {
    CEIPoint tile;
    CRRailForm* form;
    CRRailType type;
    CGFloat x;
};
typedef struct CRRailPoint CRRailPoint;


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

