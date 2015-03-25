import processing.video.*;

Capture cam;

boolean b_newFrame  = false;  // fresh-frame flag

int[] colors;
float mainY = 0;
int mainStep = 0;
int imageY = 0;
PImage colorImage;

void setup() {
  size (640, 480);
  cam = new Capture(this, 16, 12, 60); //Takes in a scaled image (if you want full resolution set this to 640 x 480)
  cam.start();
  colors = new int[width];
}

void draw() {

  cam.read();
  b_newFrame = true;
    
    if (b_newFrame) {
    colorImage = cam.get();
    colorImage.resize(width,height); //Upscales image to 640 x 480
    colorImage.updatePixels();
    println(frameRate);
    doSort();
  }
}


void doSort() {
  mainY = 0;
  mainStep = 0;
  int imageY = 280; // 280 normally   set as standard height as it doesn't need to change i think?
  //int imageY = (int)random(colorImage.height);

  for (int i=0;i<width;i++) {
    colors[i] = colorImage.get(i, imageY);
   }
    shellsort(colors);
}

/*
 * draw the values of given array as colors
 */
void drawArray(int[] array) {
  for (int i=0;i<array.length;i++) {
    stroke(array[i]);
    line(i, mainY, i, mainY+1);
  }
  mainY++;
}

// ------ shell sort             --------- //

void shellsort(int[] a)
{
  int i, j, k, h, t;
  int n = n=a.length;
  int[] cols = {
    1391376, 463792, 198768, 86961, 33936,
    13776, 4592, 1968, 861, 336, 112, 48, 21, 7, 3, 1
  };
  int steps = 0;
  for (k=0; k<16; k++)
  {
    h=cols[k];
    steps++;
    for (i=h; i<n; i++)
    {
      j=i;
      t=a[j];
      steps++;
      while (j>=h && a[j-h]>t)
      {
        a[j]=a[j-h];
        j=j-h;
        steps++;
      }
      a[j]=t;
      if(steps % 12 == 0) drawArray(a);
    }
  }
}

void mousePressed() {
  save("IMG" + (System.currentTimeMillis()/1000) + ".tif");
  print("SAVED");
}

