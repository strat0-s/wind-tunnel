import controlP5.*;

final int WIDTH = 1280;
final int HEIGHT = 720;
final int N = 256;
final int iter = 32;
final int SCALE = WIDTH / N;
Fluid fluid;

ControlP5 cp5;
Slider diffusionSlider;
Slider viscositySlider;

public void settings() {
    size(WIDTH,HEIGHT);
}

void setup() {
    fluid = new Fluid(0.1,0.000001,0);
    // for (int i = 0;i < N;i++) {
    //     for (int j = 0;j < N;j++) {
    //         fluid.addVelocity(i,j,0.08,0);
    //     }    
// }
    
    cp5 = new ControlP5(this);
    
    diffusionSlider = cp5.addSlider("Diffusion")
       .setPosition(0, 0)
       .setSize(100, 20)
       .setRange(0, 0.01)
       .setValue(fluid.diff)
       .setColorForeground(color(255, 0, 0)) 
       .setColorBackground(color(0, 0, 255)) 
       .setColorActive(color(0, 255, 0));
    diffusionSlider.getCaptionLabel().setColor(color(255));
    
    viscositySlider = cp5.addSlider("Viscosity")
       .setPosition(WIDTH - 120, 40)
       .setSize(100, 20)
       .setRange(0, 0.01)
       .setValue(fluid.visc)
       .setColorForeground(color(255, 0, 0)) // Red foreground
       .setColorBackground(color(0, 0, 255)) // Blue background
       .setColorActive(color(0, 255, 0)); // Green active
    viscositySlider.getCaptionLabel().setColor(color(255));
}

float t = 0;

void draw() {
    background(0);
    
    translate(WIDTH / 2 - (N * SCALE) / 2, HEIGHT / 2 - (N * SCALE) / 2);
    
    fluid.step();
    fluid.renderD();
    renderObstacleCircle();
    
    fluid.diff = diffusionSlider.getValue();
    fluid.visc = viscositySlider.getValue();
    
    // int o = int(((noise(t) - 0.5) * 2) * (float(N / 2)));
    for (int x = 10; x < 20;x ++)
        for (int j = N / 3;j < (2 * N) / 3;j++) {
            // int x = 20;
            float y = j * SCALE;
            fluid.setVelocity(x,j,0.1,0);
        fluid.addDensity(x,j,10);
    }  
    
    t += 0.03;
    
    cp5.draw();
}

void mouseDragged() {
    if (mouseButton == LEFT) {
        ox = int((mouseX - (WIDTH / 2 - (N * SCALE) / 2)) / SCALE);
        oy = int((mouseY - (HEIGHT / 2 - (N * SCALE) / 2)) / SCALE);
        
        // Ensure the obstacle stays within bounds
        ox = constrain(ox, 0, N - ow);
        oy = constrain(oy, 0, N - oh);
        
        cx = int((mouseX - (WIDTH / 2 - (N * SCALE) / 2)) / SCALE);
        cy = int((mouseY - (HEIGHT / 2 - (N * SCALE) / 2)) / SCALE);
        
        // Ensure the obstacle stays within bounds
        cx = constrain(cx, 0, N - cr);
        cy = constrain(cy, 0, N - cr);
        
        
    }
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