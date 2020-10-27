/*
Nombre: Calculadora de Energía de Combustión.
Desarrolladores: Manuel Barrera.
Contacto:Twitter/Instagram: @hadachantel.
Fecha de creación:21/10/2020.
Última fecha de modificación: 24/10/2020.
Versión actual: 0.0.3
Licencia: CC-BY-SA 4.0.
"Docendo discimus" - Séneca.
*/

final static String titulo = "Calculadora de Energía de Combustión v0.0.3";  // Título de la ventana.

import gifAnimation.*;
PFont multicolore, easycre, arialnarrow, gravity, comfortaa, california;       // Declaración de objetos de la clase PFont.
PImage corazon, licencia, icono;
Gif planta2;

int ancho = 800;      // Ancho de la ventana.
int alto = 500;       // Alto de la ventana.

String carbono = "";      // Almacena el texto de los átomos de carbono.
String hidrogeno = "";    // Almacena el texto de los átomos de hidrógeno.
String oxigeno = "";      // Almacena el texto de los átomos de oxígeno.
String entalpiaf = "";    // Almacena el texto de la entalpía del compuesto.
String masa = "";         // Almacena el texto de la masa del compuesto.
String Ho2 = "0";         // Almacena el texto de la entalpía de formación del oxígeno.
String Hco2 = "";         // Almacena el texto de la entalpía de formación del dióxido de carbono.
String Hh2o = "";         // Almacena el texto de la entalpía de formación del agua.
String masaAtomC = "";    // Almacena el texto de la masa atómica del carbono.
String masaAtomH = "";    // Almacena el texto de la masa atómica del hidrógeno.

int c;                  // Almacena la parte numérica del carbono.
int h;                  // Almacena la parte numérica del hidrógeno.
int o;                  // Almacena la parte numérica del oxígeno.
float AHf;              // Almacena la parte numérica de la entalpìa de formación del combustible.
float m;                // Almacena la parte numérica de la masa.
float o2;               // Almacena la parte numérica de la entalpía de formación del oxígeno.
float co2;              // Almacena la parte numérica de la entalpía de formación del dióxido de carbono.
float h2o;              // Almacena la parte numérica de la entalpía de formación del agua.
float mAtC;             // Almacena la parte numérica de la masa atómica del carbono.
float mAtH;             // Almacena la parte numérica de la masa atómica del hidrógeno.
float AHr;              // Almacena la parte numérica de la entalpía de racción.
float moles;            // Guarda el número de moles del compuesto analizado.

int numControl;         // Número de control (para el seleccionador).

String version;


void setup()
{
  size(800, 500);         // Ventana de 700 px por 400 px.
  
  multicolore = loadFont("Multicolore-48.vlw");      // Se carga la fuente "Multicolore-48.vlw" y se asigna a multicolore.
  easycre = loadFont("easy_cre-48.vlw");             // Se carga la fuente "easy_cre-48.vlw" y se asigna a easycre.
  arialnarrow = loadFont("ArialNarrow-24.vlw");      // Se carga la fuente "ArialNarrow-24.vlw" y se asigna a arialnarrow.
  gravity = loadFont("Gravity-Regular-14.vlw");      // Se carga la fuente "Gravity-Regular-14.vlw" y se asigna a gravity.
  comfortaa = loadFont("Comfortaa-Bold-24.vlw");     // Se carga la fuente "Comfortaa-Bold-24.vlw" y se asigna a comfortaa.
  california = loadFont("CaliforniaPersonalUse-24.vlw");
  
  corazon = loadImage("corazon.png");
  licencia = loadImage("licencia.png");
  icono = loadImage("icono.png");
  
  planta2 = new Gif(this, "planta2.gif");
  planta2.play();
  
  imageMode(CENTER);
  
  // Inicialización de las variables globales a cero.
  numControl = 0;
  c = 0;
  h = 0;
  o = 0;
  AHf = 0;
  m = 0;
  o2 = 0;
  co2 = 0;
  h2o = 0;
  mAtC = 0;
  mAtH = 0;
  AHr = 0;
  moles = 0;
  
  version = "0.0.3";    // Sigue siendo una Alpha.
  
  surface.setIcon(icono);    // Cambia el ícono del programa;
  surface.setTitle(titulo);  // Cambia el título del programa;
}

