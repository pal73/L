package jaxb;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import java.io.File;

public class ConverterToObject {
    public static void main(String[] args) {
        try {
            File file = new File("src/main/resources/coursesJAXBConverterToXML.xml");
            JAXBContext jaxbContext = JAXBContext.newInstance(Course.class);

            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
            Course course = (Course) jaxbUnmarshaller.unmarshal(file);
            System.out.println(course);
            System.out.println(course.getName());
            System.out.println(course.getDay());
            System.out.println(course.getHours());
        } catch (JAXBException e) {
            e.printStackTrace();
        }

    }
}
