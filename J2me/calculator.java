import javax.microedition.lcdui.*;
import javax.microedition.midlet.*; 
import java.io.*;
public class calculator extends MidLet implements CommandListener
{
 private Form form;
 private Display display;
 private TextField input1, input2;
 private Command add, sub, mul,div;
 private StringItem item;

 public void startApp()
 {
  display = Display.getDisplay(this);
  form = new Form("Calculator");
  form.append("Hello everybody");

  input1 = new TextField("First Number : ", "", 30, TextField.NUMERIC);
  input2 = new TextField("Second Number : ", "", 30, TextField.NUMERIC);
  form.append(input1);
  form.append(input2);
  item = new StringItem("Result : ", "");
  form.append(item);

  add = new Command("Addition", Command.OK, 1);
  sub = new Command("Subtraction", Command.OK, 1);
  mul = new Command("Multiplication", Command.OK, 1);
  div = new Command("Division", Command.OK, 1);
  form.addCommand(add);
  form.addCommand(sub);
  form.addCommand(mul);
  form.addCommand(div);  
  display.setCurrent(form);
 }

 public void commandAction(Command cc, Displayable d)
 {
  String label = c.getLabel();
  if (label.equals("Addition"))
  {
   calculate();
  }
  
  else if (label.equals("Subtraction"))
  {
   calculate1();
  }
  
  else if (label.equals("Multiplication"))
  {
   calculate2();
  }
  
  else if (label.equals("Division"))
  {
   calculate3();
  }
 }
 private void calculate()
 {
 	int one=Integer.parseInt(input1.getString());
 	int two= Integer.parseInt(input2.getString());
  	int result=one+two;
  	item.setText( result + "" );
 }
 private void calculate1()
 {
  int one = Integer.parseInt(input1.getString());
  int two = Integer.parseInt(input2.getString());
  int result = one - two;
  item.setText(result + "");
 }
 private void calculate2()
 {
  int one = Integer.parseInt(input1.getString());
  int two = Integer.parseInt(input2.getString());
  int result = one * two;
  item.setText(result + "");
 }
 private void calculate3()
 {
  int one = Integer.parseInt(input1.getString());
  int two = Integer.parseInt(input2.getString());
  int result = (int)one / two;
  item.setText(result + "");
 }
}
