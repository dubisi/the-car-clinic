package za.co.thecarclinic.app.database;

public interface Tables {

    /**
     * responsible to create customers table
     * if not exist
     * 
     * @void
     **/
    void createCustomersTable();

    /**
     * responsible to create car details table
     * for customers cars
     * 
     * @void
     **/
    void createCarTable();

    /***
     * responsible to create customers quotes request
     * table
     * 
     * @void
     **/
    void createQuotesTable();

    /***
     * responsible to create customers bookings
     * table
     * 
     * @void
     **/
    void createBookingTable();



    /***
     * responsible create admin table
     * for admin to manage request time to time
     * 
     * @void
     **/
    void createAdminTable();

    /***
     * responsible create dates table
     *
     *
     * @void
     **/
    void createAvailableDatesTable();
}
