package sax;

import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

public class SAXParser {
    public static void main(String[] args) {
        SAXParserFactory factory = SAXParserFactory.newInstance();
        javax.xml.parsers.SAXParser parser;

        InputStream xmlData = null;
        try {
            xmlData = new FileInputStream("src/main/resources/courses.xml");

            parser = factory.newSAXParser();
            parser.parse(xmlData, new MyParser());


        } catch (FileNotFoundException e) {  // дз переписать с возможностями java 7
            e.printStackTrace();
            // обработки ошибки, файл не найден
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
            // обработка ошибки Parser
        } catch (SAXException e) {
            e.printStackTrace();
            // обработка ошибки SAX
        } catch (IOException e) {
            e.printStackTrace();
            // обработка ошибок ввода
        }

    }
}
