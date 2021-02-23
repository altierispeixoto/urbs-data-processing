import os
import sys
from argparse import ArgumentParser
from datetime import datetime, timedelta
import subprocess

sys.path.insert(0, os.path.abspath('..'))
from dataprocessing.processors.neo4j_ingestion import Neo4JDataProcess

parser = ArgumentParser()
parser.add_argument("-ds", "--start_date", dest="start_date", help="start_date", metavar="DATE_START")
parser.add_argument("-de", "--end_date", dest="end_date", help="end_date", metavar="DATE_END")

args = parser.parse_args()

start_date = datetime.strptime(args.start_date, '%Y-%m-%d')
end_date = datetime.strptime(args.end_date, '%Y-%m-%d')

delta = end_date - start_date
print(delta)

files = ['color', 'service_category','lines','trips','bus_stop_type','bus_stops','line_routes','trip_endpoints','bus_event_edges', 'events']
root_path = '/data'

print(f"START TO PROCESSING NOE4J PROCESSING")
for i in range(delta.days + 1):
    datareferencia = start_date + timedelta(days=i)

    year = datareferencia.year
    month = datareferencia.month
    day = datareferencia.day

    Neo4JDataProcess(year, month, day)()

    datareferencia = datareferencia.strftime('%Y-%m-%d')
    print(f"{datareferencia} processed")

    for file in files:
        cmd = f"mkdir -p /database/neo4j/import/{file}/{datareferencia} "
        os.system(cmd)

        cmd = f"cp /data/neo4j/{file}/*.csv /database/neo4j/import/{file}/{datareferencia}/{file}.csv "
        os.system(cmd)


    print("=" * 30)