package jaxb;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Course {

    private int id;
    private String name;
    private String teacher;
    private int hours;
    private String day;

    public int getId() {
        return id;
    }

    @XmlAttribute
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    @XmlElement
    public void setName(String name) {
        this.name = name;
    }

    public String getTeacher() {
        return teacher;
    }

    @XmlElement
    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public int getHours() {
        return hours;
    }

    @XmlElement
    public void setHours(int hours) {
        this.hours = hours;
    }

    public String getDay() {
        return day;
    }

    @XmlElement
    public void setDay(String day) {
        this.day = day;
    }
}
