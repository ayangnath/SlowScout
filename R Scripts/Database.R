Sys.setenv(TZ='CST6CDT')

connection_url <- paste0("mongodb+srv://jeremydumalig:", 
                         "zN9euGL6nhU8rsV0", 
                         "@cluster0.ztfyaeg.mongodb.net/",
                         "STACKS")

# Load MongoDB data with error handling
# If connection fails, create empty data frames to prevent app crash
tryCatch({
  master_shots <- mongo(db="STACKS",
                        collection="shots",
                        url=connection_url)$find()
  if (nrow(master_shots) == 0) {
    master_shots <- data.frame()
  }
}, error = function(e) {
  warning("Failed to load master_shots from MongoDB: ", e$message)
  master_shots <<- data.frame()
})

tryCatch({
  master_events <- mongo(db="STACKS",
                         collection="events",
                         url=connection_url)$find()
  if (nrow(master_events) == 0) {
    master_events <- data.frame()
  }
}, error = function(e) {
  warning("Failed to load master_events from MongoDB: ", e$message)
  master_events <<- data.frame()
})

tryCatch({
  master_turnovers <- mongo(db="STACKS",
                            collection="turnovers",
                            url=connection_url)$find()
  if (nrow(master_turnovers) == 0) {
    master_turnovers <- data.frame()
  }
}, error = function(e) {
  warning("Failed to load master_turnovers from MongoDB: ", e$message)
  master_turnovers <<- data.frame()
})

get_all_shots <- function(y=2024) {
  if (nrow(master_shots) == 0) {
    return(data.frame())
  }
  if (y == 2024) {
    master_shots %>% 
      filter(as.Date(Date, format="%Y-%m-%d") < threshold) %>%
      return()
  } else {
    master_shots %>% 
      filter(as.Date(Date, format="%Y-%m-%d") >= threshold) %>%
      return()
  }
}
get_shots <- function(league, team, y=2024) {
  if (nrow(master_shots) == 0) {
    return(data.frame())
  }
  if (y == 2024) {
    master_shots %>% 
      filter(League == league,
             Team == team,
             as.Date(Date, format="%Y-%m-%d") < threshold) %>%
      return()
  } else {
    master_shots %>% 
      filter(League == league,
             Team == team,
             as.Date(Date, format="%Y-%m-%d") >= threshold) %>%
      return()
  }
}
add_shot <- function(df) {
  db <- mongo(db="STACKS",
              collection="shots",
              url=connection_url)
  
  db$insert(df)
}
remove_shot <- function(id) { 
  db <- mongo(db="STACKS",
              collection="shots",
              url=connection_url)
  
  db$remove( paste0('{\"Shot ID" : ', as.character(id), '}') )
}

get_all_turnovers <- function(y=2024) {
  if (nrow(master_turnovers) == 0) {
    return(data.frame())
  }
  if (y == 2024) {
    master_turnovers %>% 
      filter(as.Date(Date, format="%Y-%m-%d") < threshold) %>%
      return()
  } else {
    master_turnovers %>% 
      filter(as.Date(Date, format="%Y-%m-%d") >= threshold) %>%
      return()
  }
}
get_turnovers <- function(league, team, y=2024) {
  if (nrow(master_turnovers) == 0) {
    return(data.frame())
  }
  if (y == 2024) {
    master_turnovers %>% 
      filter(League == league,
             Team == team,
             as.Date(Date, format="%Y-%m-%d") < threshold) %>%
      return()
  } else {
    master_turnovers %>% 
      filter(League == league,
             Team == team,
             as.Date(Date, format="%Y-%m-%d") >= threshold) %>%
      return()
  }
}
add_turnover <- function(df) {
  db <- mongo(db="STACKS",
              collection="turnovers",
              url=connection_url)
  
  db$insert(df)
}
remove_turnover <- function(id) { 
  db <- mongo(db="STACKS",
              collection="turnovers",
              url=connection_url)
  
  db$remove( paste0('{\"Event ID" : ', as.character(id), '}') )
}

