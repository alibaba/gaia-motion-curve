package com.gaia.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.animation.ArgbEvaluator;
import android.animation.ValueAnimator;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.Interpolator;
import android.view.animation.RotateAnimation;
import android.view.animation.ScaleAnimation;
import android.view.animation.TranslateAnimation;
import android.widget.Button;

import com.gaia.MotionCurve.*;

public class AnimationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_animation);

        Intent intent = getIntent();
        String curveType = intent.getStringExtra("curveType");

        Button positionButton = (Button) findViewById(R.id.animation_position);
        positionButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                View animationView = findViewById(R.id.animation_view);
                TranslateAnimation animation = new TranslateAnimation(0, 700, 0, 0);
                animation.setFillAfter(true);
                animation.setDuration(700);
                try {
                    animation.setInterpolator((Interpolator)Class.forName("com.gaia.MotionCurve."+curveType).newInstance());
                    animationView.startAnimation(animation);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        });

        Button opacityButton = (Button) findViewById(R.id.animation_opacity);
        opacityButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                View animationView = findViewById(R.id.animation_view);
                AlphaAnimation animation = new AlphaAnimation(1, 0);
                animation.setFillAfter(true);
                animation.setDuration(700);
                try {
                    animation.setInterpolator((Interpolator)Class.forName("com.gaia.MotionCurve."+curveType).newInstance());
                    animationView.startAnimation(animation);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        });

        Button colorButton = (Button) findViewById(R.id.animation_color);
        colorButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                View animationView = findViewById(R.id.animation_view);

                int colorFrom = getResources().getColor(R.color.black);
                int colorTo = getResources().getColor(R.color.red);
                ValueAnimator animation = ValueAnimator.ofObject(new ArgbEvaluator(), colorFrom, colorTo);
                animation.setDuration(700);
                try {
                    animation.setInterpolator((Interpolator)Class.forName("com.gaia.MotionCurve."+curveType).newInstance());
                    animation.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {

                        @Override
                        public void onAnimationUpdate(ValueAnimator animator) {
                            animationView.setBackgroundColor((int) animator.getAnimatedValue());
                        }

                    });
                    animation.start();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        });

        Button scaleButton = (Button) findViewById(R.id.animation_scale);
        scaleButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                View animationView = findViewById(R.id.animation_view);
                ScaleAnimation animation = new ScaleAnimation(1,2,1, 2, Animation.RELATIVE_TO_SELF, 0.5f,  Animation.RELATIVE_TO_SELF,0.5f);
                animation.setFillAfter(true);
                animation.setDuration(700);
                try {
                    animation.setInterpolator((Interpolator)Class.forName("com.gaia.MotionCurve."+curveType).newInstance());
                    animationView.startAnimation(animation);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        });

        Button rotationButton = (Button) findViewById(R.id.animation_rotation);
        rotationButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                View animationView = findViewById(R.id.animation_view);
                RotateAnimation animation = new RotateAnimation(0, 360, Animation.RELATIVE_TO_SELF, 0.5f,  Animation.RELATIVE_TO_SELF,0.5f);
                animation.setFillAfter(true);
                animation.setDuration(700);
                try {
                    animation.setInterpolator((Interpolator)Class.forName("com.gaia.MotionCurve."+curveType).newInstance());
                    animationView.startAnimation(animation);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        });

        Button combButton = (Button) findViewById(R.id.animation_combination);
        combButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                View animationView = findViewById(R.id.animation_view);
                AnimationSet animationSet = new AnimationSet(false);

                RotateAnimation rotateAnimation= new RotateAnimation(0, 360, Animation.RELATIVE_TO_SELF, 0.5f,  Animation.RELATIVE_TO_SELF,0.5f);
                animationSet.addAnimation(rotateAnimation);

                ScaleAnimation scaleAnimation = new ScaleAnimation(1,2,1, 2, Animation.RELATIVE_TO_SELF, 0.5f,  Animation.RELATIVE_TO_SELF,0.5f);
                animationSet.addAnimation(scaleAnimation);

                animationSet.setDuration(700);
                try {
                    animationSet.setInterpolator((Interpolator)Class.forName("com.gaia.MotionCurve."+curveType).newInstance());
                    animationView.startAnimation(animationSet);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        });
    }
}