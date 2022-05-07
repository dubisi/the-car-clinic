package za.co.thecarclinic.app.database;

public interface Tables {

    /**
     * responsible to create customers table
     * if not exist
     * 
     * @return void
     **/
    void createCustomersTable();

    /**
     * responsible to create car details table
     * for customers cars
     * 
     * @return void
     **/
    void createCarTable();

    /***
     * responsible to create customers quotes request
     * table
     * 
     * @return void
     **/
    void createQuotesTable();

    /***
     * responsible to create customers bookings
     * table
     * 
     * @return void
     **/
    void createBookingTable();

    /***
     * responsible create admin table
     * for admin to manage request time to time
     * 
     * @return void
     **/
    void createAdminTable();

    /***
     * responsible create dates table
     *
     *
     * @return void
     **/
    void createAvailableDatesTable();
}
