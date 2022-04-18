package za.co.thecarclinic.app.database;

import java.util.ArrayList;

import za.co.thecarclinic.app.modal.bookings.Booking;
import za.co.thecarclinic.app.modal.bookings.Retrieve;
import za.co.thecarclinic.app.modal.bookings.RequestService;
import za.co.thecarclinic.app.modal.bookings.RespondQuote;
import za.co.thecarclinic.app.modal.bookings.RespondBooking;
import za.co.thecarclinic.app.modal.car.CarRegister;
import za.co.thecarclinic.app.modal.dates.Dates;
import za.co.thecarclinic.app.modal.signup.Register;

public interface CRUD {
    
    /***register the customer
     * inside the database
     * @void**/
    void signUp(Register register);
    
    /***register customers car deatils
     * in the databse
     * @void**/
    boolean carReg(CarRegister carRegister);
    
    /***request for a service
     * store the request of services
     * @void**/
    void requestSrv(RequestService requestService);
    
    /***book for the service
     * store the booked service
     * in the database
     * @void**/
    void book(Booking booking);
    
    public boolean validate(Register request);

    boolean validateCar(CarRegister register);

    ArrayList<CarRegister> getCars(String email);

    ArrayList<Retrieve> getBookings(String email);

    ArrayList<Retrieve> getQuotes(String email);

    boolean updateBookings(RespondBooking respondBooking);

    boolean updateQuotes(RespondQuote respondQoute);

    boolean addDates(Dates date);

    ArrayList<Dates> getDates();
}
