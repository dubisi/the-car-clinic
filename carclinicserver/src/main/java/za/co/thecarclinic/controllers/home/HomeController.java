package za.co.thecarclinic.controllers.home;

import io.javalin.http.Context;

public class HomeController {

    public static String HOME_PATH = "/";

    public static void homeController(Context context) {
        context.result("fnb");
    }
}
