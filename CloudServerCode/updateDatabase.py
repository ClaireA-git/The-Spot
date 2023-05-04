from google.cloud.sql.connector import Connector
import sqlalchemy
from sqlalchemy import Column, Table


def update_database(spots):
    # initialize Connector object
    connector = Connector()

    # function to return the database connection
    def getconn():
        conn = connector.connect(
        "the-spot-ods:us-south1:thespotdb2",
        "pymysql",
        user="root",
        password="theSp0t@69",
        db="parkingLotdb")
        return conn

    # create connection pool
    pool = sqlalchemy.create_engine(
    "mysql+pymysql://",
    creator=getconn,
    )

    with pool.connect() as db_conn:
        results = db_conn.execute(sqlalchemy.text("SELECT * FROM cobbLot")).fetchall()

        # print all rows in the database
#        for row in results:
#            print(row)

        # for each spot, update the database if they are true or false
        for i in range(len(spots)):
            ID = i+1
            if spots[i][2] == False:
                db_conn.execute(sqlalchemy.text("UPDATE cobbLot SET isTaken = False WHERE spotID = {}".format(ID)))
            elif spots[i][2] == True:
                db_conn.execute(sqlalchemy.text("UPDATE cobbLot SET isTaken = True WHERE spotID = {}".format(ID)))
        
        db_conn.commit()

    #close sql connection
    connector.close()
