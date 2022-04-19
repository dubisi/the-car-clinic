package za.co.thecarclinic.app.modal.dates;

import java.time.LocalDate;

public class Dates {

    private LocalDate date;

    public LocalDate getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = LocalDate.parse(date);
    }

    


}
