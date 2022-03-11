// Copyright (c) 2022, Alibaba Group Holding Limited;
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GMCFunctions.h"

CGFloat gmc_linear_curve(CGFloat p) {
    return p;
}

CGFloat gmc_cosine_curve(CGFloat p, CGFloat d, CGFloat c) {
    return d * 0.5 * (1 - cos(p * 2 * c * M_PI));
}

CGFloat gmc_decelerate_curve(CGFloat p, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2) {
    return gmc_standard_curve(p, x1, y1, x2, y2);
}

CGFloat gmc_accelerate_curve(CGFloat p, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2) {
    return gmc_standard_curve(p, x1, y1, x2, y2);
}

CGFloat gmc_standard_curve(CGFloat p, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2) {
    CGFloat x = p;
    CGFloat z;
    CGFloat ax, ay, bx, by, cx, cy;
    for (int i = 1; i < 14; i++) {
        cx = 3.0f * x1;
        bx = 3.0f * (x2 - x1) - cx;
        ax = 1.0f - cx - bx;
        CGFloat b = x * (cx + x * (bx + x * ax));
        z = b - p;
        if (fabs(z) < 1e-3) {
            break;
        }
        CGFloat d = cx + x * (2.0f * bx + 3.0f * ax * x);
        x -= z / d;
    }
    cy = 3.0f * y1;
    by = 3.0f * (y2 - y1) - cy;
    ay = 1.0f - cy - by;
    return x * (cy + x * (by + x * ay));
}

CGFloat gmc_anticipate_curve(CGFloat p, CGFloat d, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2, CGFloat x3, CGFloat y3, CGFloat x4,
        CGFloat y4) {
    // Anticipate （0.33，0，0.67，1  ）time：0.3     （0.33，0，0.2，1  ）
    if (p <= 0.3f) {
        return -d * gmc_standard_curve(p * 3.33, x1, y1, x2, y2);
    } else {
        return -d * gmc_standard_curve(0.3 * 3.33, x1, y1, x2, y2) + (1 + d) * gmc_standard_curve((p - 0.3) * 1.42, x3, y3, x4, y4);
    }
}

CGFloat gmc_bounce_curve(CGFloat p, CGFloat v, CGFloat d) {
    CGFloat tp = p;
    CGFloat b = 2.75 * v;
    if (tp < (1 / b)) {
        return pow(b, 2) * tp * tp;
    } else if (tp < (2 / b)) {
        return pow(b * d, 2) * (tp - 1.5 / b) * (tp - 1.5 / b) + (1 - pow(b * d, 2) * (1 / b - 1.5 / b) * (1 / b - 1.5 / b));
    } else if (tp < (2.5 / b)) {
        return pow(b * d, 2) * (tp - 2.25 / b) * (tp - 2.25 / b) + (1 - pow(b * d, 2) * (2 / b - 2.25 / b) * (2 / b - 2.25 / b));
    } else {
        return MIN(1.0f, pow(b * d, 2) * (tp - 2.625 / b) * (tp - 2.625 / b) + (1 - pow(b * d, 2) * (2.5 / b - 2.625 / b) * (2.5 / b - 2.625 / b)));
    }
}

CGFloat gmc_overshoot_curve(CGFloat p, CGFloat d, CGFloat x1, CGFloat y1, CGFloat x2,
        CGFloat y2, CGFloat x3, CGFloat y3, CGFloat x4,
        CGFloat y4) {
    //Overshoot （0.33，0，0.3，1  ）time：0.5     （0.33，0，0.5，1  ）
    if (p <= 0.5f) {
        return d * gmc_standard_curve(p * 2, x1, y1, x2, y2);
    } else {
        return d * gmc_standard_curve(0.5 * 2, x1, y1, x2, y2) - (d - 1) * gmc_standard_curve((p - 0.5) * 2, x3, y3, x4, y4);
    }
}

