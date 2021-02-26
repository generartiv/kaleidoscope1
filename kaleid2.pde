PImage imageDepart;



PShape triangle;
PShape triangleMiroir;

float tailleEcran;
float tailleTexture;
float xCentreSymetrieEcran;
float yCentreSymetrieEcran;
float xCentreSymetrie = 0;
float yCentreSymetrie = 0;

float angleDepart = 0;
float ajoutAngleTexture = 0;



void setup() {
  size(1280, 720, P2D);
  imageDepart = loadImage("data/image.jpg");
}


void draw() {

  float tailleEcran = width/13;
  float tailleTexture =  cos(millis() * 0.0001389)*61 + 142;



  background(0);
  ajoutAngleTexture +=0.00303;
  if (ajoutAngleTexture>TWO_PI) {
    ajoutAngleTexture-=TWO_PI;
  }

  xCentreSymetrie = cos(millis() * 0.000015) * imageDepart.width/4 + imageDepart.width/2;
  yCentreSymetrie = sin(millis() * 0.000013) * imageDepart.height/4 + imageDepart.height/2;

  int nbRepet = 3;

  float angleRepet = TWO_PI / nbRepet;

  float angleFin = angleDepart + (angleRepet/2);
  float xPoint1 = cos(angleDepart)*tailleEcran;
  float yPoint1 = sin(angleDepart)*tailleEcran;
  float xPoint2 = cos(angleFin)*tailleEcran;
  float yPoint2 = sin(angleFin)*tailleEcran;

  float xPoint1Texture = cos(angleDepart + ajoutAngleTexture)*tailleTexture + xCentreSymetrie;
  float yPoint1Texture = sin(angleDepart + ajoutAngleTexture)*tailleTexture + yCentreSymetrie;
  float xPoint2Texture = cos(angleFin + ajoutAngleTexture)*tailleTexture + xCentreSymetrie;
  float yPoint2Texture = sin(angleFin + ajoutAngleTexture)*tailleTexture + yCentreSymetrie;


  triangle = createShape();
  triangle.beginShape();
  triangle.noStroke();
  triangle.noFill();
  triangle.texture(imageDepart);
  triangle.vertex(0, 0, xCentreSymetrie, yCentreSymetrie);
  triangle.vertex(xPoint1, yPoint1, xPoint1Texture, yPoint1Texture);
  triangle.vertex(xPoint2, yPoint2, xPoint2Texture, yPoint2Texture);
  triangle.endShape(CLOSE);

  triangleMiroir = createShape();
  triangleMiroir.beginShape();
  triangleMiroir.noStroke();
  triangleMiroir.noFill();
  triangleMiroir.texture(imageDepart);
  triangleMiroir.vertex(0, 0, xCentreSymetrie, yCentreSymetrie);
  triangleMiroir.vertex(xPoint1, yPoint1, xPoint2Texture, yPoint2Texture);
  triangleMiroir.vertex(xPoint2, yPoint2, xPoint1Texture, yPoint1Texture  );
  triangleMiroir.endShape(CLOSE);

  float rang = 0;
  for (float yCentreSymetrieEcran=0; yCentreSymetrieEcran<height + tailleEcran*2; yCentreSymetrieEcran+=tailleEcran * 0.8659) {
    rang++;
    float xDepart = 0;
    if (rang%2==0) {
      xDepart = tailleEcran*1.5;
    }
    for (float xCentreSymetrieEcran=0; xCentreSymetrieEcran<width+tailleEcran*2; xCentreSymetrieEcran+=tailleEcran*3) {



      pushMatrix();
      translate(xCentreSymetrieEcran, yCentreSymetrieEcran);
      translate(xDepart, 0);
      noFill();
      noStroke();

      for (int n=0; n<nbRepet; n++) {
        shape(triangle, 0, 0);
        rotate(angleRepet/2);
        shape(triangleMiroir, 0, 0);
        rotate(angleRepet/2);
      }
      popMatrix();
    }
  }
  
  //saveFrame("output/frame-#####.jpg");
}