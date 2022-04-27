package za.co.thecarclinic.connection;

import io.javalin.Javalin;
import static io.javalin.apibuilder.ApiBuilder.*;

import io.javalin.core.JavalinConfig;
import org.jetbrains.annotations.NotNull;

import za.co.thecarclinic.app.database.CreateTables;
import za.co.thecarclinic.controllers.admin.UpdateStatus;
import za.co.thecarclinic.controllers.car.CarRegisterController;
import za.co.thecarclinic.controllers.car.RetrieveCars;
import za.co.thecarclinic.controllers.dates.DateController;
import za.co.thecarclinic.controllers.home.HomeController;
import za.co.thecarclinic.controllers.login.LoginController;
import za.co.thecarclinic.controllers.register.RegisterController;
import za.co.thecarclinic.controllers.request.BookingController;
import za.co.thecarclinic.controllers.request.QuotesController;

public class CarClinicServer {

    private final Javalin app;

    public CarClinicServer() {
        this.app = createAndConfigureServer();
        setupRoutes(app);
    }

    public static void main(String[] args) {
        CarClinicServer carClinicServer = new CarClinicServer();
        carClinicServer.start(7000);
        CreateTables createTables = new CreateTables();
        createTables.create();

    }

    public void start(int port) {
        app.start(port);
    }

    private void setupRoutes(Javalin server) {
        server.routes(() -> {
            loginRoutes();
            userSignUp();
            homeRoutes();
            car();
            book();
            update();
            quote();
            dates();

        });
    }

    private static void homeRoutes() {
        get(HomeController.HOME_PATH, HomeController::homeController);
    }

    public static void loginRoutes() {
        post(LoginController.LOGIN_PATH, LoginController::loginController);
    }

    public static void userSignUp() {
        post(RegisterController.REGISTER_PATH, RegisterController::registerController);
    }

    public static void car() {
        post(CarRegisterController.CAR_PATH, CarRegisterController::carRegisterController);
        get(RetrieveCars.GET_CAR_PATH, RetrieveCars::getCars);
    }

    public static void book() {
        post(BookingController.BOOKING_PATH, BookingController::bookController);
        get(BookingController.BOOKING_PATH, BookingController::getBookings);
    }

    public static void quote() {
        post(QuotesController.QUOTE_PATH, QuotesController::requestQuote);
        get(QuotesController.QUOTE_PATH, QuotesController::getQuotes);
    }

    public static void update() {
        post(UpdateStatus.UPADATE_BOOK_PATH, UpdateStatus::updateBookings);
        post(UpdateStatus.UPADATE_QUOTE_PATH, UpdateStatus::updateQuotes);

    }

    public static void dates() {
        post(DateController.DATE_PATH, DateController::addDates);
        get(DateController.DATE_PATH, DateController::getDates);

    }

    @NotNull
    private Javalin createAndConfigureServer() {
        return Javalin.create(JavalinConfig::enableCorsForAllOrigins);
    }
}
