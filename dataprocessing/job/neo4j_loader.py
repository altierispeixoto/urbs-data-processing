from neo4j import GraphDatabase
from datetime import timedelta, datetime
import yaml
from argparse import ArgumentParser
import os
from dotenv import load_dotenv
load_dotenv()


config = yaml.load(open('/opt/urbs-data-processing/dataprocessing/job/cypher/database.yml'), Loader=yaml.FullLoader)

NEO4J_URI = os.getenv('NEO4J_URI')
NEO4J_USER = os.getenv('NEO4J_USER')
NEO4J_PASSWORD = os.getenv('NEO4J_PASSWORD')

parser = ArgumentParser()
parser.add_argument("-ds", "--start_date", dest="start_date", help="start_date", metavar="DATE_START")
parser.add_argument("-de", "--end_date", dest="end_date", help="end_date", metavar="DATE_END")

args = parser.parse_args()

start_date = datetime.strptime(args.start_date, '%Y-%m-%d')
end_date = datetime.strptime(args.end_date, '%Y-%m-%d')

delta = end_date - start_date
print(delta)

def load_into_neo4j(cypher_query):
    print(cypher_query)
    neo4j_connection = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASSWORD))
    with neo4j_connection.session() as session:
        result = session.run(cypher_query)
        print(f"Executed.", result.single())


print(f"START TO PROCESSING NOE4J PROCESSING")
for i in range(delta.days + 1):
    datareferencia = start_date + timedelta(days=i)

    datareferencia = datareferencia.strftime('%Y-%m-%d')

    for key, value in config.items():
        cypher_query = value.replace('{datareferencia}', datareferencia)
        load_into_neo4j(cypher_query)

    print(f"{datareferencia} processed")