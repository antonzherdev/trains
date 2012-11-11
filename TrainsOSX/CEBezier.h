#import <Foundation/Foundation.h>

struct CEBezier {
    int level;
    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
};
typedef struct CEBezier CEBezier;

static inline CEBezier ceBezier1(const CGPoint p0, const CGPoint p1){
    CEBezier bezier;
    bezier.level = 1;
    bezier.p0 = p0;
    bezier.p1 = p1;
    return bezier;
}

static inline CEBezier ceBezier2(const CGPoint p0, const CGPoint p1, const CGPoint p2) {
    CEBezier bezier;
    bezier.level = 2;
    bezier.p0 = p0;
    bezier.p1 = p1;
    bezier.p2 = p2;
    return bezier;
}

static inline CEBezier ceBezier3(const CGPoint p0, const CGPoint p1, const CGPoint p2, const CGPoint p3) {
    CEBezier bezier;
    bezier.level = 3;
    bezier.p0 = p0;
    bezier.p1 = p1;
    bezier.p2 = p2;
    bezier.p3 = p3;
    return bezier;
}

CGPoint ceBezierPoint(const CEBezier b, CGFloat t);