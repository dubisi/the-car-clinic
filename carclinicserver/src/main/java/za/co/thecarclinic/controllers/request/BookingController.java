package za.co.thecarclinic.controllers.request;

import io.javalin.http.Context;
import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.bookings.Booking;

public class BookingController {

    public static String BOOKING_PATH = "/book";
    private static CRUD crud;

    public static void bookController(Context context) {
        Booking booking = context.bodyAsClass(Booking.class);
        crud = new Persist();

        crud.book(booking);
    }

    public static void getBookings(Context context) {
        String email = context.queryParam("email");
        crud = new Persist();

       context.json(crud.getBookings(email));
    }

}
