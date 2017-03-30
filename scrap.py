import requests
import re
import sys
import time
from timeit import default_timer as timer

import MySQLdb

from datetime import datetime, timedelta, date
from pprint import pprint
from bs4 import BeautifulSoup

class main:
    def __init__(self):
        while(1):
            start = timer()
            print "==================="
            self.loop()
            end = timer()
            #print (start-end)
            self.wait(5)

    def wait(self, n):
        #wait until increment of next n seconds
        x = time.time()
        time.sleep(n - ( x % n))

    def loop(self):

        self.db = MySQLdb.connect(host="localhost", user="root", passwd="", db="indianrail")
        self.cur = self.db.cursor()
        self.cur.execute("use indianrail")
        self.cur.fetchall()

        firstquery = "Select train_no, load_time, pkm_id, src_station_code from `package_train_mapping`,package_details where" \
                " package_train_mapping.pkg_id = package_details.pkg_id and load_unload_status = 'L'"
        self.cur.execute(firstquery)
        allPackageDetails = self.cur.fetchall()

        for packageDetails in allPackageDetails:
            output = self.getDetails(packageDetails)

            if len(output) == 5:
                d1, d2, d3, d4, d5 = output
                location = d1
                timeAt = d2
                pkm_id = d3
                delay_time = d4
                station_name = d5

                print timeAt

                datetime_obj = datetime.strptime(str(datetime.now().year) + " " + timeAt , '%Y %d-%b %H:%M')
                #print datetime_obj
                insertquery = "insert into `package_location`(location, time, pkm_id, delay, station_name)" \
                          "values(%s, %s, %s, %s, %s)"
                args = (location, datetime_obj, pkm_id, delay_time, station_name)

                self.cur.execute(insertquery, args)
                self.db.commit()

    def getDetails(self, packageDetails):
        trainNo, journeyStartTime, pkm_id, journeyStartStation = packageDetails

        r = requests.post("http://enquiry.indianrail.gov.in/mntes/q?opt=TrainRunning&subOpt=FindStationList",
                          params = {'trainNo' : trainNo,}, timeout=1)
        data = r.text
        soup = BeautifulSoup(data, 'html.parser')

        outputFile = open("bg1.html", "w")
        outputFile.write(r.text)

        k = soup.find_all('select')
        allStations = [i for i in list(k[0].children)[2:] if len(str(i).strip()) > 0 ]

        allStationsOrder = [i['value'].split('#')[0] for i in allStations]
        allStationsEnum = dict([(i['value'].split('#')[0], (i.text, i['title'])) for i in allStations])

        #print allStationsEnum

        journeyDate = journeyStartTime.strftime('%d-%b-%Y')
        journeyDay = journeyStartTime.strftime('%a')

        # print journeyDate
        #print journeyDay

        #print journeyStartStation

        trainRunning = journeyDay in allStationsEnum[journeyStartStation][1]
        print "whether train no " + str(trainNo) + " is running today? ", trainRunning

        params = {'trainNo':trainNo, 'jStation': journeyStartStation + '#false', 'jDate':journeyDate,
                  'jDateDay' : journeyDay }
        r = requests.post("http://enquiry.indianrail.gov.in/mntes/q?opt=TrainRunning&subOpt=ShowRunC",
                          params= params, timeout=1)
        outputHTML = BeautifulSoup(r.text, 'html.parser')

        outputFile=open("bg2.html", "w")
        outputFile.write(r.text)

        error = outputHTML.find_all("span", class_="redError11L")

        if len(error) > 0:
            print error(1).text
        else:
            parentNodes = outputHTML.select('#ResTab > tbody')
            childrenNodes = parentNodes[0].children
            childrenNodes = list(childrenNodes)[1::2]

            #print childrenNodes

            trainInfo = {}

            for t in childrenNodes:
                try:
                    if len(t.select('td')) < 2:
                        continue
                    else:
                        key = ''.join(t.select('td')[0].text.split())
                        value = ' '.join(t.select('td')[1].text.split())
                        trainInfo[key]=value
                except Exception as e:
                    pass

            #print trainInfo
            #print key
            #print value

            LastLocation = trainInfo["LastLocation"]
            #print "location:", LastLocation

            #Departure = trainInfo["ScheduledDeparture"]
            #print "departure:", Departure

            colonPoint = LastLocation.split(":")
            #print colonPoint

            if len(colonPoint) == 1:
                print "No time specified"
            else:
                TIME = ":" + colonPoint[1][0:2]
                prevText_Splitted = colonPoint[0].split()
               # print prevText_Splitted
                Time = prevText_Splitted[-2] + " " + prevText_Splitted[-1] + TIME
                print Time

                stationName, stationCode = re.findall('([A-Z][A-Z\s]+)\(([A-Z]+)\)', colonPoint[0])[0]
                print stationName
                print stationCode

                delay = outputHTML.find_all("span", class_="greenS11L")[0]
                print delay.text
                delay_time = delay.text

                return(stationCode,Time,pkm_id,delay_time,stationName)
            return(None, None)



print "THE OBJECT ORIENTED"
main()
