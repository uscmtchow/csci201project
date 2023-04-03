package CSCI201Quiz;

import java.io.PrintWriter;

import com.google.gson.Gson;

public class Util {

	public static void printJsonMsg(String msg, PrintWriter pw) {
		Gson gson = new Gson();
		pw.write(gson.toJson(msg));
		pw.flush();
	}
	public static void printMsg(String msg, PrintWriter pw) {
//		Gson gson = new Gson();
		pw.write(msg);
		pw.flush();
	}
	public static String URLify(String input){
        return input.stripTrailing().replaceAll(" ","%20");
    }
	
}
