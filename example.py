import requests
import pprint, json
from timeit import default_timer as timer

import MySQLdb
from datetime import datetime, timedelta, date
import time  
from dateutil.parser import parse
import datetime as dt

        
class main:
    def __init__(self):
        while(1):
            start = timer()
            print "============================================================"
            self.loop()
            end = timer()
            #print(end - start)
            self.wait(5)

    def wait(self, n):
        #Wait until the next increment of n seconds
        x = time.time()
        time.sleep(n - (x % n))

    def loop(self):
        #self.db = MySQLdb.connect(host="192.168.43.33", user="thompson", passwd="root", db="indianrail")
        self.db = MySQLdb.connect(host="localhost", user="root", passwd="", db="indianrail")
        self.cur = self.db.cursor()
        self.cur.execute("use indianrail")
        self.cur.fetchall()

        firstquery = "Select train_no, load_time, pkm_id from `package_train_mapping` where load_unload_status='L' "
        self.cur.execute(firstquery)
        allPackagesDetails = self.cur.fetchall()

       
        for packageDetails in allPackagesDetails:

            output = self.getDetails(packageDetails)

            

            if (len(output) == 6):
                    d1, d2, d3, d4, d5, d6= output
                    location = d1
                    date = d2
                    time = d3
                    pkm_id = d4
                    delay_time = d5
                    station_name = d6
                    
                    db_date = datetime.strptime(str(d2),'%d %b %Y').strftime('%Y-%m-%d')
                    print db_date

                    time_1 = datetime.strptime(str(d3), '%H:%M')
                    time_1 = dt.time(time_1.hour, time_1.minute)

                    date_1 = datetime.strptime(str(db_date), '%Y-%m-%d')
                    date_1 = dt.date(date_1.year, date_1.month, date_1.day)
                    print time_1
                    print date_1

                    datetime_obj = datetime.combine(date_1, time_1)
                    print datetime_obj

                    insertQuery = "Insert into `package_location`(location, time, pkm_id, delay, station_name)" \
                                    "values(%s,%s,%s,%s,%s)"
                        
                    args = (location, datetime_obj, pkm_id, delay_time, station_name )
                    
                    self.cur.execute(insertQuery,args)
                    self.db.commit()
     

    def getDetails(self, packageDetails):

        trainNo, load_time, pkm_id = packageDetails
        print trainNo
        print load_time
        print pkm_id

        new_time=load_time.date()
        print new_time

        final_time = datetime.strptime(str(new_time), '%Y-%m-%d').strftime('%Y%m%d')
        print final_time
        
        #apikey = "5h84viny"
        apikey = "yc81f8z2"

        query = "http://api.railwayapi.com/live/train/{0}/doj/{1}/apikey/{2}".format(trainNo, final_time, apikey)
        print query
        r = requests.post(query)
        data = json.loads(r.text)

        #print data

        #access train name,train no,delay,time

        #location = data['current_station']
        #print location
        #pprint.pprint(data)
        #pprint.pprint( data['current_station'])
        
        if 'current_station' not in data:
            print "Train is not scheduled yet"
        else:
            location = data['current_station']['station']
            print location
            date = data['current_station']['actarr_date']
            print date
            arrtime = data['current_station']['actarr']
            print arrtime
            delay = data['current_station']['latemin']
            if delay > 0:
                delay_time = str(delay)+"(delay)"
            else:
                delay_time = str(delay)+"(early)"
                
            print delay_time
            station_name = data['current_station']['station_']['name']
            print station_name
            return (location, date, arrtime, pkm_id, delay_time, station_name)

        return (None, None)

print "THE OBJECT ORIENTED WAY"
main()
            
