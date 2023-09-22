import processing.pdf.*;

void setup() {
  size(1400, 900);
  //beginRecord(PDF, "fuzzy_worm_collatz.pdf");
  background(0);

  // set sim parameters
  float len = 8;
  float angle = PI/40;
  //float angle = PI/4;
  int steps = 50000;

  for (int i = 1; i < steps; i++) {
    IntList seq = new IntList();
    int n = i;
    int c = 0; //counts even numbers
    do {
      seq.append(n);
      int[] buffer = collatzFunc(n, c);
      n = buffer[0];
      c = buffer[1];
    } while (n != 1);
    seq.append(1);
    seq.reverse();

    resetMatrix();
    translate(width*0.05, height*0.7);
    //translate(width*0.5, height*0.99);
    for (int j = 0; j < seq.size(); j++) {
      int val = seq.get(j);
      if ((val % 2) == 0) {
        rotate(-angle);
      } else {
        rotate(angle);
      }
      // set colors
      int blue = int(map(val, 1, seq.max(), 0, 350));
      int green = int(map(c, seq.size()/2, seq.size(), 0, 500));
      int red = int(map(j, seq.size(), 0, 20, 300));

      stroke(red, green, blue, 20);
      strokeWeight(1.5);
      line(0, 0, 0, -len);
      translate(0, -len);
    }
  }
  endRecord();
}

int[] collatzFunc(int n, int c) {
  int[] temp = new int[2];
  if (n % 2 == 0) {
    temp[0] = n / 2;
    temp[1] = c + 1;
    return temp;
  } else {
    temp[0] = (n * 3 + 1) / 2;
    temp[1] = c;
    return temp;
  }
}
