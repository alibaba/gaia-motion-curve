/*
 * Copyright (c) 2022, Alibaba Group Holding Limited;
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.gaia.MotionCurve;

import android.view.animation.Interpolator;


public class GaiaMotionCurveAnticipateInterpolator implements Interpolator {
    private float d, x1, y1, x2, y2, x3, y3, x4, y4;

    public GaiaMotionCurveAnticipateInterpolator() {
        d = 1.2f;
        x1 = 0.33f;
        y1 = 0.0f;
        x2 = 0.3f;
        y2 = 1.0f;
        x3 = 0.33f;
        y3 = 0.0f;
        x4 = 0.5f;
        y4 = 1.0f;
    }

    public GaiaMotionCurveAnticipateInterpolator(float a_d, float a_x1, float a_y1, float a_x2, float a_y2, float a_x3, float a_y3, float a_x4, float a_y4) {
        d = a_d;
        x1 = a_x1;
        y1 = a_y1;
        x2 = a_x2;
        y2 = a_y2;
        x3 = a_x3;
        y3 = a_y3;
        x4 = a_x4;
        y4 = a_y4;
    }

    @Override
    public float getInterpolation(float p) {
        if (p <= 0.3f) {
            return -d * mcx_standard_curve(p * 3.33f, x1, y1, x2, y2);
        } else {
            return -d * mcx_standard_curve(0.3f * 3.33f, x1, y1, x2, y2) + (1 + d) * mcx_standard_curve((p - 0.3f) * 1.42f, x3, y3, x4, y4);
        }
    }

    private float mcx_standard_curve(float p, float a_x1, float a_y1, float a_x2, float a_y2) {
        float x = p;
        float z;
        float ax, ay, bx, by, cx, cy;
        for (int i = 1; i < 14; i++) {
            cx = 3 * a_x1;
            bx = 3 * (a_x2 - a_x1) - cx;
            ax = 1 - cx - bx;
            float b = x * (cx + x * (bx + x * ax));
            z = b - p;
            if (Math.abs(z) < 1e-3) {
                break;
            }
            float d = cx + x * (2 * bx + 3 * ax * x);
            x -= z / d;
        }
        cy = 3 * a_y1;
        by = 3 * (a_y2 - a_y1) - cy;
        ay = 1 - cy - by;
        return x * (cy + x * (by + x * ay));
    }
}
