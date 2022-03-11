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



public class GaiaMotionCurveBounceInterpolator implements Interpolator {
    private float v, d;

    public GaiaMotionCurveBounceInterpolator() {
        v = 1.0f;
        d = 1.0f;
    }

    public GaiaMotionCurveBounceInterpolator(float a_v, float a_d) {
        v = a_v;
        d = a_d;
    }

    @Override
    public float getInterpolation(float p) {
        float tp = p;
        float b = 2.75f*v;
        if (tp < (1.0f/b)) {
            return (float) Math.pow(b, 2.0f)*tp*tp;
        } else if (tp < (2.0f/b)) {
            return (float)Math.pow(b*d, 2.0f)*(tp - 1.5f/b)*(tp - 1.5f/b) + (float)(1.0f - Math.pow(b*d, 2.0f)*(1.0f/b - 1.5f/b)*(1.0f/b - 1.5f/b));
        } else if (tp < (2.5f/b)) {
            return (float)Math.pow(b*d, 2.0f)*(tp - 2.25f/b)*(tp - 2.25f/b) + (float)(1.0f - Math.pow(b*d, 2.0f)*(2.0f/b- 2.25f/b)*(2.0f/b - 2.25f/b));
        } else {
            return (float)Math.min(1.0f, Math.pow(b*d, 2.0f)*(tp - 2.625f/b)*(tp - 2.625f/b) + (float)(1.0f - Math.pow(b*d, 2.0f)*(2.5f/b - 2.625f/b)*(2.5f/b - 2.625f/b))) ;
        }
    }
}
