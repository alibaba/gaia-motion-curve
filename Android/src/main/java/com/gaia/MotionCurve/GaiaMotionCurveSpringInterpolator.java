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


public class GaiaMotionCurveSpringInterpolator implements Interpolator {
    private float m, s, d, iv;
//    private float t, f, v;
    private boolean MassSystem;

    public GaiaMotionCurveSpringInterpolator() {
        m = 0.7f;
        s = 380.0f;
        d = 10.0f;
        iv = -2.0f;
//        t = 533.0f;
//        f = 14.0f;
//        v = -2.0f;
        MassSystem = true;
    }

    public GaiaMotionCurveSpringInterpolator(float a_m, float a_s, float a_d, float a_iv) {
        m = a_m;
        s = a_s;
        d = a_d;
        iv = a_iv;
        MassSystem = true;
    }

//    GaiaMotionCurveSpringInterpolator(float a_t, float a_f, float a_v) {
//        t = a_t;
//        f = a_f;
//        v = a_v;
//    }

    @Override
    public float getInterpolation(float p) {
        float result = 0;
//        if (MassSystem) {
            float m_w0 = (float) Math.sqrt(s / m);
            float m_zeta = (float) (d / (2.0f * Math.sqrt(s * m)));
            float m_wd;
            float m_A;
            float m_B;
            if (m_zeta < 1.0f) {
                m_wd = (float) (m_w0 * Math.sqrt(1.0f - m_zeta * m_zeta));
                m_A = 1.0f;
                m_B = (m_zeta * m_w0 + -iv) / m_wd;
            } else {
                m_wd = 0.0f;
                m_A = 1.0f;
                m_B = -iv + m_w0;
            }
            float t;
            if (m_zeta < 1.0f) {
                t = (float) (Math.exp(-p * m_zeta * m_w0) * (m_A * Math.cos(m_wd * p) + m_B * Math.sin(m_wd * p)));
            } else {
                t = (float) ((m_A + m_B * p) * Math.exp(-p * m_w0));
            }
            result = 1.0f - t;
//        }
        return result;
    }
}
