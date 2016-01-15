/*
	A basic extension of the java.applet.Applet class
 */

import java.awt.*;
import java.awt.event.*;
import java.applet.Applet;
import java.net.*;
import java.io.*;
import java.lang.*;
import java.text.*;
import java.util.*;


public class Test extends Applet { // implements TextListener {
	static private boolean isapplet = true;
	static private InetAddress arg_ip = null;
	static private int arg_port = 0;
    public tcpip gtp = null;;
	InetAddress reader_ip = null;
	int port = 10001;

	public void init()
	{
		gtp = null;
		reader_ip = null;
		port = 10001;
	}

	public void start()
	{
		String st = new String("TCP/IP connection status: ");
		setFont(new Font("Dialog",Font.BOLD,16));
		setLayout(new GridBagLayout());
    	GridBagConstraints c = new GridBagConstraints();
    	c.gridx = 0; c.gridy = 0; c.gridwidth = 1; c.gridheight = 1;
		c.anchor = GridBagConstraints.CENTER;
		c.fill = GridBagConstraints.BOTH;
		c.insets =  new Insets(5,5,5,5);
		setBackground(Color.yellow);
		setSize(600,500);

							/* Either get the IP address from the HTTP server if we're
							   an applet, or from the commandline (if passed). */
		if (isapplet) {
			try{
				reader_ip = InetAddress.getByName(getCodeBase().getHost());
			}
			catch (UnknownHostException e){}
		}
		else {
			reader_ip = arg_ip;
			if (arg_port != 0) {
				port = arg_port;
			}
		}
							/* Open a socket to the device server's serial port */
		if (reader_ip != null) {
			if (gtp == null) {
				gtp = new tcpip(reader_ip, port);
				if (gtp.s == null) {
					st += "Connection FAILED!";
					gtp = null;
				}
			}
		}
		if (gtp == null) {
			st += "Not Connected";
			add((new Label(st)), c);
			return;
		}
		st += "Connected";
		add((new Label(st)), c);
						/* You may now perform IO with the Device Server via
						 *		gtp.send(byte[] data_out);
						 *		byte[] data_in = gtp.receive();
						 * functions.
						 * In our example we'll use two TextBoxes which have been extended
						 * to handle IO to the device server.  Data typed in the upper
						 * text box will be sent to the Device Server, and data received
						 * will be displayed in the lower text box.
						*/
	/* Start of custom application code */
		c.gridx = 0; c.gridy = 2; c.gridwidth = 3; c.gridheight = 1;
		c.anchor = GridBagConstraints.WEST;
		add((new Text_io(gtp)), c);
	/* End of custom application code */
	}

	public void destroy()
	{
		if (gtp != null)
			gtp.disconnect();
		gtp = null;
	}

	public void stop() {
	}

    public static void main(String[] args) {
		Frame frame = new Frame("TCP/IP Test");
        frame.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
		if (args.length > 0) {
			try{
				arg_ip = InetAddress.getByName(args[0]);
			}
			catch (UnknownHostException e){}
			if (args.length > 1) {
				try {
					arg_port = Integer.valueOf(args[1]).intValue();
				}
				catch (NumberFormatException e) {}
			}
		}
		Test ap = new Test();
		frame.add(ap);
		ap.init();
		isapplet = false;
		ap.start();
	    frame.pack();
//		frame.show();
			frame.setVisible(true);
	}
}