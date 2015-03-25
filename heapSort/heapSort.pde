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
    heapSort(colors);
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

// heapsort
void sift (int[] a, int l, int r) { 
  int i, j;
  int x;
  i = l; 
  x = a[l];
  j = 2*i+1;
  if ((j<r) && (a[j+1]<a[j])) j++;
  while ((j<=r) && (a[j] < x)) {
    a[i] = a[j];
    i    = j; 
    j    = j*2+1;
    if ((j<r) && (a[j+1]<a[j])) j++;
  }
  a[i] = x;
}

// ------ heap sort             --------- //
void heapSort (int[] a) { 
  int l,r,n,tmp;
  n = a.length;
  for (l=(n-2)/2; l>=0; l--)
      sift(a,l,n-1);
  for (r=n-1; r>0; r--) {
    tmp  = a[0];
    a[0] = a[r];
    a[r] = tmp;
    sift(a, 0, r-1);
    if(mainStep++%29>=0)drawArray(a);
  }
}

void mousePressed() {
  save("IMG" + (System.currentTimeMillis()/1000) + ".tif");
  print("SAVED");
}

