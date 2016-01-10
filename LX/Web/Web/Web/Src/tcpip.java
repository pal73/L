import java.*;
import java.lang.*;
import java.net.*;
import java.util.*;
import java.io.*;

/*
 * This class opens a TCP connection, and allows reading and writing of byte arrays.
 */

public class tcpip
{
	protected Socket s = null;
	public DataInputStream dis = null;
	protected DataOutputStream dos = null;

	public tcpip(InetAddress ipa, int port)
	{
		Socket s1 = null;
	    try { 				// Open the socket
			s1 = new Socket(ipa.getHostAddress(), port);
		}
	    catch (IOException e) {
			System.out.println("Error opening socket");
			return;
		}
		s = s1;
		try {				// Create an input stream
			dis = new DataInputStream(new BufferedInputStream(s.getInputStream()));
		}
		catch(Exception ex) {
			System.out.println("Error creating input stream");
		}
		try	{				// Create an output stream
			dos = new DataOutputStream(new BufferedOutputStream(s.getOutputStream()));
		}
		catch(Exception ex) {
		    System.out.println("Error creating output stream");
		}
	}

	public synchronized void disconnect()
	{
		if (s != null) {
		    try {
				s.close();
			}
	    	catch (IOException e){}
		}
	}

	public synchronized void send(byte[] temp)
	{
		try {
			dos.write(temp, 0, temp.length);
			dos.flush();
		}
		catch(Exception ex) {
		    System.out.println("Error sending data : " + ex.toString());
		}
	}

	public synchronized void send(byte[] temp, int len)
	{
		try {
			dos.write(temp, 0, len);
			dos.flush();
		}
		catch(Exception ex) {
		    System.out.println("Error sending data : " + ex.toString());
		}
	}

	public synchronized void send(String given)
	{
				// WARNING: this routine may not properly convert Strings to bytes
		int length = given.length();
		byte[] retvalue = new byte[length];
		char[] c = new char[length];
		given.getChars(0, length, c, 0);
		for (int i = 0; i < length; i++) {
			retvalue[i] = (byte)c[i];
 		}
		send(retvalue);
	}

	public synchronized byte[] receive()
	{
		byte[] retval = new byte[0];

		try {
			while(dis.available() == 0);  /* Wait for data */
		}
		catch (IOException e){}
		try {
			retval = new byte[dis.available()];
		} catch (IOException e){}
		try {
			dis.read(retval);
		} catch (IOException e){}
		return(retval);
	}

	public int available()
	{
		int avail;

		avail = 0;
		try {
			avail = dis.available();
		} catch (IOException e) {}

		return(avail);
	}
}
