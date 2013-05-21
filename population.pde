// childbirth() looks at every couple in the couples ArrayList
// if one partner in the couple has died, the couple is removed 
// from the ArrayList and the marriage status of the living partner
// is updated to allow remarriage. If both partners are alive and of
// childrearing age, they will give birth to a child at the preset
// FERTILITYRATE

void childbirth()
{
  for (int i = 0; i < couples.size(); i++)
  {
    // println("couple #:" + i);
    // print(couples.get(i)[0]);
    // print(couples.get(i)[1]);

    Person father = couples.get(i)[0];
    Person mother = couples.get(i)[1];

    //remove couples if one partner is dead
    //update status of spouse if partner is dead
    if (father == null && mother != null)
    {
      couples.remove(i);
      mother.status = "unmarried";
    }
    else if (father != null && mother == null)
    {
      couples.remove(i);
      father.status = "unmarried";
    }
    else if (father == null && mother == null)
    {
      couples.remove(i);
    }
    else
    {
      if (mother.age <= MOTHERMAXAGE && father.age <= FATHERMAXAGE)
      {
        if (random(1) <= FERTILITYRATE)
        {
          Person baby = new Person(mother.householdID, households.get(mother.householdID).size(), "unmarried", mother.x, mother.y, mother.vx, mother.vy, 
          mother.diameter, mother.area, father.trade, genders[int(random(0, 2))], father, mother, null, 0);
          households.get(mother.householdID).add(baby);
        }
      }
    }
  }
}

// countTrades(Person curr) takes a Person and tallies
// their trade under the global variables designated
// for each trade

void countTrades(Person curr)
{
  if (curr.trade == "mason")
    masons++;
  else if (curr.trade == "carpenter")
    carpenters++;
  else if (curr.trade == "manufacturer")
    manufacturers++;
  else if (curr.trade == "smith")
    smiths ++;
}

// death(Person curr) removes curr according to the
// preset LIFEEXPECTANCY. As curr's age reaches LIFEEXPECTANCY, 
// their likelihood of dying increases

void death(Person curr)
{
  if (random(1) < curr.age / LIFEEXPECTANCY)
    households.get(curr.householdID).remove(curr);
}

// fillEligibleList(Person curr) takes curr and places them
// in the bachelors or bachelorettes ArrayList if they qualify

void fillEligibleList(Person curr)
{

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
}

// findCouple() randomly selects a bachelor and a bachelorette
void findCouple()
{
  // find a pair to marry
  if (bachelorettes.size() > 0)
  {
    wife = bachelorettes.get(int(random(bachelorettes.size())));
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
}

// marriage() takes a couple (using findCouple()) and marries them
// the new couple joins the household of the husband, and is added to the
// couples ArrayList. Note the marriage rate setting at the beginning
// of the function

void marriage()
{

  //SET ANNUAL MARRIAGE RATE HERE.
  // right now, there are numhouseholds/4 happening every year
  for (int i = 0; i < numhouseholds/4; i++)
  {
    wife = null;
    husband = null;
    findCouple();

    //marry the pair we chose, start a new household
    if (husband != null && wife != null)
    {
      // println("couple: husband-" + "(" + husband.householdID +"," + husband.member +")" + 
      //  " wife-" + "(" + wife.householdID + "," + wife.member + ")");


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
      Person[] newcouple = {
        husband, tempwife
      };
      couples.add(newcouple);
    }
  }
}

// showPopulation() prints a list of every Person in the world on 
// the left column, a list of the bachelors in the middle column, 
// and a list of bachelorettes in the right column

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


// startHouseholds() is used to set up the correct number of 
// households at the start of the program according to our constants
void startHouseholds()
{
  for (int i = 0; i < INIThouseholds; i++)
  {
    //this is our choice (householdsize)
    int householdsize = int(random(MINHOUSEHOLDSIZE, MAXHOUSEHOLDSIZE));
    Person firstwife = new Person(i, 0, (String) peopletype[1], random(width), random(height), random(-2, 2), random (-2, 2), 15, 0, maletrades[int(random(0, 4))], genders[0], null, null, null, int(random(22, 60)));
    Person firsthusband = new Person(i, 1, (String) peopletype[1], random(width), random(height), random(-2, 2), random (-2, 2), 15, 0, femaletrades[int(random(0, 2))], genders[1], null, null, null, int(random(18, 60)));
    firstwife.spouse = firsthusband;
    firsthusband.spouse = firstwife;

    femalepop++;
    malepop++;
    //create new household
    ArrayList household = new ArrayList();
    household.add(firstwife);
    household.add(firsthusband);
    Person[] newcouple = {
      firsthusband, firstwife
    };
    couples.add(newcouple);

    for (int j = 2; j < householdsize; j++)
    {

      Person np = new Person(i, j, (String) peopletype[0], random(width), random(height), random(-2, 2), random (-2, 2), 15, 0, null, genders[int(random(0, 2))], null, null, null, int(random(1, 30)));
      household.add(np);
      if (np.gender == "m")
      {
        malepop++;
        np.trade = maletrades[int(random(0, 4))];
      }
      else
      {
        femalepop++; 
        np.trade = femaletrades[int(random(0, 2))];
      }
      population++;
    }
    households.add(household);
    numhouseholds++;
  }
}

// tallyGender() takes curr and adds one to the malepop
// or femalepop global variables depending on the gender of curr

void tallyGender(Person curr)
{
  if (curr.gender == "m")
    malepop++;
  else
    femalepop++;
}

