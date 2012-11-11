#import <Foundation/Foundation.h>
#import "CEBezier.h"

struct _CECurve {
    CGPoint* points;
    int pointsCount;
};
typedef struct _CECurve* CECurve;

CECurve ceCurve(int count, ...);
void ceCurveDelete(const CECurve curve);
CGPoint ceCurvePoint(const CECurve curve, CGFloat x);
CGPoint ceCurveLerp(const CECurve curve, CGFloat x);

CECurve ceCurveBezier(const CEBezier bezier, int pointsCount);