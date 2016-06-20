package dom;


import org.w3c.dom.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;

public class DOMUpdater {
    public static void main(String argv[]) {
        try {
            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
            Document doc = docBuilder.parse("src/main/resources/courses.xml");

            Node course = doc.getElementsByTagName("course").item(0);

            NamedNodeMap attr = course.getAttributes();
            Node nodeAttr = attr.getNamedItem("id");
            nodeAttr.setTextContent("25");

            Element category = doc.createElement("category");
            category.appendChild(doc.createTextNode("programming"));
            course.appendChild(category);

            NodeList list = course.getChildNodes();
            for (int i = 0; i < list.getLength(); i++) {
                Node node = list.item(i);
                // update hours
                if ("hours".equals(node.getNodeName())) {
                    node.setTextContent("100");
                }
                //remove day
                if ("day".equals(node.getNodeName())) {
                    course.removeChild(node);
                }
            }

            // write in xml file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File("src/main/resources/courseDOMUpdater.xml"));
            transformer.transform(source, result);
            System.out.println("Done");

        } catch (ParserConfigurationException pce) {
            pce.printStackTrace();
        } catch (TransformerException tfe) {
            tfe.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch (SAXException sae) {
            sae.printStackTrace();
        }
    }
}
