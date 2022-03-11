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


public class GaiaMotionCurveCosineInterpolator implements Interpolator {
    private float d, c;

    public GaiaMotionCurveCosineInterpolator() {
        d = 1.0f;
        c = 1.0f;
    }

    public GaiaMotionCurveCosineInterpolator(float a_d, float a_c) {
        d = a_d;
        c = a_c;
    }

    @Override
    public float getInterpolation(float p)  {
        return d * 0.5f * (1.0f - (float) Math.cos(p * 2.0f * c * Math.PI));
    }
}
