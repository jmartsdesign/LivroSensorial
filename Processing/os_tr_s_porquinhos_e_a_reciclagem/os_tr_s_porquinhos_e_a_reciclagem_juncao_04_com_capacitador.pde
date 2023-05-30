//Os três porquinhos e a Reciclagem
// Gabriela Nogueira e Jotge Antunes

//importar as bibliotecas usadas
import processing.serial.*;
import processing.sound.*;
import cc.arduino.*;

Arduino arduino;

//configuração som
SoundFile sound01;
SoundFile backSound;

int buttonPin = 2;

//configuração do botão
boolean buttonState = false;
int potValue = 0;
boolean potActive = false;

//configuração do buzzer
int buzzerPin = 6;
boolean alarmActive = false;

//configuração do menu
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
PImage seguinte;
PImage anterior;

//imagens 1 Família e ajudar reciclar
PImage familia02;
PImage familia03;
PImage reciclar;

//imagens 2 Reciclar plástico
PImage reciclaplastico;
PImage plastico01;
 float xp = 0;
 float yp = 0;

//imagens 3 Reciclar papel
PImage reciclapapel;
PImage papel01;
PImage papelembrulhado;
       int sensorPin = 4;
       int sensorPin2 = 5;
       int numAmostras = 10; // Número de amostras para a média móvel
       int[] amostras = new int[numAmostras];
       int indiceAmostra = 0;
       int limiar = 650;  // Definir o limiar desejado aqui consoante o ambiente

//imagens 4 Reciclar vidro
PImage reciclavidro;
PImage vidro01;
PImage vidro02;
 float xv ;
 float yv ;

//imagens 5 fim da história
PImage obrigada;

// setting buttons
Button ComecarButton;



void setup() {
  size(1440, 960);
  
   // Inicializa a conexão com a placa Arduino
  arduino = new Arduino(this, Arduino.list()[0], 57600);

  // Configura o pino 2 como entrada para o botão
  arduino.pinMode(2, Arduino.INPUT);

  // Configura o pino A0 como entrada analógica para o potenciômetro
  arduino.pinMode(0, Arduino.INPUT);

  // Configura o pino 6 como saída para o buzzer
  arduino.pinMode(buzzerPin, Arduino.OUTPUT);
  
  
  ComecarButton = new Button(720, 860 , 288, 50, "Vamos Começar!", 80, 16, 169);


  //image settings 0
  capa = loadImage("data/capa.png");
  butaoinicio = loadImage("data/butaoinicio.png");
  font = createFont("Itim", 35);
  seguinte = loadImage("data/arrowseguinte.png");
  anterior = loadImage("data/arrowanterior.png");
  backSound = new SoundFile(this, "musicafundo.mp3");

  //chamada das imagens para momento 1
  familia02 = loadImage("data/familia02.png"); 
  
  //chamada das imagens para o momento 2
  familia03 = loadImage("data/familia03.png");
  
  //chamada das imagens para o momento 3 (reciclar plastico)
  reciclar = loadImage("data/Reciclar.png");
   plastico01 = loadImage("data/plastico01.png");

  //chamada das imagens para o momento 2
  reciclaplastico = loadImage("data/reciclarplastico.png");
   papel01 = loadImage("data/papel01.png");
   papelembrulhado = loadImage("data/papelembrulhado.png");
   //pinos do capacitativo
     arduino.pinMode(sensorPin, Arduino.INPUT);
     arduino.pinMode(sensorPin2, Arduino.INPUT);
   
  //chamada das imagens para o momento 3 (reciclar vidro)
  reciclapapel = loadImage("data/reciclarpapel.png");
   sound01 = new SoundFile(this, "glass.mp3");
   

  //chamada das imagens para o momento 4
  reciclavidro = loadImage("data/reciclarvidro.png");
   vidro01 = loadImage("data/vidro01.png");
   vidro02 = loadImage("data/vidro02.png");
  
  //chamada das imagens para o momento 5 final da história
  obrigada = loadImage("data/obrigada.png");

}

