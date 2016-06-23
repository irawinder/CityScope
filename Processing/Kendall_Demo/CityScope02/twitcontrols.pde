
/////////// CitySCOPE control slider
/////////// code Written By Carson Smuts
/////////// 2014


import javax.swing.JFrame;

PFrame f = null;
secondApplet s;

//Date span

String date1 = "Tue Mar 18 13:11:04 EDT 2455";
String date2 = "Tue Mar 18 13:11:04 EDT 2000";
String cullDateStart = "Tue Mar 18 13:11:04 EDT 2450";
String cullDateEnd = "Tue Mar 18 13:11:04 EDT 2000";

boolean startDateToggle = false;
boolean endDateToggle = false;

boolean cycle = false;
float cycleSpeed = 0.02;
int cycleTimer = 0;

public class secondApplet extends PApplet {
  int startMousePosX ;
  int startMousePosY ;

  int endMousePosX ;
  int endMousePosY ;

  SimpleDateFormat sdf ;

  int lineHeight = 75;

  float counter = 0;

  public void setup() {
    size(600, 200);
    //noLoop();
    endMousePosX = width-40;
    startMousePosX = 20;

    String format ="yyyy-MM-dd HH:mm";
    String format2 ="EEEE";
    sdf = new SimpleDateFormat(format);
  }

  public void draw() {

    fill(0);
    background(0);

    textSize(10);
    fill(255, 255, 255);

    Date gmtDate1 = new Date(date1);// use your date here
    Date gmtDate2 = new Date(date2);// use your date here
    Date gmtDate3 = new Date(cullDateStart);// use your date here
    Date gmtDate4 = new Date(cullDateEnd);// use your date here

    String bostonDate1 =sdf.format(gmtDate1);
    String bostonDate2 =sdf.format(gmtDate2);
    String bostonDate3 =sdf.format(gmtDate3);
    String bostonDate4 =sdf.format(gmtDate4);

    text(bostonDate1, 5, 25);
    text(bostonDate2, width - 120, 25);



    stroke(180);
    int lineLength = width - 40;


    line(20, lineHeight, width-20, lineHeight);
    line(20, lineHeight-10, 20, lineHeight+10);



    translate(width - 40, 0);
    line(20, lineHeight-10, 20, lineHeight+10);
    translate(-(width - 40), 0);


    translate(20, 0);
    strokeWeight(1);


    for (int i=0 ; i <lineLength ; i++) {
      if ((i%4) == 0) {
        counter = counter + 0.0006;

        stroke(abs(90 * (sin(3.1*i + counter)+0.4)));
        line(i, lineHeight-5, i, lineHeight+5);
      }
    }



    translate(-20, 0);


    textSize(14);
    fill(255, 255, 255);
    text(bostonDate3, (width/2) -65, 25);
    ellipse(startMousePosX, lineHeight, 10, 10);

    fill(65, 170, 219, 200);
    text(bostonDate4, (width/2) -65, 50);
    ellipse(endMousePosX, lineHeight, 10, 10);

    rect(0, height-45, 90, height);
    fill(255, 255, 255);

    if (millis() - 200 >= cycleTimer) {
      //println( ".2 seconds SaveScreenCap" );
      cycleTimer=millis();


      if (!cycle) {
        // text("Auto Iterate", 5, height-30);
      }
      else {
        // text("Stop Iterate", 5, height-30);

        long dateEnd =new Date(date2).getTime();
        long dateStart =new Date(date1).getTime();            
        long cullDate = new Date(cullDateEnd).getTime();
        long offLength = width - 40;
        long dateDiff = dateEnd-dateStart;
        long dateDiff2 = cullDate-dateStart;


        cullDate = cullDate + (int)(dateDiff * cycleSpeed);

        //println(cullDateStart);
        //println(cullDateEnd);
        cullDateEnd = new Date(cullDate).toString();

        if (cullDate > dateEnd) {
          cullDateEnd = cullDateStart;
        }


        float factor  = (float)dateDiff2 / (float)dateDiff;
        endMousePosX = (int)(offLength * factor) + 20;
        //println(factor);
        //println(dateDiff2);
      }
    }

    if (!cycle) {
      text("Auto Iterate", 5, height-30);
    }
    else {
      text("Stop Iterate", 5, height-30);
    }

    fill(65, 170, 219, 200);
    rect(width/2 - 60, height-45, 20, 20);
    rect(width/2 + 40, height-45, 20, 20);

    fill(255, 255, 255);
    text("-", width/2 - 53, height-30);
    text("+", width/2 + 45, height-30);


    text("Speed", width/2 - 20, height-30);

    fill(65, 170, 219, 200);
    rect(width/2 + 90, height-45, 50, 20);
    fill(255, 255, 255);
    text("Paths", width/2 + 95, height-30);
    //println(mousePosX);
  }