void draw()
{
  frameRate(60);                  // 60 fps.
  background(237, 242, 239);      // Color del fondo.
  balanceo(carbono,hidrogeno,oxigeno,entalpiaf);    // Llamado de la función sin retorno cajaDatos(). Es visualizada.
  fill(87, 196, 229);             // Color del relleno de letras y formas.
  textFont(multicolore);          // Fuente multicolore seleccionada.
  textAlign(CENTER);              // Alineación del texto CENTER.
  textSize(24);                   // Tamaño de la letra 24.
  text("Calculadora de Energía de Combustión",ancho/2,30);        // Título.
  cajaDatos();                                                    // Llamado de la función sin retorno cajaDatos(). Es visualizada.
  
  textFont(california);      // Fuente de letra.
  textAlign(LEFT);           // Texto alineado LEFT.
  textSize(13);              // Tamaño de letra 13.
  fill(150,150,150,250);     // Color de relleno de letras y formas.
  text("Programado con       por Manuel Barrera",65+430,490);    // Yo, el autor <3.
  image(corazon,192+430,488,17,17);        // Se visualiza la imagen de un corazón.
  tint(255,160);                           // Se mantiene el color de la imagen, pero cambia su transparencia.
  image(licencia,48,484,88*0.8,31*0.8);    // Se visualiza la imagen de la licencia CreativeCommons BY-SA, a la cual esta sujeta este programa.
  
  textFont(gravity);
  text("Versión " + version,86,494);
  /*
  // Visualización del las coordenas ddel mouse.
  String coordenadas = "x: " + mouseX + " y: " + mouseY;
  fill(0);
  textSize(15);
  text(coordenadas, mouseX, mouseY);
  */
}



// # * # * # * # * # * # * # * # * #   F U N C I O N E S   # * # * # * # * # * # * # * # * # * # * # * #
void cajaDatos()
{
  textFont(easycre);                       // Fuente easycre seleccionada.
  textSize(30);                            // Tamaño de la letra 30.
  text("Ingresa los datos",110,70);
  noStroke();
  fill(7, 160, 195,200);      // Color de la caja.
  rect(18,80,180,350);
  textFont(arialnarrow);
  textSize(14);
  fill(38,38,38);
  stroke(38,38,38);
  
  textAlign(RIGHT);      // Átomos de carbono.
  text("C:",75,110);
  textAlign(LEFT);
  text(carbono,77,110);
  
  textAlign(RIGHT);      // Átomos de hidrógeno.
  text("H:",75,140);
  textAlign(LEFT);
  text(hidrogeno,77,140);
  
  textAlign(RIGHT);      // Átomos de oxígeno.
  text("O:",75,170);
  textAlign(LEFT);
  text(oxigeno,77,170);
  
  textAlign(RIGHT);      // Entalpía de formación del combustible.
  text("Entalpía:",75,200);
  textAlign(LEFT);
  text(entalpiaf + " kJ/mol",77,200);
  
  textAlign(RIGHT);      // Masa del combustible.
  text("Masa:",75,230); 
  textAlign(LEFT);
  text(masa + " g",77,230);
  
  textAlign(RIGHT);      // Entalpía de formación del oxígeno.    
  text("H   O   :",75,260);
  textSize(10);
  text("2",70,260);
  text("f",52,260);
  text("°",53,256);
  noFill();
  triangle(30,245,24,258,36,258);
  textSize(14);
  fill(38,38,38);
  textAlign(LEFT);
  text(Ho2 + " kJ/mol",77,260);
  
  textAlign(RIGHT);        // Entalpía de formación del dióxido de carbono.
  text("H  CO   :",75,290);
  textSize(10);
  text("2",70,290);
  text("f",45,290);
  text("°",47,286);
  noFill();
  triangle(30,275,24,288,36,288);
  textSize(14);
  fill(38,38,38);
  textAlign(LEFT);
  text(Hco2 + " kJ/mol",77,290);
  
  textAlign(RIGHT);        // Entalpía de formación del agua.
  text("H  H   O:",75,320);
  textSize(10);
  text("2",62,320);
  text("f",45,320);
  text("°",47,316);
  noFill();
  triangle(30,305,24,318,36,318);
  textSize(14);
  fill(38,38,38);
  textAlign(LEFT);
  text(Hh2o + " kJ/mol",77,320);
  
  textAlign(RIGHT);        // Masa atómica del carbono.
  text("Masa atómica C:",105,350);
  textAlign(LEFT);
  text(masaAtomC + " u",107,350);
  
  textAlign(RIGHT);        // Masa atómica del hidrógeno.
  text("Masa atómica H:",105,380);
  textAlign(LEFT);
  text(masaAtomH + " u",107,380);
  
  fill(209, 214, 70);
  stroke(209, 214, 70);
  
  if(numControl == 0)
  {
    textAlign(RIGHT);
    text("C:",75,110);
  }
  else if(numControl == 1)
  {
    textAlign(RIGHT);
    text("H:",75,140);
  }
  else if(numControl == 2)
  {
    textAlign(RIGHT);
    text("O:",75,170);
  }
  else if(numControl == 3)
  {
    textAlign(RIGHT);
    text("Entalpía:",75,200);
  }
  else if(numControl == 4)
  {
    textAlign(RIGHT);
    text("Masa:",75,230);
  }
  else if(numControl == 5)
  {
    textAlign(RIGHT);      // Entalpía de formación del oxígeno.    
    text("H   O   :",75,260);
    textSize(10);
    text("2",70,260);
    text("f",52,260);
    text("°",53,256);
    noFill();
    triangle(30,245,24,258,36,258);
  }
  else if(numControl == 6)
  {
    textAlign(RIGHT);        // Entalpía de formación del dióxido de carbono.
    text("H  CO   :",75,290);
    textSize(10);
    text("2",70,290);
    text("f",45,290);
    text("°",47,286);
    noFill();
    triangle(30,275,24,288,36,288);
  }
  else if(numControl == 7)
  {
    textAlign(RIGHT);        // Entalpía de formación del agua.
    text("H  H   O:",75,320);
    textSize(10);
    text("2",62,320);
    text("f",45,320);
    text("°",47,316);
    noFill();
    triangle(30,305,24,318,36,318);
  }
  else if(numControl == 8)
  {
    textAlign(RIGHT);        // Masa atómica del carbono.
    text("Masa atómica C:",105,350);
  }
  else if(numControl == 9)
  {
    textAlign(RIGHT);        // Masa atómica del hidrógeno.
    text("Masa atómica H:",105,380);
  }
  fill(38,38,38);
  stroke(38,38,38);
}

