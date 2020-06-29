import pandas as pd
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func
from flask import Flask, jsonify, render_template
from flask_pymongo import PyMongo
from config import username, password, location, port, server

#engine = create_engine("postgres://postgres:%XhB70dIxJ*C@dataviz.cdhexjpu5mat.us-east-2.rds.amazonaws.com:5432/CSGO_project")
engine = create_engine(f"postgres://{username}:{password}@{location}:{port}/{server}")

Base = automap_base()
Base.prepare(engine, reflect=True)

maps = Base.classes.maps
teams = Base.classes.teams

session = Session(engine)

mapnamedatafull=[]

# Setting up Flask
app = Flask(__name__)

#Homepage
@app.route('/')
def home():
    return render_template("dashboard.html", mapnamedata=get_mapname())

# Data Table: Maps
# Method A: Selecting all data in data table and setting it into a list/dictionary 
def get_mapname():
    mapname = session.query(maps).all()
    mapnamedata = [{"map": m.map} for m in mapname]
    return mapnamedata  

#---------------------------------------------------------------------------------------#

#Homepage - dashboard.html link
@app.route('/dashboard.html')
def home2():
    return render_template("dashboard.html", mapnamedata=get_mapname())
get_mapname()

# Data Table: Teams
teamsnames = session.query(teams).all()
teamnamedata = [{"team": m.team} for m in teamsnames]
teamnamedata

#---------------------------------------------------------------------------------------#    

#TableResultspage
@app.route('/tablesResults.html')
def tabledataresults():    
    return render_template("tablesResults.html")

#---------------------------------------------------------------------------------------#  

#TableTeampage
@app.route('/tablesTeam.html')
def tabledata():    
    return render_template("tablesTeam.html")

@app.route('/get_tables')
def get_tables():
    team_resultstest = engine.execute("Select * from team_results")
    results1_team_results = [{"team": m.team, 
                            "map": m.map, 
                            "rounds_won": m.rounds_won,
                            "map_winner": m.map_winner,
                            "starting_ct": m.starting_ct,
                            "rounds_won_ct": m.rounds_won_ct,
                            "rounds_won_t": m.rounds_won_t,
                            "rank": m.rank,
                            "map_wins": m.map_wins,
                            "match_winner": m.match_winner,
                            } for m in team_resultstest]
    return jsonify(results1_team_results[:50])

#---------------------------------------------------------------------------------------#

#Summarypage
@app.route('/typography.html')
def summary():
    return render_template("typography.html")

#---------------------------------------------------------------------------------------#

#MapPage
@app.route("/map.html")
def map():
    return render_template("map.html")

#---------------------------------------------------------------------------------------#

#Iconpage
@app.route("/icons.html")
def icons():
    return render_template("icons.html")

#---------------------------------------------------------------------------------------#

@app.route("/upgrade.html")
def upgrade():
    return render_template("upgrade.html")

#---------------------------------------------------------------------------------------#

if __name__ == '__main__':
    app.run()    