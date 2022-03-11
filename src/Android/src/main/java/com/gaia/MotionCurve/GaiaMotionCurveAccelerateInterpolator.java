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


public class GaiaMotionCurveAccelerateInterpolator implements Interpolator {
    private float x1;
    private float y1;
    private float x2;
    private float y2;

    public GaiaMotionCurveAccelerateInterpolator() {
        x1 = 0.4f;
        y1 = 0.0f;
        x2 = 1.0f;
        y2 = 1.0f;
    }

    public GaiaMotionCurveAccelerateInterpolator(float a_x1, float a_y1, float a_x2, float a_y2) {
        x1 = a_x1;
        y1 = a_y1;
        x2 = a_x2;
        y2 = a_y2;
    }

    @Override
    public float getInterpolation(float p) {
        float x = p;
        float z;
        float ax, ay, bx, by, cx, cy;
        for (int i = 1; i < 14; i++) {
            cx = 3.0f * x1;
            bx = 3.0f * (x2 - x1) - cx;
            ax = 1.0f - cx - bx;
            float b = x * (cx + x * (bx + x * ax));
            z = b - p;
            if (Math.abs(z) < 1e-3) {
                break;
            }
            float d = cx + x * (2.0f * bx + 3.0f * ax * x);
            x -= z / d;
        }
        cy = 3.0f * y1;
        by = 3.0f * (y2 - y1) - cy;
        ay = 1.0f - cy - by;
        return x * (cy + x * (by + x * ay));
    }
}
