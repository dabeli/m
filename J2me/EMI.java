import javax.microedition.lcdui.*;
import javax.microedition.midlet.*; 
import java.io.*;
public class EMI extends MIDlet implements CommandListener
{
 private Form form;
 private Display display;
 private TextField input1, input2;
 private Command add;
 private StringItem item;

 public EMI()
 {
  
 }
 public void startApp()
 {
  display = Display.getDisplay(this);
  form = new Form("EMI Calculator");
  form.append("Hello everybody");
  item = new StringItem("Result", "");

  input1 = new TextField("Principal Amount:", "", 30, TextField.NUMERIC);
  input2 = new TextField("Interest Rate", "", 30, TextField.NUMERIC);
  form.append(input1);
  form.append(input2);
  add = new Command("Calculate emi", Command.OK, 1);
  form.addCommand(add);
  form.append(item);

  form.setCommandListener(this);
  
  display.setCurrent(form);
 }

 public void pauseApp() { }

 public void destroyApp(boolean uncondn)
 {
  notifyDestroyed();
 }
    private void calculate()
 {
  int pri=Integer.parseInt(input1.getString());
  int ri= Integer.parseInt(input2.getString());
  int result= pri*ri/100;
  item.setText( result + "" );

 }
 public void commandAction(Command c, Displayable d)
 {
  String label = c.getLabel();
  if (label.equals("Calculate emi"))
  {
   calculate();
   
  }
 }
}