package dom;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;

public class DOMParser {

    public static void main(String args[]) {

        try {
            File fXmlFile = new File("src/main/resources/courses.xml");
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);
            System.out.println("Root element : " + doc.getDocumentElement().getNodeName());
            NodeList nodeList = doc.getElementsByTagName("course");
            System.out.println("----------------------------");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                System.out.println("\nCurrent Element : " + node.getNodeName());
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) node;
                    System.out.println("Course id : " + element.getAttribute("id"));
                    System.out.println("Name : " + element.getElementsByTagName("name").item(0).getTextContent());
                    System.out.println("Teacher : " + element.getElementsByTagName("teacher").item(0).getTextContent());
                    System.out.println("Hours : " + element.getElementsByTagName("hours").item(0).getTextContent());
                    System.out.println("Day : " + element.getElementsByTagName("day").item(0).getTextContent());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
