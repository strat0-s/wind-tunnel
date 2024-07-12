// final int W = 1024;
final int N = 128;
final int iter = 16;
final int SCALE = 4;
Fluid fluid;

void setup() {
    fluid = new Fluid(0.1,0.00001,0);
    for (int i = 0;i < N;i++) {
        for (int j = 0;j < N;j++) {
            float x = i * SCALE;
            float y = j * SCALE;
            fluid.addVelocity(i,j,1,0);
        }    
    }
}

float t = 0;

void draw() {
    background(0);
    fluid.step();
    fluid.renderD();
    int o = int(((noise(t) - 0.5) * 2) * (float(N / 2)));
    for (int j = 0;j < N;j++) {
        float x = 2;
        float y = j * SCALE;
        fluid.setVelocity(2,j,1,0);
    }  
    for (int j = N / 3;j < (2 * N) / 3;j++) {
        float x = 3;
        float y = j * SCALE;
        fluid.addDensity(4,j,10);
    } 
    t += 0.03;
}

// boolean b= false;

// void mouseDragged() {
//     float v =0;
//     fluid.addDensity(mouseX / SCALE,mouseY / SCALE,100);
// }

// void mousePressed() {
//     for (int i = 0;i < N;i++) {
//         for (int j = 0;j < N;j++) {
//             float x =i * SCALE;
//             float y =j * SCALE;
//             fluid.addVelocity(i,j,0.1,0);
//         }    
//     }
// }

public void settings() {
    size(N * SCALE,N * SCALE);
}