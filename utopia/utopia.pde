

//set random initial population
// num families should actually range from 1 to 6000
int NUMFAMILIES = 3;
//TODO: add country families
int year = 0;
int TIMEINTERVAL = 2000;
int lastTime = 0;
//yearTimer yt;
//Person [][] persons = new Person [NUMFAMILIES][16];

ArrayList<ArrayList> families = new ArrayList<ArrayList>();

int population = 0;
int showingfam = -1; // on-off for info display
int showingmember = -1;

PImage img;

/* Test Comment */


void setup()
{
  //set up map
  //img = loadImage("utopia_map_square800.jpg");
  size(800, 800);
//  yt = new yearTimer();
//  yt.start();
  lastTime = millis();
  for (int i = 0; i < NUMFAMILIES; i++)
  {
    int familysize = int(random(2, 5));
    ArrayList family = new ArrayList();
    for (int j = 0; j < familysize; j++)
    {
      family.add(new Person(i, j, random(width), random(height), random(-2,2), random (-2,2), 15,  0, null, int(random(0,2)), null, null, 10));
      population ++;
    }
    families.add(family);
    println(family.size());
  } 
}

//continuously runs until program is cancelled 
void draw(){
  //background(img);
  
  
  background(255);
  textAlign(CENTER);
  fill(50);
  text("Year: " + year, 150, 175);
  /*
  for (int i = 0; i < families.size(); i++)
  {
    //ArrayList curr = families.get(i);
    //println(curr.size());
    
    for (int j = 0; j < families.get(i).size(); j++)
    {
      text("hello", 150, 175 - 5*i*j);
    }
    
    */
  }
  
  if(millis() - lastTime > TIMEINTERVAL)
  {
        year++;
        //println("year:" + year); // this is working
        lastTime = millis();
  }
  /*
  //drawing the floating people
  for (int i = 0; i < persons.length; i++)
  {
    for (int j = 0; j < persons[i].length; j++)
    {
      if (persons[i][j] != null)
      {
        persons[i][j].move();
        persons[i][j].display();
      }
    }
  }
  if (showingfam != -1 && showingmember != -1)
    persons[showingfam][showingmember].showText();
  */
}



//not using yearTimer now
class yearTimer {
  //source: http://forum.processing.org/topic/timer-in-processing
  int startTime = 0, stopTime = 0;
  boolean running = false;
  void start() {
    startTime = millis();
    running = true;
  }
  void stop() {
    stopTime = millis();
    running = false;
  }
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    }
    else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  int second() {
    return (getElapsedTime() / 1000) % 60;
  }
}


class Person
{
  int familyid;
  int member;
  float x, y, vx, vy;
  float diameter;
  int workyr; // 0, 1st or 2nd year of country work
  int area; // 0 for town, 1 for country
  String trade;
  int gender; //0 for women, 1 for men
  Person father;
  Person mother;
  int age;
  
  Person(int familyid, int member, float x, float y, float vx, float vy, float diameter, int area,
      String trade, int gender, Person father, Person mother, int age)
  {
    this.familyid = familyid;
    this.member = member;
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.diameter = diameter;
    this.workyr = 0;
    this.area = area;
    this.trade = trade;
    this.gender = gender;  
    this.father = father;
    this.mother = mother;
    this.age = age;
  }
  
  void display()
  {
    if (gender == 0)
      fill(255, 51, 153, 180);
    else
      fill(51, 51, 255, 180);
    ellipse(x, y, diameter, diameter);
  }
  
  void move()
  {
    
    //check if mouse is hovering
    float dist = sqrt(sq(mouseX-x)+sq(mouseY-y));
    if(dist < diameter)
    {
      if(showingfam == familyid && showingmember == member)
      {
        showText();
        return;
      }
      else if (showingfam == -1 && showingmember == -1)
      {
        showingfam = familyid;
        showingmember = member;
        showText();
        return;
      }
    }
    if(showingfam == familyid && showingmember == member)
    {
      showingfam = -1;
      showingmember = -1;
    }
    
    //randomly move around
    if((y > height) || (y < 0 ))
    {
      vy *= -1;
    }
    
    if((x > width) || (x < 0))
    {
      vx *= -1;
    }
    x += vx; 
    y += vy;
  
  }
  
  void showText()
  {
    fill(255);
    rect(x, y, 150, 60, 7);
    fill(128);
    text("FamilyID: "+familyid, x+5, y+25);
    text("Member: "+member, x+5, y+38);
   
    
  }
  
}
