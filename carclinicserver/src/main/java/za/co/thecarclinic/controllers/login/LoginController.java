package za.co.thecarclinic.controllers.login;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;
import za.co.thecarclinic.app.database.Authorize;
import za.co.thecarclinic.app.modal.profile.Auth;

public class LoginController {
    
    public static String LOGIN_PATH = "/login";

    public static void loginController(Context context){
        Auth auth = context.bodyAsClass(Auth.class);

        Authorize authorize = new Authorize();

        if (authorize.userExist(auth)) {
            context.status(HttpCode.ACCEPTED);
        } else {
        context.status(HttpCode.UNAUTHORIZED);
        }
    }
}
