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
    bubbleSort(colors);
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

// ------ bubble sort             --------- //
public void bubbleSort(int[] a)
{
  int out, in;
  int nElems = a.length;
  int counts = 0;
  for(out=nElems-1; out>1; out--) {

    for(in=0; in<out; in++) {
      if( a[in] > a[in+1] ) {
        swap(a, in, in+1);
      }
    }
    if(counts++%29>=0) drawArray(a);
  }
}

private void swap(int[] a, int one, int two)
{
  int temp = a[one];
  a[one] = a[two];
  a[two] = temp;
}
