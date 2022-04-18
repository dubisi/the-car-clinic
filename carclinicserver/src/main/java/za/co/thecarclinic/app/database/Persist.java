package za.co.thecarclinic.app.database;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import za.co.thecarclinic.app.modal.bookings.Booking;
import za.co.thecarclinic.app.modal.bookings.Retrieve;
import za.co.thecarclinic.app.modal.bookings.RequestService;
import za.co.thecarclinic.app.modal.bookings.RespondQuote;
import za.co.thecarclinic.app.modal.bookings.RespondBooking;
import za.co.thecarclinic.app.modal.car.CarRegister;
import za.co.thecarclinic.app.modal.dates.Dates;
import za.co.thecarclinic.app.modal.signup.Register;

public class Persist implements CRUD {
    private final ArrayList<CarRegister> cars = new ArrayList<>();
    private final ArrayList<Retrieve> bookings = new ArrayList<>();
    private final ArrayList<Dates> dates = new ArrayList<>();
    DBConection dbConection = new DBConection();

    @Override
    public void signUp(Register register) {

        String prepState = "INSERT INTO customers(name,surname,number,email," +
                "password) values(?,?,?,?,?)";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(prepState)) {
            statement.setString(1, register.getName());
            statement.setString(2, register.getSurname());
            statement.setString(3, register.getNumber());
            statement.setString(4, register.getEmail());
            statement.setString(5, register.getPassword());
            int result = statement.executeUpdate();
            System.out.println(result);

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public boolean carReg(CarRegister carRegister) {

        String updateSql = "SELECT customerID FROM customers WHERE email = ?";
        String customerID;
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(updateSql)) {
            statement.setString(1, carRegister.getEmail());
            statement.execute();

            ResultSet results = statement.getResultSet();
            customerID = String.valueOf(results.getInt("customerID"));

        } catch (SQLException e) {
            return false;
        }

        System.out.println(customerID);
        String prepState = "INSERT INTO car(brand,year,model,vinnumber," +
                "carreg,location,customersID) values(?,?,?,?,?,?,?)";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(prepState)) {
            statement.setString(1, carRegister.getBrand());
            statement.setString(2, carRegister.getYear());
            statement.setString(3, carRegister.getModel());
            statement.setString(4, carRegister.getVinNumber());
            statement.setString(5, carRegister.getCarReg());
            statement.setString(6, carRegister.getLocation());
            statement.setString(7, customerID);
            int result = statement.executeUpdate();
            System.out.println(result);
            if (result == 1) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void requestSrv(RequestService requestService) {

        String requestSql = "SELECT customerID FROM customers WHERE email = ?";
        String customerID = "";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(requestSql)) {
            statement.setString(1, requestService.getEmail());
            statement.execute();

            ResultSet results = statement.getResultSet();

            customerID = results.getString("customerID");

        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println(customerID);
        String prepState = "INSERT INTO quotes(description,status," +
                "customersCarID) values(?,?,?)";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(prepState)) {
            statement.setString(1, requestService.getDescription());
            statement.setString(2, "pending");
            statement.setString(3, customerID);
            int result = statement.executeUpdate();
            System.out.println(result);

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void book(Booking booking) {

        String customersIDSql = "SELECT customerID,name,surname,carID FROM " +
                "customers,car WHERE email = ? AND brand = ?";
        String customerID = null;
        String name = null;
        String surname = null;
        String carID = null;

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(customersIDSql)) {
            statement.setString(1, booking.getEmail());
            statement.setString(2, booking.getCar());
            statement.execute();

            ResultSet results = statement.getResultSet();
            name = results.getString("name");
            surname = results.getString("surname");
            customerID = results.getString("customerID");
            carID = results.getString("carID");

        } catch (SQLException e) {
            e.printStackTrace();
        }

        String prepState = "INSERT INTO bookings('name','surname'," +
                "'description','status','price','customersCarID','carID') " +
                "values(?,?,?,?,?,?,?)";
        try (PreparedStatement statement1 =
                     dbConection.getConnection().prepareStatement(prepState)) {
            statement1.setString(1, name);
            statement1.setString(2, surname);
            statement1.setString(3, booking.getDescription());
            statement1.setString(4, "pending");
            statement1.setString(5, booking.getPrice());
            statement1.setString(6, customerID);
            statement1.setString(7, carID);
            int result = statement1.executeUpdate();
            System.out.println(result);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<CarRegister> getCars(String email) {
        String carSql = "SELECT * FROM car,customers WHERE email = ? AND " +
                "customerID == customersID";

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(carSql)) {
            statement.setString(1, email);
            statement.execute();

            ResultSet results = statement.getResultSet();

            while (results.next()) {
                CarRegister carRegister = new CarRegister();
                carRegister.setBrand(results.getString("brand"));
                carRegister.setModel(results.getString("model"));
                carRegister.setYear(results.getString("year"));
                carRegister.setCarReg(results.getString("carreg"));
                carRegister.setLocation(results.getString("location"));
                carRegister.setVinNumber(results.getString("vinnumber"));
                cars.add(carRegister);

            }
            return cars;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    @Override
    public ArrayList<Retrieve> getBookings(String email) {
        String carSql = "SELECT * FROM customers,bookings,car WHERE email = ?" +
                " AND customerID == customersID";

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(carSql)) {
            statement.setString(1, email);
            statement.execute();

            ResultSet results = statement.getResultSet();

            while (results.next()) {
                Retrieve bookingRetrieve = new Retrieve();
                bookingRetrieve.setName(results.getString("name"));
                bookingRetrieve.setSurname(results.getString("surname"));
                bookingRetrieve.setEmail(email);
                bookingRetrieve.setCar(results.getString("brand"));
                bookingRetrieve.setLocation(results.getString("location"));
                bookingRetrieve.setDescription(results.getString("description"
                ));
                bookingRetrieve.setPrice(results.getString("price"));
                bookingRetrieve.setStatus(results.getString("status"));
                bookings.add(bookingRetrieve);

            }
            return bookings;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public ArrayList<Retrieve> getQuotes(String email) {
        String carSql = "SELECT * FROM quotes,car,customers WHERE email = ? " +
                "AND customerID == customersCarID";

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(carSql)) {
            statement.setString(1, email);
            statement.execute();

            ResultSet results = statement.getResultSet();

            while (results.next()) {
                Retrieve quotesRetrieve = new Retrieve();
                quotesRetrieve.setName(results.getString("name"));
                quotesRetrieve.setSurname(results.getString("surname"));
                quotesRetrieve.setEmail(results.getString("email"));
                quotesRetrieve.setCar(results.getString("brand"));
                quotesRetrieve.setLocation(results.getString("location"));
                quotesRetrieve.setDescription(results.getString("description"));
                quotesRetrieve.setPrice(results.getString("price"));
                quotesRetrieve.setDetails(results.getString("details"));
                quotesRetrieve.setStatus(results.getString("status"));
                bookings.add(quotesRetrieve);

            }
            return bookings;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public boolean updateBookings(RespondBooking respondBooking) {

        String customersIDSql = "SELECT customerID FROM customers WHERE email" +
                " = ?";
        String customerID = "";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(customersIDSql)) {
            statement.setString(1, respondBooking.getEmail());
            statement.execute();

            ResultSet results = statement.getResultSet();

            customerID = results.getString("customerID");

        } catch (SQLException e) {
            e.printStackTrace();
        }

        String carSql = "UPDATE bookings SET status = ? WHERE customersCarID " +
                "= ?";

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(carSql)) {
            statement.setString(1, respondBooking.getStatus());
            statement.setString(2, customerID);


            return statement.execute();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateQuotes(RespondQuote respondQoute) {

        String updateQuotesSql = "SELECT customerID FROM customers WHERE " +
                "email = ?";
        String customerID = "";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(updateQuotesSql)) {
            statement.setString(1, respondQoute.getEmail());
            statement.execute();

            ResultSet results = statement.getResultSet();

            customerID = results.getString("customerID");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        String carSql = "UPDATE quotes SET status = ?,price = ?,details = ? " +
                "WHERE customersCarID = ?";

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(carSql)) {
            statement.setString(1, respondQoute.getStatus());
            statement.setString(2, respondQoute.getPrice());
            statement.setString(3, respondQoute.getDetails());
            statement.setString(4, customerID);

            statement.execute();

            return statement.execute();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean validate(Register register) {
        String prepState = "SELECT * FROM customers WHERE email = ?";
        return statement(register, prepState);

    }

    @Override
    public boolean validateCar(CarRegister register) {
        String sql = "SELECT * FROM car WHERE vinnumber = ?";
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(sql)) {

            statement.setString(1, register.getVinNumber());
            statement.execute();
            ResultSet results = statement.getResultSet();
            return results.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    @Override
    public boolean addDates(Dates date) {
        String prepState = "INSERT INTO dates('date') values(?)";

        try (PreparedStatement statement1 =
                     dbConection.getConnection().prepareStatement(prepState)) {
            statement1.setString(1, date.getDate());

            int result = statement1.executeUpdate();
            System.out.println(result);
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ArrayList<Dates> getDates() {
        String carSql = "SELECT * FROM dates";

        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(carSql)) {

            statement.execute();

            ResultSet results = statement.getResultSet();

            while (results.next()) {
                Dates date = new Dates();
                date.setDate(results.getString("date"));
                dates.add(date);

            }
            return dates;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dates;
    }

    private boolean statement(Register register, String sql) {
        try (PreparedStatement statement =
                     dbConection.getConnection().prepareStatement(sql)) {

            statement.setString(1, register.getEmail());
            statement.execute();
            ResultSet results = statement.getResultSet();
            return results.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


}
