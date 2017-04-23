import javax.microedition.lcdui.*;
import javax.microedition.midlet.*; 
import java.io.*;
import java.lang.*;
public class incomeTax extends MIDlet implements CommandListener
{
 private Form form;
 private Display display;
 private TextField input1, input2;
 private Command add;
 private StringItem item;

 public incomeTax()
 {
  
 }
 public void startApp()
 {
  display = Display.getDisplay(this);
  form = new Form("Income Tax Calculator");
  form.append("Hello everybody");
  item = new StringItem("Result", "");

  input1 = new TextField("Taxable Income:", "", 30, TextField.NUMERIC);
  form.append(input1);
  add = new Command("Calculate Tax", Command.OK, 1);
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
  int taxableincome=Integer.parseInt(input1.getString());
  int result;
  if (taxableincome <= 60000) {
            result = 0;
        } else if (taxableincome > 60000 && taxableincome <= 150000) {
            result = (taxableincome * 5/100);
        } else if (taxableincome > 150000 && taxableincome <= 500000) {
            result = (taxableincome * 10/100);
        } else {
            result = (taxableincome * 20/100);
        }
        item.setText(result+"");

 }
 public void commandAction(Command c, Displayable d)
 {
  String label = c.getLabel();
  if (label.equals("Calculate Tax"))
  {
   calculate();
   
  }
 }
}