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
  insertionSort(colors);
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

// ------ insertion sort             --------- //

void insertionSort(int[] arr) {
  int i, j, newValue;
  int counts = 0;
  for (i = 1; i < arr.length; i++) {
    newValue = arr[i];
    j = i;
    while (j > 0 && arr[j - 1] > newValue) {
      arr[j] = arr[j - 1];
      j--;
    }
    arr[j] = newValue;
    if (mainStep++%29>=0) drawArray(arr);
  }
}

private void swap(int[] a, int one, int two)
{
  int temp = a[one];
  a[one] = a[two];
  a[two] = temp;
}

void mousePressed() {
  save("IMG" + (System.currentTimeMillis()/1000) + ".tif");
  print("SAVED");
}

