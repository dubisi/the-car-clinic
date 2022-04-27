package za.co.thecarclinic.controllers.car;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;

import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.car.CarRegister;

import java.util.ArrayList;

public class RetrieveCars {

    public static String GET_CAR_PATH = "/car";


    public static void getCars(Context context) {
        String email = context.queryParam("email");

        CRUD crud = new Persist();
        ArrayList<CarRegister> result =
                crud.getCars(email);
        if (!result.isEmpty()) {
            context.status(HttpCode.FOUND);
            context.json(result);
        } else {
            context.json(new ArrayList<>());
        }
    }
}
