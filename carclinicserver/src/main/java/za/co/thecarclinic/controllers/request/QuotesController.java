package za.co.thecarclinic.controllers.request;

import io.javalin.http.Context;

import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.bookings.RequestService;

public class QuotesController {

    public static String QUOTE_PATH = "/quote";
    static CRUD crud;

    public static void requestQuote(Context context) {
        RequestService requestService = context.bodyAsClass(RequestService.class);

        crud = new Persist();

        crud.requestSrv(requestService);
    }

    public static void getQuotes(Context context) {
        String email = context.queryParam("email");

        crud = new Persist();

        context.json(crud.getQuotes(email));
    }
}
