boolean pause = false;


//constants set in Utopia
int FEMALEMARRIAGEAGE = 18;
int MALEMARRIAGEAGE = 22;
int MINHOUSEHOLDSIZE = 10;
int MAXHOUSEHOLDSIZE = 16;

//TODO: add country households

//our counters
int year = 0;
int TIMEINTERVAL = 500;
int lastTime = 0;
int malepop = 0;
int femalepop = 0;
Person wife = null;
Person husband = null;
int numhouseholds = 0;
int population = 0;
int showingfam = -1; // on-off for info display
int showingmember = -1;

//constants we set 
int INIThouseholds = 4; // num households should actually range from 1 to 6000
float MARRIAGEPROB = 1;
int MOTHERMAXAGE = 45;
int FATHERMAXAGE = 70;
int LIFEEXPECTANCY = 85; 
float FERTILITYRATE = .25;

//types of people
String[] genders = {
  "f", "m"
};
String[] peopletype = {
  "unmarried", "married"
};

//types of trades
String[] maletrades = {
  "masonry", "smith", "carpenter", "manufacturing"
};
String[] femaletrades = {
  "masonry", "smith", "carpenter", "manufacturing"
};

//add domestic work, like agriculture

//our dynamic lists
ArrayList<ArrayList> households = new ArrayList<ArrayList>();
ArrayList<Person> bachelorettes = new ArrayList<Person>();
ArrayList<Person> bachelors = new ArrayList<Person>();
ArrayList<Person []> couples = new ArrayList<Person []>();
//PImage img;


// setup() is run once at the beginning of the program.
// it sets the size of the display screen and calls startHouseholds() 
void setup()
{
  //set up map
  //img = loadImage("utopia_map_square800.jpg");
  size(1200, 2000);
  //  yt = new yearTimer();
  //  yt.start();
  lastTime = millis();
  startHouseholds();
}

//continuously runs until program is cancelled 
void draw() {
  //background(img);
  background(255);
  textAlign(CENTER);

  fill(50);
  text("numbachelors: " + bachelors.size(), 150, 100);
  text("numbachelorettes: " + bachelorettes.size(), 150, 110);
  text("Year: " + year, 150, 120);
  text("Population: " + population, 150, 130);
  text("Males: " + malepop, 150, 140);
  text("Females: " + femalepop, 150, 150);
  text("Households: " + households.size(), 150, 160);
  text("married couples: "+couples.size(), 150, 170);


  int ycoordinate = 200;
  int bachelorsy = 200;
  int bachelorettesy = 200;

  if (pause == true)
  {

    showPopulation();
  }
  else
  {
    if (millis() - lastTime > TIMEINTERVAL)
    {
      year++;
      lastTime = millis();   
      bachelorettes.clear();
      bachelors.clear();

      population = 0;
      wife = null;
      husband = null;

      // tallyPopulation() takes an updated count of the number of 
      // males, females, bachelors, and bachelorettes in the population
      // It also updates the age of the individuals


      malepop = 0;
      femalepop = 0;
      for (int i = 0; i < households.size(); i++)
      {
        for (int j = 0; j < households.get(i).size(); j++)
        {
          population++;
          Person curr;
          curr = ((Person)((households.get(i)).get(j)));
          if (curr.gender == "m")
            malepop++;
          else
            femalepop++;
          curr.age++;


          //fill list of eligible bachelors and bachelorettes
          if (curr.status == "unmarried")
          {
            if (curr.gender == "f" && curr.age >= FEMALEMARRIAGEAGE)
            {
              bachelorettes.add(curr);
              // print("added bachelorette\n");
            }
            else if (curr.gender == "m" && curr.age >= MALEMARRIAGEAGE)
            {
              bachelors.add(curr);
              //  print("added bachelor\n");
            }
          }
          
          death(curr);


        }
      }
      marriage();


      //CHILDBIRTH
      childbirth();
    }

    showPopulation();
  }
}


void showPopulation()
{ 
  int ycoordinate = 200;
  int bachelorsy = 200;
  int bachelorettesy = 200;

  //print bachelors
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


  //print bachelorettes
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

  //print entire population
  for (int i = 0; i < households.size(); i++)
  {
    //ArrayList curr = households.get(i);
    //println(curr.size());
    for (int j = 0; j < households.get(i).size(); j++)
    {

      ((Person)((households.get(i)).get(j))).member = j;
      text(" householdID:" + ((Person)((households.get(i)).get(j))).householdID +
        " member:" + ((Person)((households.get(i)).get(j))).member +
        " gender:" + ((Person)((households.get(i).get(j)))).gender +
        " status:" + ((Person)((households.get(i).get(j)))).status +
        " age:" + ((Person)((households.get(i).get(j)))).age
        , 200, ycoordinate);
      ycoordinate += 15;
    }
  }
}

// keyPressed() keeps track of whether the user
// has pressed the ENTER key. if yes, the program will pause/resume
void keyPressed()
{
  if (keyCode == ENTER)
  {
    if (pause == false)
      pause = true;
    else
      pause = false;
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

/*
void marriage()
 {
 Person wife;
 Person husband;
 //create list of eligible bachelorettes and bachelors
 for (int i = 0; i < households.size(); i++)
 {
 for (int j = 0; j < households.get(i).size(); j++)
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

