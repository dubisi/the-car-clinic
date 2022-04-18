package za.co.thecarclinic.controllers.dates;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;
import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.dates.Dates;

public class DateController {

    public static String DATE_PATH = "/date";

    public static void addDates(Context context) {

        CRUD crud = new Persist();

        Dates dates = context.bodyAsClass(Dates.class);

        if (crud.addDates(dates)) {
            context.status(HttpCode.CREATED);
        } else {
            context.status(HttpCode.BAD_REQUEST);
        }
    }

    public static void getDates(Context context) {

        CRUD crud = new Persist();



            context.json(crud.getDates());

    }
}
