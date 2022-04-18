package za.co.thecarclinic.app.database;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CreateTables implements Tables {

    private final DBConection connection = new DBConection();

    @Override
    public void createCustomersTable() {

        String prepState = "CREATE TABLE IF NOT EXISTS 'customers' " +
                "('customerID' INTEGER PRIMARY KEY,'name' NOT NULL,'surname' " +
                "NOT NULL,'number' NOT NULL,'email' NOT NULL UNIQUE," +
                "'password' NOT NULL)";
        try (PreparedStatement statement =
                     connection.getConnection().prepareStatement(prepState)) {
            statement.execute();
            System.out.println("CUSTOMERS TABLE CREATED");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void createCarTable() {

        String prepState = "CREATE TABLE IF NOT EXISTS 'car' ('carID' INTEGER" +
                " PRIMARY KEY,'brand' NOT NULL,'year' NOT NULL,'model' NOT " +
                "NULL,'vinnumber' NOT NULL,'carreg' NOT NULL," +
                "'customersID' INTEGER NOT NULL,FOREIGN KEY " +
                "(customersID) REFERENCES customers(customerID) ON DELETE " +
                "CASCADE)";
        try (PreparedStatement statement =
                     connection.getConnection().prepareStatement(prepState)) {
            statement.execute();
            System.out.println("CARS TABLE CREATED");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void createBookingTable() {

        String prepState = "CREATE TABLE IF NOT EXISTS 'bookings' " +
                "('requestID' INTEGER PRIMARY KEY NOT NULL,'name' NOT NULL," +
                "'surname' NOT NULL,'description' NOT NULL," +
                "'status' NOT NULL,'price' NOT NULL, 'customersCarID' INTEGER,'carID' INTEGER, " +
                "FOREIGN KEY (customersCarID) REFERENCES customers(customerID)," +
                "FOREIGN KEY (carID) REFERENCES car(carID))";
        try (PreparedStatement statement =
                     connection.getConnection().prepareStatement(prepState)) {
            statement.execute();
            System.out.println("REQUESTS TABLE CREATED");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void createQuotesTable() {

        String prepState = "CREATE TABLE IF NOT EXISTS 'quotes' ('quoteID' " +
                "INTEGER PRIMARY KEY,'description' NOT NULL,'price'," +
                "'details','customersCarID' INTEGER,'status' INTEGER NOT NULL" +
                ",FOREIGN KEY (customersCarID) REFERENCES customers" +
                "(customerID))";
        try (PreparedStatement statement =
                     connection.getConnection().prepareStatement(prepState)) {
            statement.execute();
            System.out.println("QUOTES TABLE CREATED");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void createAvailableDatesTable() {

        String prepState = "CREATE TABLE IF NOT EXISTS 'dates' ('datesID' " +
                "INTEGER PRIMARY KEY,'date' NOT NULL UNIQUE)";
        try (PreparedStatement statement =
                     connection.getConnection().prepareStatement(prepState)) {
            statement.execute();
            System.out.println("DATES TABLE CREATED");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void createAdminTable() {

        String prepState = "CREATE TABLE IF NOT EXISTS 'admin' ('adminID' " +
                "INTEGER PRIMARY KEY,'name' NOT NULL,'surname' NOT NULL," +
                "'number' NOT NULL,'email' NOT NULL,'location' NOT NULL,'password' NOT NULL)";
        try (PreparedStatement statement =
                     connection.getConnection().prepareStatement(prepState)) {
            statement.execute();
            System.out.println("ADMIN TABLE CREATED");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void create() {
        createCustomersTable();
        createCarTable();
        createBookingTable();
        createQuotesTable();
        createAdminTable();
        createAvailableDatesTable();
    }

}
