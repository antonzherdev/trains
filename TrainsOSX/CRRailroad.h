#import "cr.h"

@class CRCity;
@class CRCityColor;
@class CRRail;
@class CRRailForm;

@interface CRRailroad : CECtrl
@property (readonly) NSArray * cities;
@property (readonly) NSArray * rails;
@property (readonly) NSArray * switches;
@property (readonly) CEOrtoMapDim dim;

- (id)initWithView:(id)view dim:(CEOrtoMapDim)dim;
+ (id)ctrlWithView:(id)view dim:(CEOrtoMapDim)dim;

- (void)addCity:(CRCity *)city;
- (CRCity *)cityForColor:(CRCityColor*)color;
- (CRCity *)cityInTile:(CEIPoint)point;

- (void)addRailWithForm:(CRRailForm *)form tile:(CEIPoint)tile;
- (void)removeRailWithForm:(CRRailForm*)form tile:(CEIPoint)tile;

@end

@interface  CRRailroad(CRRailPoint)
- (CGPoint)tilePointForPoint:(CGPoint)point;
- (CGPoint)pointForTile:(CEIPoint)point;

- (void)initRailPoint;
- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length;
- (CGPoint)calculateRailPoint:(CRRailPoint)point;
@end

@interface CRRailroad (CRSwitch)
- (BOOL)canBuildRailWithForm:(CRRailForm*)form tile:(CEIPoint)tile;
@end