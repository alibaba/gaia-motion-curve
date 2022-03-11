package com.gaia.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class MainActivity extends AppCompatActivity {

    String[] curveTitles = {"线性曲线(Linear)","加速曲线(Accelerate)","减速曲线(Decelerate)",
            "标准曲线(Standard)","预期曲线(Anticipate)","过度曲线(Overshoot)",
            "弹性曲线(Spring)","弹跳曲线(Bounce)","余弦曲线(Cosine)"};

    String[] curveTypes = {"GaiaMotionCurveLinearInterpolator","GaiaMotionCurveAccelerateInterpolator","GaiaMotionCurveDecelerateInterpolator",
            "GaiaMotionCurveStandardInterpolator","GaiaMotionCurveAnticipateInterpolator","GaiaMotionCurveOvershootInterpolator",
            "GaiaMotionCurveSpringInterpolator","GaiaMotionCurveBounceInterpolator","GaiaMotionCurveCosineInterpolator"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ArrayAdapter adapter = new ArrayAdapter<String>(this,
                R.layout.activity_listview, curveTitles);

        ListView listView = (ListView) findViewById(R.id.gaia_motion_curve_list);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent();
                intent.setClass(MainActivity.this, AnimationActivity.class);
                intent.putExtra("curveType", curveTypes[i]);
                startActivity(intent);
            }
        });
    }
}