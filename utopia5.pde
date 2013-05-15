boolean pause = false;

//constants we set 
int INIThouseholds = 3; // num households should actually range from 1 to 6000
float MARRIAGEPROB = 1;
int MOTHERMAXAGE = 45;
int FATHERMAXAGE = 70;
int LIFEEXPECTANCY = 85; 
float FERTILITYRATE = .25;
int INITMAXHOUSEHOLDSIZE = 8;


//constants set in Utopia
int FEMALEMARRIAGEAGE = 18;
int MALEMARRIAGEAGE = 22;

//TODO: add country households


//our counters
int year = 0;
int TIMEINTERVAL = 500;
int lastTime = 0;
int malepop = 0;
int femalepop = 0;
Person wife = null;
Person husband = null;

//types of people
String[] genders = {
  "f", "m"
};
String[] peopletype = {
  "unmarried", "married"
};

//types of trades
String[] trades = {
};

ArrayList<ArrayList> households = new ArrayList<ArrayList>();
ArrayList<Person> bachelorettes = new ArrayList<Person>();
ArrayList<Person> bachelors = new ArrayList<Person>();

int numhouseholds = 0;
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
  startHouseholds();
  println("total number of households" + households.size());
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

  int ycoordinate = 200;
  int bachelorsy = 200;
  int bachelorettesy = 200;

  if (pause == true)
  {
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
          
          if (random(1) < curr.age / LIFEEXPECTANCY)
            households.get(curr.householdID).remove(curr);
        }
      }



      findCouple();

      //marry the pair we chose, start a new household
      if (husband != null && wife != null)
      {
        println("couple: husband-" + "(" + husband.householdID +"," + husband.member +")" + 
          " wife-" + "(" + wife.householdID + "," + wife.member + ")");
        // Person temphusband = new Person(husband.householdID, husband.member, "married", husband.x, husband.y, husband.vx, husband.vy, 
        //husband.diameter, husband.area, husband.trade, husband.gender, husband.father, husband.mother, husband.age);
        // temphusband.householdID = numhouseholds;
        Person tempwife = new Person(wife.householdID, households.get(husband.householdID).size(), "married", wife.x, wife.y, wife.vx, wife.vy, 
        wife.diameter, wife.area, wife.trade, wife.gender, wife.father, wife.mother, husband, wife.age);

        households.get(wife.householdID).remove(wife);
        tempwife.householdID = husband.householdID;
        //    ArrayList<Person> newhousehold = new ArrayList<Person>();
        //     newhousehold.add(tempwife);
        //    newhousehold.add(temphusband);
        //    households.add(newhousehold);
        // numhouseholds++;
        households.get(husband.householdID).add(tempwife);
        husband.status = "married";
        husband.spouse = tempwife;
      }


      //childbirth
      for (int i = 0; i < households.size(); i++)
      {
        Person mother = (Person) households.get(i).get(0);
        Person father = (Person) households.get(i).get(1);

        if (mother.age <= MOTHERMAXAGE && father.age <= FATHERMAXAGE)
        {
          if (random(1) <= FERTILITYRATE)
          {
            Person baby = new Person(mother.householdID, households.get(i).size(), "unmarried", mother.x, mother.y, mother.vx, mother.vy, 
            mother.diameter, mother.area, father.trade, genders[int(random(0, 2))], father, mother, null, 0);
            households.get(i).add(baby);
          }
        }
      }
    }

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
}


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

