import javax.microedition.lcdui.*;
import javax.microedition.midlet.*; 
import java.io.*;
public class EMI extends MidLet implements CommandListener
{
 private Form form;
 private Display display;
 private TextField input1, input2;
 private Command add;
 private StringItem item;

 public void startApp()
 {
  display = Display.getDisplay(this);
  form = new Form("EMI Calculator");
  form.append("Hello everybody");

  input1 = new TextField("Principal Amount : ", "", 30, TextField.NUMERIC);
  input2 = new TextField("Interest Rate : ", "", 30, TextField.NUMERIC);
  form.append(input1);
  form.append(input2);
  item = new StringItem("Result: ", "");
  form.append(item);
  
  add = new Command("Calculate EMI", Command.OK, 1);
  form.addCommand(add);
  display.setCurrent(form);
 }

    private void calculate()
 {
  int pri=Integer.parseInt(input1.getString());
  int ri= Integer.parseInt(input2.getString());
  int result= pri*ri/100;
  item.setText( result + "" );
 }
 public void commandAction(Command cc, Displayable d)
 {
  String label = c.getLabel();
  if (label.equals("Calculate emi"))
  {
   calculate();
  }
 }
}
