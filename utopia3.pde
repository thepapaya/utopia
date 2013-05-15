
//constants we set 
int INITFAMILIES = 10; // num families should actually range from 1 to 6000
float MARRIAGEPROB = 1;
int MOTHERMAXAGE = 45;
int FATHERMAXAGE = 70;
int LIFEEXPECTANCY = 100; // TODO: IMPLEMENT THIS
float FERTILITYRATE = .25;


//constants set in Utopia
int FEMALEMARRIAGEAGE = 18;
int MALEMARRIAGEAGE = 22;

//TODO: add country families


//our counters
int year = 0;
int TIMEINTERVAL = 2000;
int lastTime = 0;
int malepop = 0;
int femalepop = 0;

//types of people
String[] genders = {"f","m"};
String[] peopletype = {"unmarried", "married"};

//types of trades
String[] trades = {};

ArrayList<ArrayList> families = new ArrayList<ArrayList>();
ArrayList<Person> bachelorettes = new ArrayList<Person>();
ArrayList<Person> bachelors = new ArrayList<Person>();

int numfamilies = 0;
int population = 0;
int showingfam = -1; // on-off for info display
int showingmember = -1;

PImage img;


//this is run once at the beginning of the program. ADD MORE HERE 
void setup()
{
  //set up map
  //img = loadImage("utopia_map_square800.jpg");
  size(1200, 800);
//  yt = new yearTimer();
//  yt.start();
  lastTime = millis();
  
  
  for (int i = 0; i < INITFAMILIES; i++)
  {
    //this is our choice (familysize)
    int familysize = int(random(2, 8));
    
    //create new family
    ArrayList family = new ArrayList();
    for (int j = 0; j < familysize; j++)
    {
      if (j == 0)
      {
        //add mother
        family.add(new Person(i, j, (String) peopletype[1], random(width), random(height), random(-2,2), random (-2,2), 15,  0, null, genders[0], null, null, int(random(18,60))));
        femalepop++;
      }
      else if (j == 1)
      {
        //add father
        family.add(new Person(i, j, (String) peopletype[1], random(width), random(height), random(-2,2), random (-2,2), 15,  0, null, genders[1], null, null, int(random(18,60))));
        malepop++;
      }
      else
      {
        Person np = new Person(i, j, (String) peopletype[0], random(width), random(height), random(-2,2), random (-2,2), 15,  0, null, genders[int(random(0,2))], null, null, int(random(10,60)));
        family.add(np);
        if (np.gender == "m")
          malepop++;
        else
          femalepop++;
        
      }  
      population++;
     
  }
    families.add(family);
    numfamilies++;
    
  }
    println("total number of families" + families.size());
  

}

