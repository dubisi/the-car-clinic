package za.co.thecarclinic.app.modal.bookings;

import java.time.LocalDate;

public class Booking {

    private String email;
    private String description;
    private String carReg;
    private String price;
    private LocalDate localDate;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCarReg() {
        return carReg;
    }

    public void setCarReg(String carReg) {
        this.carReg = carReg;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public LocalDate getLocalDate() {
        return localDate;
    }

    public void setLocalDate(String localDate) {
        this.localDate = LocalDate.parse(localDate);
    }
}