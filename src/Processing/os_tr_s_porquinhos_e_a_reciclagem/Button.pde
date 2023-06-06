class Button {
  float px, py;
  float width, height;
  color cor;
  String text;
  Boolean pressed = false;
  Boolean clicked = false;
  
// construtor do botão
  Button(int x, int y, int w, int h, String t, int r, int g, int b){
    px = x;
    py = y;
    width = w;
    height = h;
    cor = color(r,g,b);
    text = t;
   }
   
  void update(){
    if(mousePressed == true && mouseButton == LEFT && pressed == false) {
      pressed = true;
      
    if(mouseX >= px && mouseX <= px+width && mouseY >= py && mouseY <= py+height){
      clicked = true;
    }
    } else {
      clicked = false;
    }
    if (mousePressed != true) {
      pressed = false;
    }
  }
  
    void desenha() {
    fill(#5BBC6F);
    rectMode(CENTER);
    noStroke();
    rect(px, py, width, height, 200);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(text, px, py-4);
  }
  boolean getClicked() { // usar isto para ver se o butao esta a ser clicado
    return clicked;
  }
}