//continuously runs until program is cancelled 
void draw(){
  //background(img);
  
  
  background(255);
  textAlign(CENTER);
  
  fill(50);
  text("Year: " + year, 150, 120);
  text("Population: " + population, 150, 130);
  //fix this count
//  text("Males: " + malepop, 150, 140);
 // text("Females: " + malepop, 150, 150);
  
  int ycoordinate = 200;
  int bachelorsy = 200;
  int bachelorettesy = 200;
  Person wife = null;
  Person husband = null;
  
  // tick through time, this works)
  if(millis() - lastTime > TIMEINTERVAL)
  {
    year++;
    lastTime = millis();   
    bachelorettes.clear();
    bachelors.clear();

    
    population = 0;
    malepop = 0;
    femalepop = 0;
        //println("year:" + year); // this is working
    for (int i = 0; i < families.size(); i++)
    {
      for (int j = 0; j < families.get(i).size(); j++)
      {
        population ++;
        Person curr;
        curr = ((Person)((families.get(i)).get(j)));
        if (curr.gender == "m")
          malepop++;
        else
          femalepop++;
        curr.age++;
        
        
        //fill list of eligible bachelors and bachelorettes
        if (curr.status == "unmarried")
        {
          if(curr.gender == "f" && curr.age >= FEMALEMARRIAGEAGE)
          {
            bachelorettes.add(curr);
           // print("added bachelorette\n");
          }
          else if(curr.gender == "m" && curr.age >= MALEMARRIAGEAGE)
          {
            bachelors.add(curr);
          //  print("added bachelor\n");
          }
        }
        
      }
    } 
        // find a pair to marry
    if (bachelorettes.size() > 0)
    {
     wife = bachelorettes.get(0);
     if (bachelors.size() > 0)
     {
     do
     {
       husband = bachelors.get(int(random(bachelors.size())));
    //   print("husband:" + husband);
     }
     while (wife.householdID == husband.householdID);  
     }
    }
    
    //marry the pair we chose, start a new family
    if (husband != null && wife != null)
    {
       //TO DO: implement starting the new family
      //remove from old families
      print("couple: husband-" + "(" + husband.householdID +"," + husband.member +")" + 
          " wife-" + "(" + wife.householdID + "," + wife.member + ")");
      Person temphusband = new Person(husband.householdID, husband.member, "married", husband.x, husband.y, husband.vx, husband.vy, 
                            husband.diameter, husband.area, husband.trade,husband.gender, husband.father, husband.mother, husband.age);
      temphusband.householdID = numfamilies;
      Person tempwife = new Person(wife.householdID, wife.member, "married", wife.x, wife.y, wife.vx, wife.vy, 
                           wife.diameter, wife.area, wife.trade,wife.gender, wife.father, wife.mother, wife.age);
      tempwife.householdID = numfamilies;
      ArrayList<Person> newfamily = new ArrayList<Person>();
      newfamily.add(tempwife);
      newfamily.add(temphusband);
      families.add(newfamily);
      numfamilies++;
      families.get(husband.householdID).remove(husband.member);
      families.get(wife.householdID).remove(wife.member);
      
  
    }
    
    
    //childbirth
    for (int i = 0; i < families.size(); i++)
    {
      Person mother = (Person) families.get(i).get(0);
      Person father = (Person) families.get(i).get(1);
      
      if (mother.age <= MOTHERMAXAGE && father.age <= FATHERMAXAGE)
      {
        if (random(1) <= FERTILITYRATE)
        {
          Person baby = new Person(mother.householdID, families.get(i).size(), "unmarried", mother.x, mother.y, mother.vx, mother.vy, 
                               mother.diameter, mother.area, father.trade, genders[int(random(0,2))], father, mother, 0);
          families.get(i).add(baby);
        }
      }
    }
  }
    
    //print("num bachelors:" + bachelors.size());
    for (int i = 0; i < bachelors.size(); i++)
    {
       text(" householdID:" + ((Person)(bachelors.get(i))).householdID +
              " member:" + ((Person)(bachelors.get(i))).member +
              " gender:" + ((Person)(bachelors.get(i))).gender +
              " status:" + ((Person)(bachelors.get(i))).status +
              " age:" + ((Person)(bachelors.get(i))).age
              , 600, bachelorsy);
        bachelorsy += 15;
    }
        
    for (int i = 0; i < bachelorettes.size(); i++)
    {
       text(" householdID:" + ((Person)(bachelorettes.get(i))).householdID +
              " member:" + ((Person)(bachelorettes.get(i))).member +
              " gender:" + ((Person)(bachelorettes.get(i))).gender +
              " status:" + ((Person)(bachelorettes.get(i))).status +
              " age:" + ((Person)(bachelorettes.get(i))).age
              , 1000, bachelorettesy);
        bachelorettesy += 15;
    }
   
    for (int i = 0; i < families.size(); i++)
    {
      //ArrayList curr = families.get(i);
      //println(curr.size());
      for (int j = 0; j < families.get(i).size(); j++)
      {
        
        ((Person)((families.get(i)).get(j))).member = j;
        text(" householdID:" + ((Person)((families.get(i)).get(j))).householdID +
              " member:" + ((Person)((families.get(i)).get(j))).member +
              " gender:" + ((Person)((families.get(i).get(j)))).gender +
              " status:" + ((Person)((families.get(i).get(j)))).status +
              " age:" + ((Person)((families.get(i).get(j)))).age
              , 200, ycoordinate);
        ycoordinate += 15;
      }
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

/*
void marriage()
{
  Person wife;
  Person husband;
  //create list of eligible bachelorettes and bachelors
  for (int i = 0; i < families.size(); i++)
  {
    for (int j = 0; j < families.get(i).size(); j++)
    {
      //
    }
  }
}
*/

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


public class Person
{
  

  int householdID;
  int member;
  String status;
  float x, y, vx, vy;
  float diameter;
  int workyr; // 0, 1st or 2nd year of country work
  int area; // 0 for town, 1 for country
  String trade;
  String gender; 
  Person father;
  Person mother;
  int age;
  
  Person(int householdID, int member, String status,  float x, float y, float vx, float vy, float diameter, int area,
      String trade, String gender, Person father, Person mother, int age)
  {
    this.householdID = householdID;
    this.member = member;
    this.status = status;
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
  
  int getAge()
  {
    return age;
  }
  
  void display()
  {
    if (gender == "f")
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
      if(showingfam == householdID && showingmember == member)
      {
        showText();
        return;
      }
      else if (showingfam == -1 && showingmember == -1)
      {
        showingfam = householdID;
        showingmember = member;
        showText();
        return;
      }
    }
    if(showingfam == householdID && showingmember == member)
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
    text("householdID: "+householdID, x+5, y+25);
    text("Member: "+member, x+5, y+38);
   
    
  }
  
}
