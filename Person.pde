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

  Person(int householdID, int member, String status, float x, float y, float vx, float vy, float diameter, int area, 
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
    if (dist < diameter)
    {
      if (showingfam == householdID && showingmember == member)
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
    if (showingfam == householdID && showingmember == member)
    {
      showingfam = -1;
      showingmember = -1;
    }

    //randomly move around
    if ((y > height) || (y < 0 ))
    {
      vy *= -1;
    }

    if ((x > width) || (x < 0))
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

