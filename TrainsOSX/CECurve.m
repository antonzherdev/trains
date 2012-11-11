#import "cocos2d-ex.h"


CECurve ceCurve(int count, ...) {
    CECurve ret = malloc(sizeof(struct _CECurve));
    CGPoint *points = malloc(sizeof(CGPoint)*count);
    ret->points = points;
    ret->pointsCount = count;

    va_list va;
    va_start(va, count);
    for (int i = 0; i < count; i++) {
        points[i] = va_arg(va, CGPoint);
    }
    va_end(va);
    return ret;
}

void ceCurveDelete(const CECurve curve) {
    free(curve->points);
    free(curve);
}

CGPoint ceCurvePoint(const CECurve curve, CGFloat x) {
    if(x < 0) x = 0;
    else if(x > 1) x = 1;
    return curve->points[(int)round((curve->pointsCount - 1)*x)];
}

CGPoint ceCurveLerp(const CECurve curve, CGFloat x) {
    if(x < 0) x = 0;
    else if(x > 1) x = 1;

    float i =  ((float)x)*(curve->pointsCount - 1);
    int left = (int)floor(i);
    int right = (int)ceil(i);
    if(left == right) return curve->points[left];
    return ccpLerp(curve->points[left], curve->points[left], i - left);
}

CECurve ceCurveBezier(const CEBezier bezier, int pointsCount) {
    if(pointsCount <= 2) @throw @"Points count must be more than 2";

    CGFloat t = 0;
    CECurve ret = malloc(sizeof(struct _CECurve));
    CGPoint *points = malloc(sizeof(CGPoint)*pointsCount);
    ret->points = points;
    ret->pointsCount = pointsCount;
    CGFloat step = 1.0/(pointsCount - 1);

    for(int i = 0; i < pointsCount - 1; i++) {
        points[i] = ceBezierPoint(bezier, t);
        t += step;
    }
    points[pointsCount - 1] = ceBezierPoint(bezier, 1);

    return ret;
}