import java.util.LinkedList;

MidiForProcessing midi = new MidiForProcessing("bus 1");

int h = 500;
int w = 1000;
int pointCount = 150;
int connectionRadius = 100;
LinkedList<Node> nodes = new LinkedList<Node>();

class Node {
  public float x;
  public float y;
  public PVector position;
  public boolean calculated = false;
 
   Node(float x, float y) {
     this.x = x;
     this.y = y;
     this.position = new PVector(x, y);
   }
   
   public void draw() {
     stroke(255);
     ellipse(this.x, this.y, 1, 1);
   }
   
   public void drawLines(PVector v1, Node n) {
     float r = (float) connectionRadius;
     
     for (Node node : nodes) {
       if (!node.equals(n)) {
         PVector v2 = node.position;
         float d = PVector.dist(v1, v2);
         if (d <= connectionRadius) {
          strokeWeight(1);
          float strokeColor = (145.0 / (d / r));
          stroke(strokeColor);
          line(v1.x, v1.y, v2.x, v2.y);
          stroke(255);
          fill(0);
          ellipse(v1.x, v1.y, 1, 1);
         }
       }
     }
   }
}

void setup() {
  for (int i = 0; i < pointCount; i++) {
    nodes.add(new Node(random(w), random(h)));
  }
  
  frameRate(60);
  background(100);
  size(1000, 500);
  
  for (Node node : nodes) {
    PVector v1 = node.position;
    node.draw();
    node.drawLines(v1, node);
  }
}

void draw() {
  for (Node node : nodes) {
    PVector v1 = nodes.get(0).position;
    PVector v2 = nodes.get(0).position;
    float d = PVector.dist(v1, v2);
    if (d <= connectionRadius) {
      stroke(100);
      fill(100);
      ellipse(v1.x, v1.y, 4, 4);
      strokeWeight(4);
      line(v1.x, v1.y, v2.x, v2.y);
      node.calculated = false;
    }
  }
  nodes.remove();
  nodes.add(new Node(random(w), random(h)));
  
  for (Node node : nodes) {
    PVector v1 = node.position;
    if (node.calculated == false) {
        node.draw();
        node.drawLines(v1, node);
        node.calculated = true;
    }
  }
}