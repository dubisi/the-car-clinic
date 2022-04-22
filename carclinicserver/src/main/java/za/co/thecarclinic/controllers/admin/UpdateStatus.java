package za.co.thecarclinic.controllers.admin;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;

import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.bookings.RespondQuote;
import za.co.thecarclinic.app.modal.bookings.RespondBooking;

public class UpdateStatus {

    public static String UPADATE_BOOK_PATH = "/update/booking";
    public static String UPADATE_QUOTE_PATH = "/update/quote";

    private static CRUD crud = new Persist();

    public static void updateBookings(Context context) {

        RespondBooking respondBooking = context.bodyAsClass(RespondBooking.class);

        if (crud.updateBookings(respondBooking)) {
            context.json(HttpCode.CREATED);
        } else {
            context.json(HttpCode.BAD_REQUEST);
        }

    }

    public static void updateQuotes(Context context) {

        RespondQuote respondQoute = context.bodyAsClass(RespondQuote.class);

        if (crud.updateQuotes(respondQoute)) {
            context.status(HttpCode.CREATED);
        } else {
            context.json(HttpCode.BAD_REQUEST);
        }

    }

}