void keyPressed()
{
  if(key == CODED)                      // Seleccionador (carbono, hidrógeno, oxígeno, entalpía y masa).
  {
    if(keyCode == DOWN)
    {
      if(numControl == 9)
      {
        numControl = 0;
      }
      else
      {
        numControl = numControl + 1;
      }
    }
    else if(keyCode == UP)
    {
      if(numControl == 0)
      {
        numControl = 9;
      }
      else
      {
        numControl = numControl - 1;
      }
    }
    else if(keyCode == LEFT)
    {
      if(numControl == 0)
      {
        carbono = "";
      }
      else if(numControl == 1)
      {
        hidrogeno = "";
      }
      else if(numControl == 2)
      {
        oxigeno = "";
      }
      else if(numControl == 3)
      {
        entalpiaf = "";
      }
      else if(numControl == 4)
      {
        masa = "";
      }
      else if(numControl == 6)
      {
        Hco2= "";
      }
      else if(numControl == 7)
      {
        Hh2o = "";
      }
      else if(numControl == 8)
      {
        masaAtomC = "";
      }
       else if(numControl == 9)
      {
        masaAtomH = "";
      }
    }
  }
  
  else if ((numControl == 0) && (carbono.length() < 3))      // Para agregar los datos del carbono.
  {
    if ((key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      carbono = carbono + key;
    }
  }
  
  else if ((numControl == 1) && (hidrogeno.length() < 3))    // Para agregar los datos del hidrógeno.
  {
    if ((key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      hidrogeno = hidrogeno + key;
    }
  }
  
  else if ((numControl == 2) && (oxigeno.length() < 3))      // Para agregar los datos del oxígeno.
  {
    if ((key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      oxigeno = oxigeno + key;
    }
  }
  
  else if ((numControl == 3) && (entalpiaf.length() < 10))    // Para agregar los datos de la entalpía.
  {
   if ((key == '.') || (key == '-') || (key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      entalpiaf = entalpiaf + key;
    } 
  }
  
  else if ((numControl == 4) && (masa.length() < 10))        // Para agregar los datos de la masa.
  {
   if ((key == '.') || (key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      masa = masa + key;
    }
  }
  
  else if ((numControl == 6) && (Hco2.length() < 10))        // Para agregar los datos de entalpía del dióxido de carbono.
  {
   if ((key == '.') || (key == '-') || (key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      Hco2 = Hco2 + key;
    }
  }
  
  else if ((numControl == 7) && (Hh2o.length() < 10))        // Para agregar los datos de entalpía del dióxido de carbono.
  {
   if ((key == '.') || (key == '-') || (key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      Hh2o = Hh2o + key;
    }
  }
  
  else if ((numControl == 8) && (masaAtomC.length() < 10))        // Para agregar los datos de entalpía del dióxido de carbono.
  {
   if ((key == '.') || (key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      masaAtomC = masaAtomC + key;
    }
  }
  
  else if ((numControl == 9) && (masaAtomH.length() < 10))        // Para agregar los datos de entalpía del dióxido de carbono.
  {
   if ((key == '.') || (key == '0') || (key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '6') || (key == '7') || (key == '8') || (key == '9'))
    {
      masaAtomH = masaAtomH + key;
    }
  }
}


// ======================================= F U N C I Ó N    B A L A N C E O ======================================
void balanceo(String car, String hid, String oxi, String ent)
{
  textFont(comfortaa);
  c = int(car);      // Conversión a entero y asignación.
  h = int(hid);      // Conversión a entero y asignación.
  o = int(oxi);      // Conversión a entero y asignación.
  AHf = float(ent);  // Conversión a flotante y asignación.
  
  
  int cFijo = 1;      // Constantes Carbono del producto sin balancear.
  int hFijo = 2;      // Constantes Hidrógeno del producto sin balancear.
  int oFijo = 2;      // Constantes Oxígeno del producto sin balancear.
  int oFijoPro = 3;   // Total de oxígenos en el producto.
  
  int cR = 1;      // Carbono del producto sin balancear.
  //int hR = 1;      // Hidrógeno del producto sin balancear.
  int oR = 1;      // Oxígeno del producto sin balancear.
  
  int cP = 1;
  int hP = 1;
  //int oP = 1;
  
  // ######## C o m p u e s t o s   q u e   c o n t i e n e n   o x í g e n o ########
  if(o != 0)
  {
    background(244, 203, 198);
    textAlign(LEFT);
    fill(38,38,38);
    image(planta2,300,300);
    text("El programador está trabajando en ello \n             ¡Pronto estará disponible!",240,150);
    //text("C  H  0  =>   C02  + H20",508,70);
  }
  
  // ######## C o m p u e s t o s   q u e   n o   c o n t i e n e n   o x í g e n o ########
  else
  {
    // ******** E c u a c i ó n   s i n   b a l a n c e a r ********
    textAlign(LEFT);          // Texto alineado LEFT.
    textSize(16);             // Tamaño de la letra 16.
    fill(38,38,38);           // Color del relleno de letras y formas.
    text("Ecuación sin balancear",230,50);            // Título.
    text("C      H      + O   > CO + H  O",215,70);   // Ecuación sin balancear.
    text("_",334,64);                                 // Palito de la flecha XD.
    textSize(13);             // Tamaño de la letra 13.
    text(str(c),228,75);      // Subíndice del carbono. (Reactivo).
    text(str(h),269,75);      // Subíndice del hidrógeno. (Reactivo).
    text("2",324,75);         // Subíndice del oxígeno del O2 (Reactivo).
    text("2",379,75);         // Subíndice del oxígeno del CO2 (Producto).
    text("2",412,75);         // Subíndice del hidrógeno del H2O (Producto).
    
    // ******** T a b l a   s i n   b a l a n c e a r ********
    textAlign(CENTER);        // Texto alineado CENTER.
    textSize(12);             // Tamaño de letra 12.
    text("Reactivos       Elemento       Productos",330,89); 
    textSize(15);             // Tamaño de la letra 15.
    rect(215,95,232,0.5);     // Línea decorativa.
    text("C",330,112);     // Carbonos sin balancear.
    text(carbono,245,112); // Carbonos reactivo.
    text(cFijo,413,112);   // Carbonos producto.
    text("H",330,128);         // Hidrógenos sin balancear.
    text(hidrogeno,245,128);   // Hidrógenos reactivo.
    text(hFijo,413,128);       // Hidrogénos producto.
    text("O",330,144);      // Oxígenos sin balancear.
    text(oFijo,245,144);    // Oxígenos reactivo.
    text(oFijoPro,413,144); // Oxígenos producto.
    rect(215,150,232,0.5);     // Línea decorativa.
    
    
    // ******* B a l a n c e o ********
    cP = c * cFijo;  // Halla el numerador del compuesto. ¡Listo!
    hP = h % 4;      // Módulo del hidrógeno del compuesto.
    
    if(hP == 0)      // Si el módulo es igual a cero...
    {
      hP = h / 2;    // Halla el numerador de la molécula de agua. ¡Listo!
      oR = (hP + (cP*2))/oFijo;  // Halla el numerador del oxígeno diatómico.
      //cR = cR;
      
      // ******** E c u a c i ó n   b a l a n c e a d a ********
      textAlign(LEFT);    // Texto alineado LEFT.
      textSize(16);       // Tamaño de la letra 16.
      fill(38,38,38);     // Color de relleno de letras y formas.
      text("Ecuación balanceada",535,50);  // Título.
      text("C     H     +        O   >       CO +       H  O",490,70);  // Ecuación balanceada.
      text("_",633,64);       // Palito de la flecha XD.
      textSize(13);           // Tamaño de la letra 13.
      text(str(c),503,75);    // Subíndice del cabono (Reactivo).
      text(str(h),540,75);    // Subíndice del hidrógeno (Reactivo).
      text("2",624,75);       // Subíndice del oxígeno del O2 (Reactivo).
      text("2",705,75);       // Subíndice del oxígeno del CO2 (Producto).
      text("2",766,75);       // Subíndice del hidrógeno del H2O (Producto).
      
      // ******** C o e f i c i e n t e s ********
      textAlign(RIGHT);    // Texto alineado RIGHT.
      textSize(16);        // Tamaño de letra 16.
      fill(127, 7, 153);   // Color del relleno de la letra y formas.
      text(cR,487,70);     // Coeficiente del compuesto.
      text(oR,608,70);     // Coeficiente del O2.
      text(cP,677,70);     // Coeficiente del CO2.
      text(hP,752,70);     // Coeficiente del H2O.
      
      // ******** T a b l a   b a l a n c e a d a ********
      textAlign(CENTER);      // Texto alineado CENTER.
      fill(38,38,38);         // Color del relleno de letras y formas.
      textSize(12);           // Tamaño de la letra 12.
      text("Reactivos       Elemento       Productos",627,89);
      textSize(15);           // Tamaño de la letra 15.
      rect(510,95,232,0.5);   // Línea decorativa.
      text("C",627,112);      // Carbonos balanceados.
      text(c*cR,540,112);     // Carbonos reactivo.
      text(cFijo*cP,706,112); // Carbonos producto.
      text("H",627,128);       // Hidrógenos balanceados.
      text(h*int(cR),540,128); // Hidrógenos reactivo.
      text(hFijo*hP,706,128);  // Hidrógenos producto.
      text("O",627,144);            // Oxígenos balanceados.
      text(oFijo*oR,540,144);       // Oxígenos reactivo.
      text((oFijo*cP)+hP,706,144);  // Oxígenos producto.
      rect(510,150,232,0.5);         // Línea decorativa.
      
      
      // ******** AHreacción ********
      o2 = float(Ho2);    // Conversión a flotante de la AHr de O2 y asignación.
      co2 = float(Hco2);  // Conversión a flotante de la AHr de CO2 y asignación.
      h2o = float(Hh2o);  // Conversión a flotante de la AHr de H2O y asignación.
      //AHf = float(entalpiaf);
      
      AHr = ((cP)*(co2) + (hP)*(h2o)) - ((cR)*(AHf));  // Halla la AH de reacción.
      
      textAlign(LEFT);    // Texto alineado LEFT.
      textSize(16);       // Tamaño de letra 16.
      fill(38,38,38);     // Color de relleno de letras y formas.
      text("Cálculo de      H°",215,181);   // Título.
      textSize(10);                         // Tamaño del subíndice del título.
      text("reacción",346,184);             // Subíndice del título.
      noFill();                             // Sin relleno el triángulo.
      triangle(326,168,320,180,332,180);    // Triángulo.
      textSize(14);                         // Tamaño de letra 14.
      fill(38,38,38);                       // Color de relleno de letras y formas.
      text("AH° = {(" + str(cP) + " mol) (" + Hco2 + " kJ/mol)" + " + (" + str(hP) + " mol) (" + Hh2o + " kJ/mol)}" + " - {(" + str(cR) + " mol) (" + entalpiaf + "kJ/mol)}",215,203);
      text("AH° = " + str(AHr) + " kJ" ,215,223);  // Muestra el resultado.
      
      moles = cR; // A moles se asigna el valor del factor del compuesto balanceado.
      
    }
    
    else if(hP == 2)    // Si el módulo es igual a 2...
    {
      hP = h;                    // Al coeficiente del H20 se le asigna el valor del número de hidrógenos.
      cP = c*2;                  // Al coeficiente del CO2 se le asigna dos veces el valor del número de carbonos.
      oR = (hP + (cP*2))/oFijo;  // Al coeficiente del O2 se le asigna el valor de la suma del coef. del H2O más dos veces el valor del coeficiente del CO2 y se divide entre el número de oxígenos que existían en un inicio en el reactivo.
      cR = 2*cR;                 // Al coeficiente del compuesto se se asigna dos veces su valor.
      
      // ******** E c u a c i ó n   b a l a n c e a d a ********
      textAlign(LEFT);    // Texto alineado LEFT.
      textSize(16);       // Tamaño de la letra 16.
      fill(38,38,38);     // Color de relleno de letras y formas.
      text("Ecuación balanceada",535,50);  // Título.
      text("C     H     +        O   >       CO +       H  O",490,70);  // Ecuación balanceada.
      text("_",633,64);       // Palito de la flecha XD.
      textSize(13);           // Tamaño de la letra 13.
      text(str(c),503,75);    // Subíndice del cabono (Reactivo).
      text(str(h),540,75);    // Subíndice del hidrógeno (Reactivo).
      text("2",624,75);       // Subíndice del oxígeno del O2 (Reactivo).
      text("2",705,75);       // Subíndice del oxígeno del CO2 (Producto).
      text("2",766,75);       // Subíndice del hidrógeno del H2O (Producto).
      
      // ******** C o e f i c i e n t e s ********
      textAlign(RIGHT);    // Texto alineado RIGHT.
      textSize(16);        // Tamaño de letra 16.
      fill(127, 7, 153);   // Color del relleno de la letra y formas.
      text(cR,487,70);     // Coeficiente del compuesto.
      text(oR,608,70);     // Coeficiente del O2.
      text(cP,677,70);     // Coeficiente del CO2.
      text(hP,752,70);     // Coeficiente del H2O.
      
      // ******** T a b l a   b a l a n c e a d a ********
      textAlign(CENTER);      // Texto alineado CENTER.
      fill(38,38,38);         // Color del relleno de letras y formas.
      textSize(12);           // Tamaño de la letra 12.
      text("Reactivos       Elemento       Productos",627,89);
      textSize(15);           // Tamaño de la letra 15.
      rect(510,95,232,0.5);   // Línea decorativa.
      text("C",627,112);      // Carbonos balanceados.
      text(c*cR,540,112);     // Carbonos reactivo.
      text(cFijo*cP,706,112); // Carbonos producto.
      text("H",627,128);       // Hidrógenos balanceados.
      text(h*int(cR),540,128); // Hidrógenos reactivo.
      text(hFijo*hP,706,128);  // Hidrógenos producto.
      text("O",627,144);            // Oxígenos balanceados.
      text(oFijo*oR,540,144);       // Oxígenos reactivo.
      text((oFijo*cP)+hP,706,144);  // Oxígenos producto.
      rect(510,150,232,0.5);         // Línea decorativa.
      
      // ******** AHreacción ********
      o2 = float(Ho2);    // Conversión a flotante de la AHr de O2 y asignación.
      co2 = float(Hco2);  // Conversión a flotante de la AHr de CO2 y asignación.
      h2o = float(Hh2o);  // Conversión a flotante de la AHr de H2O y asignación.
      //AHf = float(entalpiaf);
      
      AHr = ((cP)*(co2) + (hP)*(h2o)) - ((cR)*(AHf));  // Halla la AH de reacción.
      
      textAlign(LEFT);    // Texto alineado LEFT.
      textSize(16);       // Tamaño de letra 16.
      fill(38,38,38);     // Color de relleno de letras y formas.
      text("Cálculo de      H°",215,181);   // Título.
      textSize(10);                         // Tamaño del subíndice del título.
      text("reacción",346,184);             // Subíndice del título.
      noFill();                             // Sin relleno el triángulo.
      triangle(326,168,320,180,332,180);    // Triángulo.
      textSize(14);                         // Tamaño de letra 14.
      fill(38,38,38);                       // Color de relleno de letras y formas.
      text("AH° = {(" + str(cP) + " mol) (" + Hco2 + " kJ/mol)" + " + (" + str(hP) + " mol) (" + Hh2o + " kJ/mol)}" + " - {(" + str(cR) + " mol) (" + entalpiaf + "kJ/mol)}",215,203);
      text("AH° = " + str(AHr) + " kJ" ,215,223);  // Muestra el resultado.
      
      moles = cR; // A moles se asigna el valor del factor del compuesto balanceado.
    }
    
    else
    {
      textAlign(LEFT);
      textSize(14);
      text("Compuesto no válido",505,70);
    }
    energia();            // Se ejecuta la función energia().
  }
}


// ======================================= F U N C I Ó N    P E S O   M O L E C U L A R ======================================
float pesoMolecular(String mass, String mC, String mH)
{ 
  float peso = 0;      // Creación de la variable peso y asignación.
  mAtC = float(mC);    // Conversión y asignación de la masa atómica del carbono.
  mAtH = float(mH);    // Conversión y asignación de la masa atómica del hidrógeno.
  m = float(mass);     // Conversión y asignación de la masa del compuesto.
  peso = ((c)*(mAtC)) + ((h)*(mAtH));
  
  textAlign(LEFT);                // Texto alineado LEFT.
  textSize(16);                   // Tamaño de letra 16.
  fill(38,38,38);                 // Color de relleno de letras y formas.
  text("Peso molecular",215,250); // Título.
  
  textAlign(LEFT);    // Texto alineado LEFT.
  textSize(12);       // Tamaño de letra 12.
  text("Elemento    Masa atómica(g/mol)    Cantidad    Peso total(g/mol)",215,265);
  rect(215,270,397,0.5);  // Línea decorativa.
  textAlign(CENTER);      // Texto alineado CENTER
  textSize(14);           // Tamaño de letra 15.
  text("C",245,285);      // Carbono.
  text(mAtC,345,285);     // Masa atómica del carbono.
  text(int(c),466,285);   // Número de átomos de carbono.
  text(mAtC*c,557,285);   // Peso total de carbono.
  text("H",245,301);      // Hidrógeno.
  text(mAtH,345,301);     // Masa atómica del hidrógeno.
  text(int(h),466,301);   // Número de átomos de hidrógeno.
  text(mAtH*h,557,301);   // Peso total de hidrógeno.
  //text("O",234,312);
  rect(507,307,104,0.5);   // Línea decorativa.
  
  text(str(peso)+ " g/mol",557,323);    // Peso total g/mol.
  textAlign(LEFT);
  text("Peso molecular = (" + m + " g)/(" + peso + " g/mol)",215,347);
  peso = m/peso;                        // Peso TOTAL mol.
  text("Peso molecular: " + peso + " mol",215,367);
  
  return peso;
}

void energia()
{
  fill(0,0,0);
  float e = 0;
  e = pesoMolecular(masa,masaAtomC,masaAtomH);
  
  textAlign(LEFT);
  textSize(16);
  text("Energía producida por " + masa + " g del compuesto.",215,394);
  textSize(14);
  
  text("E = {(" + e + " mol)/(" + moles + " mol)}{" + AHr + " kJ}",215,414);
  e = (e)*(AHr)/moles;
  text("E = " + str(e) + " kJ",215,435);
  
}
