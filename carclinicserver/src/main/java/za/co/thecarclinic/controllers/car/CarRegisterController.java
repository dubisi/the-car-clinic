package za.co.thecarclinic.controllers.car;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;
import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.car.CarRegister;

public class CarRegisterController {

    public static String CAR_PATH = "/car";

    public static void carRegisterController(Context context) {

        CRUD crud = new Persist();

        CarRegister carRegister = context.bodyAsClass(CarRegister.class);

        if (crud.validateCar(carRegister)) {
            context.status(HttpCode.FOUND);
        } else {
            if (crud.carReg(carRegister)) {
                context.status(HttpCode.CREATED);
            } else {
                context.status(HttpCode.BAD_REQUEST);
            }
        }
    }
}