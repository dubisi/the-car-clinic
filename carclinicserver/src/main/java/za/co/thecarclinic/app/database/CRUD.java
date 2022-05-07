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

    /***
     * register the customer
     * inside the database
     * 
     * @return boolean
     **/
    boolean signUp(Register register);

    /***
     * register customers car deatils
     * in the databse
     * 
     * @return void
     **/
    boolean carReg(CarRegister carRegister);

    /***
     * request for a service
     * store the request of services
     * in a database
     * 
     * @return boolean
     **/
    boolean requestSrv(RequestService requestService);

    /***
     * book for the service
     * store the booked service
     * in the database
     * 
     * @return boolean
     **/
    boolean book(Booking booking);

    /**
     * validate the user if already exist or not
     * 
     * @return boolen
     */
    public boolean validate(Register request);

    /**
     * validate if car alredy registered or not
     * 
     * @return boolen
     */
    boolean validateCar(CarRegister register);

    /**
     * get user cars
     * 
     * @return ArrayList
     */
    ArrayList<CarRegister> getCars(String email);

    /**
     * get user bookings
     * 
     * @return ArrayList
     */
    ArrayList<Retrieve> getBookings(String email);

    /**
     * get user quotations
     * 
     * @return ArrayList
     */
    ArrayList<Retrieve> getQuotes(String email);

    /**
     * for admnin to respond to user's request
     * 
     * @return boolean
     */
    boolean updateBookings(RespondBooking respondBooking);

    /**
     * for admin to respond to user's quotations return
     * 
     * @return boolean
     */
    boolean updateQuotes(RespondQuote respondQoute);

    /**
     * for admin to add availability
     * 
     * @return boolean
     */
    boolean addDates(Dates date);

    /**
     * get all the available dates for services
     * 
     * @return ArrayList
     */
    ArrayList<Dates> getDates();
}
