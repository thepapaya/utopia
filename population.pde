

void startHouseholds()
{
  for (int i = 0; i < INIThouseholds; i++)
  {
    //this is our choice (householdsize)
    int householdsize = int(random(2, INITMAXHOUSEHOLDSIZE));

    //create new household
    ArrayList household = new ArrayList();
    for (int j = 0; j < householdsize; j++)
    {
      if (j == 0)
      {
        //add mother
        household.add(new Person(i, j, (String) peopletype[1], random(width), random(height), random(-2, 2), random (-2, 2), 15, 0, null, genders[0], null, null, int(random(18, 60))));
        femalepop++;
      }
      else if (j == 1)
      {
        //add father
        household.add(new Person(i, j, (String) peopletype[1], random(width), random(height), random(-2, 2), random (-2, 2), 15, 0, null, genders[1], null, null, int(random(18, 60))));
        malepop++;
      }
      else
      {
        Person np = new Person(i, j, (String) peopletype[0], random(width), random(height), random(-2, 2), random (-2, 2), 15, 0, null, genders[int(random(0, 2))], null, null, int(random(10, 60)));
        household.add(np);
        if (np.gender == "m")
          malepop++;
        else
          femalepop++;
      }  
      population++;
    }
    households.add(household);
    numhouseholds++;
  }
}