CGFloat gmc_spring_motion_curve(CGFloat p, CGFloat m, CGFloat s, CGFloat d,
        CGFloat iv) {
    CGFloat m_w0 = sqrt(s / m);
    CGFloat m_zeta = d / (2.0f * sqrt(s * m));
    CGFloat m_wd;
    CGFloat m_A;
    CGFloat m_B;
    if (m_zeta < 1.0f) {
        m_wd = m_w0 * sqrt(1.0f - m_zeta * m_zeta);
        m_A = 1.0f;
        m_B = (m_zeta * m_w0 + -iv) / m_wd;
    } else {
        m_wd = 0.0f;
        m_A = 1.0f;
        m_B = -iv + m_w0;
    }
    CGFloat t;
    if (m_zeta < 1.0f) {
        t = exp(-p * m_zeta * m_w0) * (m_A * cos(m_wd * p) + m_B * sin(m_wd * p));
    } else {
        t = (m_A + m_B * p) * exp(-p * m_w0);
    }
    return 1.0f - t;
}

typedef struct {
    CGFloat x;
    CGFloat v;
    CGFloat tension;
    CGFloat friction;
} GMCSpringState;

typedef struct {
    CGFloat dx;
    CGFloat dv;
} GMCSpringDerivative;

CGFloat normalizeSpringValue(CGFloat value) {
    if (isnan(value)) {
        return 0;
    } else if (isinf(value)) {
        return 0;
    } else {
        return value;
    }
}

CGFloat springAccelerationForState(GMCSpringState state) {
    return -state.tension * state.x - state.friction * state.v;
}

GMCSpringDerivative springEvaluateState(GMCSpringState initialState) {
    GMCSpringDerivative output;
    output.dx = initialState.v;
    output.dv = springAccelerationForState(initialState);
    return output;
}

GMCSpringDerivative springEvaluateStateWithDerivative(GMCSpringState initialState, CGFloat dt, GMCSpringDerivative derivative) {

    GMCSpringState state;
    state.x = initialState.x + derivative.dx * dt;
    state.v = initialState.v + derivative.dv * dt;
    state.tension = initialState.tension;
    state.friction = initialState.friction;

    GMCSpringDerivative output;
    output.dx = state.v;
    output.dv = springAccelerationForState(state);

    return output;
}

GMCSpringState springIntegrateState(GMCSpringState state, CGFloat speed) {
    GMCSpringDerivative a = springEvaluateState(state);
    GMCSpringDerivative b = springEvaluateStateWithDerivative(state, speed * 0.5, a);
    GMCSpringDerivative c = springEvaluateStateWithDerivative(state, speed * 0.5, b);
    GMCSpringDerivative d = springEvaluateStateWithDerivative(state, speed, c);

    CGFloat tx = (a.dx + 2.0 * (b.dx + c.dx) + d.dx);
    CGFloat ty = (a.dv + 2.0 * (b.dv + c.dv) + d.dv);

    CGFloat dxdt = 1.0 / 6.0 * tx;
    CGFloat dvdt = 1.0 / 6.0 * ty;

    GMCSpringState output = state;

    output.x = state.x + dxdt * speed;
    output.v = state.v + dvdt * speed;

    return output;
}

CGFloat gmc_spring_rk4_motion_curve(CGFloat p, CGFloat *lastValue, CGFloat t, CGFloat f, CGFloat *v) {
    CGFloat result;
    if (p == 0.0f) {
        result = 0.0f;
    } else {
        GMCSpringState before;
        before.x = *lastValue - 1.0f;
        before.v = *v;
        before.tension = t;
        before.friction = f;

        GMCSpringState after = springIntegrateState(before, 1 / 60.0f);
        *lastValue = 1 + after.x;
        *v = after.v;

        *lastValue = normalizeSpringValue(*lastValue);
        *v = normalizeSpringValue(*v);

        result = *lastValue;
    }
    return result;
}
