CREATE TABLE "players" (
    "player_id" int   NOT NULL,
    "player_name" varchar   NOT NULL,
    CONSTRAINT "pk_Players" PRIMARY KEY (
        "player_id"
     )
);

CREATE TABLE "maps" (
    "map" varchar   NOT NULL,
    CONSTRAINT "pk_Maps" PRIMARY KEY (
        "map"
     )
);

CREATE TABLE "teams" (
    "team" varchar   NOT NULL,
    "player_id" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
	CONSTRAINT "pk_Teams" PRIMARY KEY (
        "team", "from_date"
     )
);

CREATE TABLE "events" (
    "event_id" int   NOT NULL,
    "event_name" varchar   NOT NULL,
    CONSTRAINT "pk_Events" PRIMARY KEY (
        "event_id"
     )
);

CREATE TABLE "matches" (
    "match_id" int  NOT NULL,
    "event_id" int   NOT NULL,
    "team_1" varchar   NOT NULL,
    "team_2" varchar   NOT NULL,
    "best_of" int   NOT NULL,
    "map_1" varchar   NOT NULL,
    "map_2" varchar   NOT NULL,
    "map_3" varchar   NOT NULL,
	"map_4" varchar   NOT NULL,
	"map_5" varchar   NOT NULL,
    "date" date   NOT NULL,
    CONSTRAINT "pk_Matches" PRIMARY KEY (
        "match_id"
     )
);

CREATE TABLE "player_results" (
    "match_id" int  NOT NULL,
    "player_id" int   NOT NULL,
    "map" varchar   NOT NULL,
    "kills" int   NOT NULL,
    "assists" int   NOT NULL,
    "deaths" int   NOT NULL,
    "hs" int   NOT NULL,
    "flash_assists" int   NOT NULL,
    "kast" float   NOT NULL,
    "kddiff" int   NOT NULL,
    "adr" float   NOT NULL,
    "fkdiff" int   NOT NULL,
    "rating" float   NOT NULL,
    CONSTRAINT "pk_presults" PRIMARY KEY (
        "match_id", "player_id", "map" 
     )
);

CREATE TABLE "Team_results" (
    "match_id" int  NOT NULL,
    "team" varchar   NOT NULL,
    "map" varchar   NOT NULL,
    "rank" int   NOT NULL,
    "equipment_avg" int   NOT NULL,
    "starting_ct" varchar   NOT NULL,
    "rounds_total" int   NOT NULL,
    "rounds_won" int   NOT NULL,
    "rounds_won_ct" int   NOT NULL,
    "rounds_won_t" int   NOT NULL,
    "map_winner" varchar   NOT NULL,
    "match_winner" varchar   NOT NULL,
    CONSTRAINT "pk_tresults" PRIMARY KEY (
        "match_id", "team", "map" 
     )
);

ALTER TABLE "matches" 
ADD CONSTRAINT "fk_matches_event_id" 
FOREIGN KEY("event_id")
REFERENCES "events" ("event_id");

ALTER TABLE "teams" 
ADD CONSTRAINT "fk_teams_player_id" 
FOREIGN KEY("player_id")
REFERENCES "Players" ("player_id");

ALTER TABLE "player_results" 
ADD CONSTRAINT "fk_player_results_match_id" 
FOREIGN KEY("match_id")
REFERENCES "matches" ("match_id");

ALTER TABLE "player_results" 
ADD CONSTRAINT "fk_player_results_player_id" 
FOREIGN KEY("player_id")
REFERENCES "players" ("player_id");

ALTER TABLE "player_results" 
ADD CONSTRAINT "fk_player_results_map" 
FOREIGN KEY("map")
REFERENCES "maps" ("map");

ALTER TABLE "team_results" 
ADD CONSTRAINT "fk_team_results_match_id" 
FOREIGN KEY("match_id")
REFERENCES "matches" ("match_id");

ALTER TABLE "team_results" 
ADD CONSTRAINT "fk_team_results_map" 
FOREIGN KEY("map")
REFERENCES "maps" ("map");