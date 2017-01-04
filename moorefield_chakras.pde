/*
Moorefield Chakras
Developed by Nathan Wolek
For chakras spiral/xmix, an intermedia work by Virgil Moorefield

Performances on 29 & 30 Oct 2016 in Zurich, Switzerland
More details: http://www.virgilmoorefield.com/events.html

Adapted from source at https://www.openprocessing.org/sketch/383546
by Shogo CC-BY-SA

Copyright © 2016, Virgil Moorefield, Nathan Wolek
License: https://creativecommons.org/licenses/by-sa/4.0/
*/

// globals for chakra objects
ChakraShogo[] cs;
int chakraCount = 7;
int clickTarget = 0; // change which of the 7 chakras to display
boolean opaque = true;

void setup() {
  size(1280, 720, P3D);
  background(0);
  frameRate(60);
  
  // initialize chakra objects
  cs = new ChakraShogo[chakraCount];

  // VM red 20 Oct
  cs[0] = new ChakraShogo(4);
  cs[0].updateColor1(240, 15, 15);
  cs[0].updateColor2(100, 159, 80);
  cs[0].setOpacityMax(110);
  cs[0].updateSpinRate(0.0058083804);
  cs[0].updateParticleSpread1(55);
  cs[0].updateParticleSpread1Noise(0.0);
  cs[0].updateParticleSpread2(63);
  cs[0].updateParticleSpread2Noise(0.0);
  cs[0].updateSpokeNumber(2);
  cs[0].updateParticleSize(39);
  cs[0].updateParticleSizeNoise(0);
  cs[0].initializePosition(random(0,width),random(0,height));
  
  // VM orange 20 Oct
  cs[1] = new ChakraShogo(4);
  cs[1].updateColor1(242, 57, 9);
  cs[1].updateColor2(197, 173, 16);
  cs[1].setOpacityMax(110);
  cs[1].updateSpinRate(0.011164787);
  cs[1].updateParticleSpread1(80);
  cs[1].updateParticleSpread1Noise(0.0);
  cs[1].updateParticleSpread2(60);
  cs[1].updateParticleSpread2Noise(0.0);
  cs[1].updateSpokeNumber(2);
  cs[1].updateParticleSize(20);
  cs[1].updateParticleSizeNoise(0);
  cs[1].initializePosition(random(0,width),random(0,height));
  
  // VM yellow 20 Oct
  cs[2] = new ChakraShogo(5);
  cs[2].updateColor1(230, 217, 82);
  cs[2].updateColor2(83, 175, 100);
  cs[2].setOpacityMax(130);
  cs[2].updateSpinRate(0.0252845293);
  cs[2].updateParticleSpread1(40);
  cs[2].updateParticleSpread1Noise(0.0);
  cs[2].updateParticleSpread2(45);
  cs[2].updateParticleSpread2Noise(0.0);
  cs[2].updateSpokeNumber(2);
  cs[2].updateParticleSize(15);
  cs[2].updateParticleSizeNoise(0);
  cs[2].initializePosition(random(0,width),random(0,height));
  
  // VM green 20 Oct
  cs[3] = new ChakraShogo(3);
  cs[3].updateColor1(63, 208, 90);
  cs[3].updateColor2(114, 151, 92);
  cs[3].setOpacityMax(110);
  cs[3].updateSpinRate(0.013549071);
  cs[3].updateParticleSpread1(60);
  cs[3].updateParticleSpread1Noise(0.0);
  cs[3].updateParticleSpread2(49);
  cs[3].updateParticleSpread2Noise(0.0);
  cs[3].updateSpokeNumber(7);
  cs[3].updateParticleSize(15);
  cs[3].updateParticleSizeNoise(0);
  cs[3].initializePosition(random(0,width),random(0,height));
  
  
  // VM blue 20 Oct
  cs[4] = new ChakraShogo(2);
  cs[4].updateColor1(87, 70, 235);
  cs[4].updateColor2(25, 124, 68);
  cs[4].setOpacityMax(110);
  cs[4].updateSpinRate(0.007816072);
  cs[4].updateParticleSpread1(46);
  cs[4].updateParticleSpread1Noise(0.0);
  cs[4].updateParticleSpread2(100);
  cs[4].updateParticleSpread2Noise(0.0);
  cs[4].updateSpokeNumber(7);
  cs[4].updateParticleSize(26);
  cs[4].updateParticleSizeNoise(0);
  cs[4].initializePosition(random(0,width),random(0,height));
  
  // VM indigo 20 Oct
  cs[5] = new ChakraShogo(4);
  cs[5].updateColor1(87, 70, 235);
  cs[5].updateColor2(29, 227, 100);
  cs[5].setOpacityMax(110);
  cs[5].updateSpinRate(0.1068407254);
  cs[5].updateParticleSpread1(120);
  cs[5].updateParticleSpread1Noise(0.0);
  cs[5].updateParticleSpread2(100);
  cs[5].updateParticleSpread2Noise(0.0);
  cs[5].updateSpokeNumber(7);
  cs[4].updateParticleSize(11);
  cs[5].updateParticleSizeNoise(0);
  cs[5].initializePosition(random(0,width),random(0,height));
  
  // VM violet 20 Oct
  cs[6] = new ChakraShogo(6);
  cs[6].updateColor1(209, 59, 237);
  cs[6].updateColor2(172, 150, 52);
  cs[6].setOpacityMax(80);
  cs[6].updateSpinRate(0.009449847);
  cs[6].updateParticleSpread1(150);
  cs[6].updateParticleSpread1Noise(0.0);
  cs[6].updateParticleSpread2(245);
  cs[6].updateParticleSpread2Noise(0.0);
  cs[6].updateSpokeNumber(6);
  cs[6].updateParticleSize(9);
  cs[6].updateParticleSizeNoise(0);
  cs[6].initializePosition(random(0,width),random(0,height));
  
}

void draw() {
  background(0);
  
  if (opaque) cs[clickTarget].fadeIn();
  
  cs[clickTarget].setTargetPosition(mouseX, mouseY);
  cs[clickTarget].updatePosition();
  cs[clickTarget].show();

}

void keyPressed() {
  if (key == ' ') {
    if (opaque) {
      cs[clickTarget].fadeOut();
      opaque = false;
    } else {
      cs[clickTarget].fadeIn();
      opaque = true;
    }
  }
}