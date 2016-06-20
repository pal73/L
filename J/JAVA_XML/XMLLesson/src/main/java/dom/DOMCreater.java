package dom;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;

public class DOMCreater {
    public static void main(String argv[]) {
        try {
            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

            Document doc = docBuilder.newDocument();
            Element rootElement = doc.createElement("progschool");
            doc.appendChild(rootElement);

            Element course = doc.createElement("course");
            rootElement.appendChild(course);

            Attr attr = doc.createAttribute("id");
            attr.setValue("1");
            course.setAttributeNode(attr);

            Element name = doc.createElement("name");
            name.appendChild(doc.createTextNode("Java Level 1"));
            course.appendChild(name);

            Element teacher = doc.createElement("teacher");
            teacher.appendChild(doc.createTextNode("Ivanov Ivan"));
            course.appendChild(teacher);

            Element hours = doc.createElement("hours");
            hours.appendChild(doc.createTextNode("20"));
            course.appendChild(hours);

            Element day = doc.createElement("day");
            day.appendChild(doc.createTextNode("friday"));
            course.appendChild(day);

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File("src/main/resources/coursesDOMCreater.xml"));

            transformer.transform(source, result);

            System.out.println("File saved!");

        } catch (ParserConfigurationException pce) {
            pce.printStackTrace();
        } catch (TransformerException tfe) {
            tfe.printStackTrace();
        }
    }
}
