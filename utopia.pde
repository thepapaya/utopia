

//set random initial population
// num families should actually range from 1 to 6000
int NUMFAMILIES = int(random(0, 100));
Person [][] persons = new Person [NUMFAMILIES][16];
int population = 0;

void setup()
{
  //set up map
  size(800, 800);
  for (int i = 0; i < NUMFAMILIES; i++)
  {
    int familysize = int(random(10, 16));
    for (int j = 0; j < familysize; j++)
      persons[i][j] = new Person(j, random(width), random(height), random(-2,2), random (-2,2), 10,  0, null, int(random(0,2)), null, null, 10);
      population ++;
  } 
}

//continuously runs until program is cancelled 
void draw(){
  background(0);
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
}

class Person
{
  int id;
  int familyid;
  float x, y, vx, vy;
  float diameter;
  int workyr; // 0, 1st or 2nd year of country work
  int area; // 0 for town, 1 for country
  String trade;
  int gender; //0 for women, 1 for men
  Person father;
  Person mother;
  int age;
  
  Person(int familyid, float x, float y, float vx, float vy, float diameter, int area,
      String trade, int gender, Person father, Person mother, int age)
  {
    this.familyid = familyid;
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
    fill(255, 255, 0, 180);
    ellipse(x, y, diameter, diameter);
  }
  
  void move()
  {
    float dist = sqrt(sq(mouseX-x)+sq(mouseY-y));
    //check if mouse is hovering
    
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
  
}