void draw() {
  background(255);
  imageMode(CENTER);

  switch(menu) {
  case 0:
    {
      image(capa, width/2, height/2);
      textFont(font);
      ComecarButton.update();
      ComecarButton.desenha();

      if (ComecarButton.getClicked()) {
        backSound.play();
        menu=1;
      }
    }
    break;

  case 1: //familia
    {
      image(familia02, width/2, height/2);
      
      fill(0);
      textFont(font);
      text("Todos os fins de semana, a família Oliveira", 700, 100); 
      text("vai até ao parque da cidade onde moram", 700, 140);
      text("para fazer o seu piquenique.", 700, 180);

//imagem das setas 
      image(seguinte, width-100, height-70);
      image(anterior, 100, height-70);
     
    }
    break;

  case 2: //segundo momento da familia
    {
      image(familia03, width/2, height/2);
      
      fill(0);
      textFont(font);
      text("No final, cada filho é responsável por ajudar", 700, 100); 
      text("os pais na RECICLAGEM do lixo que fizeram", 700, 140);
      
      //imagem das setas 
      image(seguinte, width-100, height-70);
      image(anterior, 100, height-70);

    }
    break;

  case 3: //momento da pergunta
    {
      image(reciclar, width/2, height/2);
      
      //imagem das setas 
      image(seguinte, width-100, height-70);
      image(anterior, 0+100, height-70);

    }
    break;




  case 4: //Momento de reciclagem do plástico
    {
      image(reciclaplastico, width/2, height/2);
      fill(0);
      textFont(font);
      text("Ajuda a girar o plástico para o contentor!", 700, 100); 
      
        // Lê o estado do botão no pino 2
  int buttonValue = arduino.digitalRead(2);

  // Se o botão for pressionado, atualiza o estado do botão e desativa o potenciômetro
  if (buttonValue == Arduino.LOW ) {

    buttonState = true;
    potActive = true;
  }
      //chamada da função do potenciometro
  
      potValue = arduino.analogRead(0);

  // Desenha um quadrado quando o botão não está pressionado
  if (!buttonState) {
    image(plastico01,xp,yp);
  }

  // Rotação do quadrado controlada pelo potenciômetro
  if (potActive) {
    if (potValue >= 0) {
      float rotation = map(potValue, 0, 1023, 0, TWO_PI);
      
      translate(width/2, height/2);
      rotate(rotation);
      image(plastico01,xp,yp);}
      
      if (potValue >=930){
       xp = + 450;
       plastico01.resize(40,90);}
       
       if (potValue >= 1010){
        delay(1800);
        menu = 5;}
        } 

///RESTRIÇÃO - ativação do buzzer quando a criança clicka no ação errada          
       if (buttonValue == Arduino.HIGH) {
           buttonState = true;
          arduino.analogWrite(buzzerPin, 1255);// Ligar o buzzer com uma frequência alta
          delay(50);
          arduino.analogWrite(buzzerPin, 0); // Desligar o buzzer
          delay(50);}

     // } else if (potValue < 1023) {
       // alarmActive = false;
     // }
//else {
      // Retorna à posição inicial se o valor do potenciômetro for inferior a 50
    //  image(plastico01,0,0);
   // }
  }
      
    break;

  case 5: // Momento da reciclagem do Papel
    {  image(reciclapapel, width/2, height/2);
       fill(0);
       textFont(font);
       text("Ajuda a esmagar o papel!", 700, 100); 
    
     int buttonValue = arduino.digitalRead(2);
    
    //Settings do capacitador
     int valorSensor = arduino.analogRead(sensorPin); // Lê o valor do sensor
     int valorSensor2 = arduino.analogRead(sensorPin2); // Lê o valor do segundo sensor
  
  // Adiciona a amostra atual ao array
     amostras[indiceAmostra] = valorSensor;
     indiceAmostra = (indiceAmostra+1) % numAmostras;
  
  // Calcula a média das amostras
     float media = 0;
        for (int i = 0; i < numAmostras; i++) {
        media += amostras[i];
       }
       media /= numAmostras;
  
  if (media < limiar && valorSensor2 < limiar) {
      image(papel01, width/2, height/2);
  } else {
      image(papelembrulhado, width/2+400, height/2);
      menu = 6;
      delay(2000);}
      
      
    
    
    
  // Lê o estado do botão no pino 2
  // Se o botão for pressionado, atualiza o estado do botão e desativa o potenciômetro
  if (buttonValue == Arduino.LOW ) {

    buttonState = true;}             
      
     
///RESTRIÇÃO - ativação do buzzer quando a criança clicka no ação errada          
       if (buttonValue == Arduino.HIGH) {
           buttonState = true;
          arduino.analogWrite(buzzerPin, 1255);// Ligar o buzzer com uma frequência alta
          delay(50);
          arduino.analogWrite(buzzerPin, 0); // Desligar o buzzer
          delay(50);}

    }
    break;

  case 6: //Momento de Reciclar o Vidro
    {
      image(reciclavidro,width/2,height/2);
       fill(0);
       textFont(font);
       text("Ouve o som do vidro a cair no vidrão!", 700, 100); 
      xv = width/2;
      yv = height/2;

      //função do botão
       // Lê o estado do botão no pino 2
        int buttonValue = arduino.digitalRead(2);
        
        
      // Se o botão for pressionado, atualiza o estado do botão e desativa o potenciômetro
        if (buttonValue == Arduino.LOW ) {
        
        image(vidro01, xv, yv);

        buttonState = true;
        potActive = true;
        

      }

      // Se o botão for solto, atualiza o estado do botão e ativa o potenciômetro
        if (buttonValue == Arduino.HIGH ) {

           buttonState = true;
           
           image(vidro02,width/2+400, height/2);
           
           delay(200);
           sound01.play();}
            else {
             image(seguinte, width-100, height-70);}

       

      }
    break;
    
  case 7: // Final da História
    {
      image(obrigada, width/2, height/2);
    }
    break;
  }
}

void mousePressed() {

   if (mouseX <= 150 && mouseX >= 0 && menu>0 && mouseY <= height && mouseY >= height-100){
     menu = menu-1; }
    
    if (mouseX <= width && mouseX >= width-150 && mouseY <= height && mouseY >= height-100){
      menu = menu+1; }
           if (menu >7){
            menu = 0;}
}
