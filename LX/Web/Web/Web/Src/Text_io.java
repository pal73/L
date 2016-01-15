import java.awt.*;
import java.awt.event.*;
import java.lang.*;

public class Text_io extends Panel implements Runnable, TextListener {
    private tcpip gtp;
    String oldmessage = new String("");
  	TextArea input_box  = new TextArea("", 10, 60, 3);
  	TextArea output_box = new TextArea("", 10, 60, 3);
	Thread timer;

  	public Text_io(tcpip tp) {
		gtp = tp;

		setLayout(new GridBagLayout());
    		GridBagConstraints c = new GridBagConstraints();
		c.insets =  new Insets(5,5,5,5);
		setBackground(java.awt.Color.lightGray);
		setSize(561,380);

		c.gridx = 0; c.gridy = 2; c.gridwidth = 1; c.gridheight = 1;
		c.weightx = 0.0; c.weighty = 0.0; c.anchor = GridBagConstraints.WEST;
		c.fill = GridBagConstraints.NONE;
		add((new Label("To Device Server:  (Type Here--->)")), c);

		//input_box
		input_box.addTextListener(this);
	//	input_box.setText(oldmessage);
		c.gridx = 1; c.gridy = 2; c.gridwidth = 3; c.gridheight = 1;
		c.weightx = 0.5; c.weighty = 0.0; c.anchor = GridBagConstraints.CENTER;
		c.fill = GridBagConstraints.BOTH;
		add(input_box,c);

		c.gridx = 0; c.gridy = 4; c.gridwidth = 1; c.gridheight = 1;
		c.weightx = 0.0; c.weighty = 0.0; c.anchor = GridBagConstraints.WEST;
		c.fill = GridBagConstraints.NONE;
		add((new Label("From Device Server:")), c);

		c.gridx = 1; c.gridy = 4; c.gridwidth = 3; c.gridheight = 1;
		c.weightx = 0.5; c.weighty = 0.0; c.anchor = GridBagConstraints.CENTER;
		c.fill = GridBagConstraints.BOTH;
		add(output_box,c);
		output_box.setEditable(false);
		timer = new Thread(this);
		timer.start();
	}

	public void run() {
		int i;
		byte[] in;
	    Thread me = Thread.currentThread();
	    while (timer == me) {
	        try {
	            Thread.currentThread().sleep(200);
	        } catch (InterruptedException e) { }
	        if ( (gtp != null) && ((i = gtp.available()) > 0) ) {
				in = gtp.receive();
						/* remove non-printing bytes */
				for (i = 0; i < in.length; i++) {
					if (in[i] < 0x20)
						in[i] = 0x20;
				}
				output_box.append((new String(in)));
			}
	    }
	}

    public void textValueChanged(TextEvent e) {
		int len, i;
		String str = new String("");
		String message = input_box.getText();
		len = message.length() - oldmessage.length();
		if (len < 0) {
			for (i = 0; i < -len; i++)
				str += "\b";
			//System.out.println("Backspace");
		}
		else if (len > 0) {
			str = message.substring(oldmessage.length());
			//System.out.println("len = "+str.length()+" str = "+str);
		}
		oldmessage = message;
		if ( (len != 0) && (gtp != null) )
			gtp.send(str);
    }

}