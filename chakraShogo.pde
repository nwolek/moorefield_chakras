/*
ChakraShogo class
Developed by Nathan Wolek
For chakras spiral/xmix, an intermedia work by Virgil Moorefield

Performances on 29 & 30 Oct 2016 in Zurich, Switzerland
More details: http://www.virgilmoorefield.com/events.html

Adapted from source at https://www.openprocessing.org/sketch/383546
by Shogo CC-BY-SA

Copyright © 2016, Virgil Moorefield, Nathan Wolek
License: https://creativecommons.org/licenses/by-sa/4.0/
*/

class ChakraShogo {
  // vars added by NW
  int opacity = 0;
  int opacityChange = 0;
  int opacityChangeAmount = 1;
  int opacityMax = 255;
  boolean fadeEnable = true;

  // position
  // initial position is way off the screen
  float csx;
  float csy;
  float clickx;
  float clicky;

  int wnum=15;

  // color
  // initial color is white
  int r1 = 255;
  int g1 = 255;
  int b1 = 255;
  int r2 = 255;
  int g2 = 255;
  int b2 = 255;

  windmill[] wm;// = new windmill[wnum];
  float fr=0;
  float spinRate = 0.01;  // rate of change per frame
  float particleSpread1 = 50;  // distance of particles from windmill center
  float particleSpread1Noise = 0;
  float particleSpread2 = 100;  // distance of windmill hubs from overall center
  float particleSpread2Noise = 0;
  float particleSize = 9;    // below 9 produces extra dots
  float particleSizeNoise = 0;
  int spokeNumber = 4;  // number of spokes on each windmill

  ChakraShogo(int wnum_in) {

    wnum = wnum_in;
    wm = new windmill[wnum];

    //translate(2*width, 0);
    for (int j=0; j<wnum; j++) {
      wm[j]=new windmill(2*PI*j/wnum);
    }
  }

  void show() {
    pushMatrix();
    // colors are determined by lighting, not shapes
    ambientLight(r1, g1, b1); // color 1
    translate(csx, csy); // location
    pointLight(r2, g2, b2, 0, 0, 0); // color 2

    if (fadeEnable) {
      // update the opacity, but stay within bounds
      int temp = opacity + opacityChange;
      int temp2 = constrain(temp, 0, opacityMax);
      if (temp != temp2) {
        fadeEnable = false;
      }
      opacity = temp2;
    }

    for (int k=0; k<wnum; k++) {
      pushMatrix();
      rotateZ(fr/3+k*2*PI/wnum);
      translate(particleSpread2+random(particleSpread2Noise), 0);
      wm[k].show(fr, opacity, particleSpread1+random(particleSpread1Noise), spokeNumber, particleSize+random(particleSizeNoise));
      popMatrix();
    }
    fr=fr+spinRate;
    popMatrix();
    noLights();
  }

  void initializePosition(float x_in, float y_in) {
    csx = x_in;
    csy = y_in;
    clickx = x_in;
    clicky = y_in;
  }
  
  void setTargetPosition(float x_in, float y_in) {
    clickx = x_in;
    clicky = y_in;
  }

  void updatePosition() {
    csx = csx + (clickx - csx) / 120.0;
    csy = csy + (clicky - csy) / 120.0;
  }

  void updateColor1(int r_in, int g_in, int b_in) {
    r1 = r_in;
    g1 = g_in;
    b1 = b_in;
  }

  void updateColor2(int r_in, int g_in, int b_in) {
    r2 = r_in;
    g2 = g_in;
    b2 = b_in;
  }

  void updateOpacity(int o_in) {
    opacity = o_in;
  }
  
  void setOpacityMax(int om_in) {
    opacityMax = om_in;
  }
  
  int getOpacity() {
    return opacity;
  }

  void updateSpinRate(float sr_in) {
    spinRate = sr_in;
  }

  void updateParticleSpread1(int ps1_in) {
    particleSpread1 = ps1_in;
  }

  void updateParticleSpread1Noise(float ps1n_in) {
    particleSpread1Noise = ps1n_in;
  }

  void updateParticleSpread2(int ps2_in) {
    particleSpread2 = ps2_in;
  }

  void updateParticleSpread2Noise(float ps2n_in) {
    particleSpread2Noise = ps2n_in;
  }

  void updateParticleSize(int psize_in) {
    particleSize = psize_in;
  }

  void updateParticleSizeNoise(float psizen_in) {
    particleSizeNoise = psizen_in;
  }

  void updateSpokeNumber(int sn_in) {
    spokeNumber = sn_in;
  }

  void printCurrentState() {
    println("***************************");
    println("*ChakraShogo current state*");
    println("***WindmillNumber is " + wnum);
    println("***Color1 is " + r1 + " " + g1 + " " + b1);
    println("***Color2 is " + r2 + " " + g2 + " " + b2);
    println("***Opacity is " + opacityMax);
    println("***SpinRate is " + spinRate);
    println("***ParticleSpread1 is " + particleSpread1);
    println("***ParticleSpread1Noise is " + particleSpread1Noise);
    println("***ParticleSpread2 is " + particleSpread2);
    println("***ParticleSpread2Noise is " + particleSpread2Noise);
    println("***SpokeNumber is " + spokeNumber);
    println("***ParticleSize is " + particleSize);
    println("***ParticleSizeNoise is " + particleSizeNoise);
    println("***************************");
  }

  void fadeIn() {
    opacityChange = opacityChangeAmount;
    fadeEnable = true;
  }

  void fadeOut() {
    opacityChange = opacityChangeAmount * -1;
    fadeEnable = true;
  }

  void increaseOpacity() {
    fadeEnable = false;
    opacity -= opacityChangeAmount;
    opacity = constrain(opacity, 0, 255);
  }

  void decreaseOpacity() {
    fadeEnable = false;
    opacity += opacityChangeAmount;
    opacity = constrain(opacity, 0, 255);
  }
}

class windmill {
  float fdeg;
  int alpha = 255; // not necessary?

  windmill(float _fdeg) {
    fdeg=_fdeg;
  }

  void show(float fr_in, int opacity_in, float spread_in, int spokenum_in, float particlesize_in) { 
    for (int i=0; i<spokenum_in; i++) {
      fill(255, opacity_in);

      pushMatrix();
      rotateY(fdeg+fr_in);
      stroke(255, 255-opacity_in);
      //line(0, 0, r, 0);
      translate(spread_in, 0);
      ellipse(7.5, 0, 1, 1);
      noStroke();
      sphere(particlesize_in);
      popMatrix();
      rotateY(2*PI/spokenum_in);
    }
  }
}