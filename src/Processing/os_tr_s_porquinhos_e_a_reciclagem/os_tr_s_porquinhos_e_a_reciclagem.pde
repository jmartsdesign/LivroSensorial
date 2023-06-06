//Os três porquinhos e a Reciclagem
// Gabriela Nogueira e Jotge Antunes


int menu=0;

/*
 0 capa da história
 1 Família e ajudar reciclar
 2 Reciclar plástico
 3 Reciclar papel
 4 Reciclar vidro
 5 Fim da História
 */

//font para texto
PFont font;

//imagens para 0 capa da História
PImage capa;
PImage butaoinicio;

//imagens 1 Família e ajudar reciclar
PImage familia02;
PImage familia03;
PImage reciclar;

//imagens 2 Reciclar plástico
PImage reciclaplastico;

//imagens 3 Reciclar papel
PImage reciclapapel;

//imagens 4 Reciclar vidro
PImage reciclavidro;

//imagens 5 fim da história
PImage obrigada;

// setting buttons
Button0 ComecarButton;



void setup() {
  size(1440, 960);
  
  ComecarButton = new Button0(720, 860 , 288, 50, "Vamos Começar!", 80, 16, 169);


  //image settings 0
  capa = loadImage("data/capa.png");
  butaoinicio = loadImage("data/butaoinicio.png");
  font = createFont("Itim", 35);

  //chamada das imagens para momento 1
  familia02 = loadImage("data/familia02.png"); 
  
  //chamada das imagens para o momento 2
  familia03 = loadImage("data/familia03.png");
  
  //chamada das imagens para o momento 3
  reciclar = loadImage("data/Reciclar.png");


  //chamada das imagens para o momento 2
  reciclaplastico = loadImage("data/reciclarplastico.png");
  
  //chamada das imagens para o momento 3
  reciclapapel = loadImage("data/reciclarpapel.png");

  //chamada das imagens para o momento 4
  reciclavidro = loadImage("data/reciclarvidro.png");
  
  //chamada das imagens para o momento 5 final da história
  obrigada = loadImage("data/obrigada.png");

}

void draw() {
  background(255);

  switch(menu) {
  case 0:
    {
      image(capa, 0, 0);
      textFont(font);
      ComecarButton.update();
      ComecarButton.desenha();

      if (ComecarButton.getClicked()) {
        menu=1;
      }
    }
    break;

  case 1: //familia
    {
      image(familia02, 0, 0);
      
      fill(0);
      textFont(font);
      text("Todos os fins de semana, a família Oliveira", 700, 100); 
      text("vai até ao parque da cidade onde moram", 700, 140);
      text("para fazer o seu piquenique.", 700, 180);


    }
    break;

  case 2: //segundo momento da familia
    {
      image(familia03, 0, 0);
      
      fill(0);
      textFont(font);
      text("No final, cada filho é responsável por ajudar", 700, 100); 
      text("os pais na RECICLAGEM do lixo que fizeram", 700, 140);

    }
    break;

  case 3: //momento da pergunta
    {
      image(reciclar, 0, 0);

    }
    break;




  case 4: //Momento de reciclagem do plástico
    {
      image(reciclaplastico, 0, 0);
      
   //   a.desenha();
   //   a.meta();

   //   for (Obstaculos obstaculo : o) {
   //     obstaculo.desenha();
   //     obstaculo.movimento();
        
      //o que acontece quando a personagem colide com um obstáculo    
   //     if (a.colide(obstaculo)) {
          //personagem volta á posição inicial e tempo volta a contar do 0
   //       a = new Personagem();
   //       gameTime = new Timer(0);
          //perde vida  
   //       if (vida > 1){
   //       vida --;}
   //       else {
   //         menu=4;
   //         vida = 3;}
          
   //     }
   //   }

    }
    break;

  case 5: // Momento da reciclagem do Papel
    {
      image(reciclapapel, 0, 0);
      
   //   a.desenha();
   //   a.meta();
      
   //   for (Obstaculos obstaculo : o) {
   //     obstaculo.desenha();
   //     obstaculo.movimento();

      //o que acontece quando a personagem colide com um obstáculo  
   //     if (a.colide(obstaculo)) {
         //personagem volta á posição inicial e tempo volta a contar do 0
   //       a = new Personagem();
   //       gameTime = new Timer(0);
          //função vida 
   //       if (vida > 1){
   //       vida --;}
   //       else {
   //         menu = 4;
   //         vida = 3;}
   
   //     }
   //   }
     

    }
    break;

  case 6: //Momento de Reciclar o Vidro
    {
      image(reciclavidro,0,0);
      
   //   BackButton2.update();
   //   BackButton2.desenha();
      
   //    if ( BackButton2.getClicked()) {
   //     menu=0;
   //   }
      }
    break;
    
  case 7: // Final da História
    {
      image(obrigada, 0, 0);
    }
    break;
  }
}

void mousePressed() {

   if (mouseX <= width && mouseX >= 0 || mouseY >= 0 && mouseY <= height){
     menu = menu+1; }
   if (menu >7){
     menu = 0;}
}
