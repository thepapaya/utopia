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
int masons = 0;
int smiths = 0;
int carpenters = 0;
int manufacturers = 0;

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
  "mason", "smith", "carpenter", "manufacturer"
};
String[] femaletrades = {
  "mason", "smith", "carpenter", "manufacturer"
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
  size(1200, 800);
  //  yt = new yearTimer();
  //  yt.start();
  lastTime = millis();
  startHouseholds();
}

// draw() is run continuously until program is cancelled 
// it displays the updated stats as text on the screen 
// and when 'pause' is not true, it updates the age and tally
// of each person, and also runs the marriage(), death(Person curr)
// and childbirth() functions at every preset time interval

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
  text("carpenters: " + carpenters, 300, 100);
  text("masons:" + masons, 300, 110);
  text("manufacturers: "+ manufacturers, 300, 120);
  text("smiths: " + smiths, 300, 130);


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

      malepop = 0;
      femalepop = 0;
      
      masons = 0;
      carpenters = 0;
      smiths = 0;
      manufacturers = 0;
      
      for (int i = 0; i < households.size(); i++)
      {
        for (int j = 0; j < households.get(i).size(); j++)
        {
          population++;
          Person curr;
          curr = ((Person)((households.get(i)).get(j)));
          
          
          tallyGender(curr);
          curr.age++;
          countTrades(curr);
          fillEligibleList(curr);        
          death(curr);
        }
      }
      marriage();
      childbirth();
    }
    showPopulation();
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
/*
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
*/

