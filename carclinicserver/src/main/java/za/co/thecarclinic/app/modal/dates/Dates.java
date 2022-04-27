package za.co.thecarclinic.app.modal.dates;

import java.time.LocalDate;

public class Dates {

    private LocalDate date;

    public String getDate() {
        return date.toString();
    }

    public void setDate(String date) {
        this.date = LocalDate.parse(date);
    }

}
