package za.co.thecarclinic.app.database;

import za.co.thecarclinic.app.modal.profile.Auth;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Authorize {

    DBConection connection = new DBConection();

    public boolean userExist(Auth auth) {
        String customersIDSql = "SELECT * FROM customers WHERE email = ?";
        try (PreparedStatement stmt = connection.getConnection().prepareStatement(customersIDSql)) {
            stmt.setString(1, auth.getUser());
            stmt.execute();

            ResultSet results = stmt.getResultSet();

            if (results.next()) {
                if (results.getString("email").equals(auth.getUser())
                        && results.getString("password").equals(auth.getPassword())) {
                    return true;
                } else {
                    return false;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
