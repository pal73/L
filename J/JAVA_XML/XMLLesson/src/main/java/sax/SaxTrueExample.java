package sax;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

public class SaxTrueExample {
    public static void main(String argv[]) {
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser saxParser = factory.newSAXParser();

            DefaultHandler handler = new DefaultHandler() {
                boolean name = false;
                boolean teacher = false;
                boolean hours = false;
                boolean day = false;

                public void startElement(String uri, String localName,String qName, Attributes attributes) throws SAXException {
                    System.out.println("Start Element :" + qName);
                    if (qName.equalsIgnoreCase("name")) {
                        name = true;
                    }
                    if (qName.equalsIgnoreCase("teacher")) {
                        teacher = true;
                    }
                    if (qName.equalsIgnoreCase("hours")) {
                        hours = true;
                    }
                    if (qName.equalsIgnoreCase("day")) {
                        day = true;
                    }
                }

                public void endElement(String uri, String localName, String qName) throws SAXException {
                    System.out.println("End Element :" + qName);
                }

                public void characters(char ch[], int start, int length) throws SAXException {
                    if (name) {
                        System.out.println("Name : " + new String(ch, start, length));
                        name = false;
                    }
                    if (teacher) {
                        System.out.println("Teacher : " + new String(ch, start, length));
                        teacher = false;
                    }
                    if (hours) {
                        System.out.println("Hours : " + new String(ch, start, length));
                        hours = false;
                    }
                    if (day) {
                        System.out.println("Day : " + new String(ch, start, length));
                        day = false;
                    }
                }
            };

            saxParser.parse("src/main/resources/courses.xml", handler);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
