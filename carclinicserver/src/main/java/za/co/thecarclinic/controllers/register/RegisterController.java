package za.co.thecarclinic.controllers.register;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;
import za.co.thecarclinic.app.database.CRUD;
import za.co.thecarclinic.app.database.Persist;
import za.co.thecarclinic.app.modal.signup.Register;

public class RegisterController {
    public static String REGISTER_PATH = "/register";


    public static void registerController(Context context) {
        Register register = context.bodyAsClass(Register.class);

        CRUD add = new Persist();
        if (add.validate(register)) {
            context.status(HttpCode.FOUND);
        } else {
            add.signUp(register);
            context.status(HttpCode.CREATED);
        }


    }
}