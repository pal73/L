package jaxb;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import java.io.File;

public class ConverterToXML {
    public static void main(String[] args) {
        Course java = new Course();
        java.setId(1);
        java.setName("Java Level 1");
        java.setTeacher("Ivanov Ivan");
        java.setHours(20);
        java.setDay("friday");

        try {
            File file = new File("src/main/resources/coursesJAXBConverterToXML.xml");
            JAXBContext jaxbContext = JAXBContext.newInstance(Course.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

            // sexy output
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

            jaxbMarshaller.marshal(java, file);
            jaxbMarshaller.marshal(java, System.out);
        } catch (JAXBException e) {
            e.printStackTrace();
        }

    }
}