get_all_events <- function(y=2024) {
  if (nrow(master_events) == 0) {
    return(data.frame())
  }
  if (y == 2024) {
    master_events %>% 
      filter(as.Date(Date, format="%Y-%m-%d") < threshold) %>%
      return()
  } else {
    master_events %>% 
      filter(as.Date(Date, format="%Y-%m-%d") >= threshold) %>%
      return()
  }
}
get_events <- function(league, team, y=2024) {
  if (nrow(master_events) == 0) {
    return(data.frame())
  }
  if (y == 2024) {
    master_events %>% 
      filter(League == league,
             Team == team,
             as.Date(Date, format="%Y-%m-%d") < threshold) %>%
      return()
  } else {
    master_events %>% 
      filter(League == league,
             Team == team,
             as.Date(Date, format="%Y-%m-%d") >= threshold) %>%
      return()
  }
}
add_oreb <- function(df) {
  db <- mongo(db="STACKS",
              collection="events",
              url=connection_url)
  
  db$insert(df)
}
add_dreb <- function(df) {
  db <- mongo(db="STACKS",
              collection="events",
              url=connection_url)
  
  db$insert(df)
}
add_ast <- function(df) {
  db <- mongo(db="STACKS",
              collection="events",
              url=connection_url)
  
  db$insert(df)
}
add_to <- function(df) {
  db <- mongo(db="STACKS",
              collection="events",
              url=connection_url)
  
  db$insert(df)
}
remove_event <- function(id) {
  db <- mongo(db="STACKS",
              collection="events",
              url=connection_url)
  
  db$remove( paste0('{\"Event ID" : ', as.character(id), '}') )
  
  remove_turnover(id)
}

new_row_id <- function(shot=F, event=F) {
  if (shot) {
    tryCatch({
      df <- mongo(db="STACKS",
                  collection="shots",
                  url=connection_url)$find()
      
      if (nrow(df) == 0 || !("Shot ID" %in% names(df))) {
        return(1)
      }
      return( max(max(df$`Shot ID`, na.rm=TRUE) + 1, nrow(df) + 1, na.rm=TRUE) )
    }, error = function(e) {
      return(1)
    })
  } else {
    tryCatch({
      df <- mongo(db="STACKS",
                  collection="events",
                  url=connection_url)$find()
      
      if (nrow(df) == 0 || !("Event ID" %in% names(df))) {
        return(1)
      }
      return( max(max(df$`Event ID`, na.rm=TRUE) + 1, nrow(df) + 1, na.rm=TRUE) )
    }, error = function(e) {
      return(1)
    })
  }
}

get_dates <- function(league, team, y=2024) {
  mongo(db="STACKS",
        collection="shots",
        url=connection_url)$distinct("Date", 
                                     paste0('{"League" : "', 
                                            league, '", "Team" : "', 
                                            team, '"}')) %>%
    date_filter_helper(y=y)
}

db_backup <- function() {
  get_all_shots() %>%
    write.csv(paste0("shots", Sys.Date(), ".csv"), 
              row.names=TRUE)
  
  get_all_events() %>%
    write.csv(paste0("events", Sys.Date(), ".csv"), 
              row.names=TRUE)
  
  get_all_turnovers() %>%
    write.csv(paste0("turnovers", Sys.Date(), ".csv"), 
              row.names=TRUE)
}

get_points <- function(df) {
  if (nrow(df) == 0 || !("Outcome" %in% names(df))) {
    return(data.frame(PTS = 0))
  }
  result <- df %>%
    filter((Outcome == "Make") | (str_detect(Outcome, "Foul"))) %>%
    mutate(Points = case_when((Outcome == "Foul (+3)") ~ 3,
                              (Outcome == "Foul (+2)") ~ 2,
                              (Outcome == "Foul (+1)") ~ 1,
                              (Outcome == "Foul (+0)") ~ 0,
                              (Region %in% regions3) ~ 3,
                              TRUE ~ 2)) %>%
    summarize(PTS = sum(Points, na.rm=TRUE))
  if (nrow(result) == 0 || is.na(result$PTS)) {
    return(data.frame(PTS = 0))
  }
  return(result)
}