  void mousePressed() 
  {
    //check which slider was chosen
    float distEndDate = sqrt((mouseX - endMousePosX)*(mouseX - endMousePosX) + (mouseY - lineHeight)*(mouseY - lineHeight)) ;
    float distStartDate = sqrt((mouseX - startMousePosX)*(mouseX - startMousePosX) + (mouseY - lineHeight)*(mouseY - lineHeight)) ;

    if (distEndDate<20) {
      endDateToggle = true;
    }

    if (distStartDate<20) {
      startDateToggle = true;
    }

    if (mouseX<90 && mouseY> height-46 && mouseY<height) {
      println("PRESSED"); 
      if (cycle) {
        cycle = false;
      }
      else {
        cycle=true;
      }
    }

    rect(width/2 - 60, height-45, 20, 20);
    rect(width/2 + 40, height-45, 20, 20);

    if (mouseX>(width/2 - 60) && mouseX<(width/2 - 40) && mouseY >height-45) {
      cycleSpeed = cycleSpeed - 0.002;
      if (cycleSpeed<0) {
        cycleSpeed = 0.001;
      }
    }

    if (mouseX>(width/2 + 40) && mouseX<(width/2 + 60) && mouseY >height-45) {
      cycleSpeed = cycleSpeed + 0.002;
    }
    
      if (mouseX>(width/2 + 90) && mouseX<(width/2 + 140) && mouseY >height-45) {
      if(drawPaths){
        drawPaths = false;
        println("turn off paths");
      }else{
       drawPaths = true; 
      }
        
    }
  }

  void mouseDragged() 
  {

    if (startDateToggle && mouseX< (endMousePosX-10)) {

      startMousePosX = mouseX;
      if (startMousePosX > width - 20) {
        startMousePosX =  width - 20;
      }

      if (startMousePosX < 20) {
        startMousePosX =  20;
      }

      ////remap numbers
      long dateStart =new Date(date1).getTime();
      long dateEnd =new Date(date2).getTime();

      long diff = dateEnd - dateStart;

      long mouseOff = (startMousePosX -20);
      long offLength = width - 40;

      float factor = (float)((float)mouseOff / (float)offLength);
      long date = (long)(dateStart + (diff * factor));

      // println( (float)((float)mouseOff / (float)offLength));

      cullDateStart = new Date(date).toString();
    }


    if (endDateToggle && mouseX> (startMousePosX+10)) {
      endMousePosX = mouseX;
      if (endMousePosX > width - 20) {
        endMousePosX =  width - 20;
      }

      if (endMousePosX < 20) {
        endMousePosX =  20;
      }
      //println(mouseX);

      ////remap numbers
      long dateStart =new Date(date1).getTime();
      long dateEnd =new Date(date2).getTime();

      long diff = dateEnd - dateStart;

      long mouseOff = (endMousePosX -20);
      long offLength = width - 40;

      float factor = (float)((float)mouseOff / (float)offLength);
      long date = (long)(dateStart + (diff * factor));

      // println( (float)((float)mouseOff / (float)offLength));

      cullDateEnd = new Date(date).toString();
    }
  }

  void mouseReleased() {////////RESET ALL VALUES
    endDateToggle = false;
    startDateToggle = false;
  }


  /*
   * TODO: something like on Close set f to null, this is important if you need to 
   * open more secondapplet when click on button, and none secondapplet is open.
   */
}

public class PFrame extends JFrame {
  public PFrame() {

    setBounds(0, 0, 600, 200);
    s = new secondApplet();
    add(s);
    s.init();
    println("birh");
    show();
  }
}

