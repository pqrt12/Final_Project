CREATE TABLE "Players" (
    "player_id" int   NOT NULL,
    "player_name" varchar   NOT NULL,
    CONSTRAINT "pk_Players" PRIMARY KEY (
        "player_id"
     )
);

CREATE TABLE "Maps" (
    "map" varchar   NOT NULL,
    CONSTRAINT "pk_Maps" PRIMARY KEY (
        "map"
     )
);

CREATE TABLE "Teams" (
    "team" varchar   NOT NULL,
    "player_id" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Events" (
    "event_id" int   NOT NULL,
    "event_name" varchar   NOT NULL,
    CONSTRAINT "pk_Events" PRIMARY KEY (
        "event_id"
     )
);

CREATE TABLE "Matches" (
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

CREATE TABLE "Player_results" (
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
    "rating" float   NOT NULL
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
    "match_winner" varchar   NOT NULL
);

ALTER TABLE "Teams" 
ADD CONSTRAINT "fk_Teams_player_id" 
FOREIGN KEY("player_id")
REFERENCES "Players" ("player_id");

ALTER TABLE "Matches" 
ADD CONSTRAINT "fk_Matches_event_id" 
FOREIGN KEY("event_id")
REFERENCES "Events" ("event_id");

ALTER TABLE "Player_results" 
ADD CONSTRAINT "fk_Player_results_match_id" 
FOREIGN KEY("match_id")
REFERENCES "Matches" ("match_id");

ALTER TABLE "Player_results" 
ADD CONSTRAINT "fk_Player_results_player_id" 
FOREIGN KEY("player_id")
REFERENCES "Players" ("player_id");

ALTER TABLE "Player_results" 
ADD CONSTRAINT "fk_Player_results_map" 
FOREIGN KEY("map")
REFERENCES "Maps" ("map");

ALTER TABLE "Team_results" 
ADD CONSTRAINT "fk_Team_results_match_id" 
FOREIGN KEY("match_id")
REFERENCES "Matches" ("match_id");

ALTER TABLE "Team_results" 
ADD CONSTRAINT "fk_Team_results_map" 
FOREIGN KEY("map")
REFERENCES "Maps" ("map");