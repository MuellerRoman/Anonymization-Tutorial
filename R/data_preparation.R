# ------------------------------------------------------------------------------
# Data Preparation 
# ------------------------------------------------------------------------------

# load dataset ----
data <- read.csv("data/SelfRelating_Depression_UK.csv",
                 header = TRUE,
                 stringsAsFactors = TRUE)

# select columns of interest ----

# depression items
depression_items <- paste0("PHQ_", 1:9, "z")

# derailment items
derailment_items <- c("Der_1r",
                      "Der_2r",
                      "Der_3",
                      "Der_4",
                      "Der_5r",
                      "Der_6",
                      "Der_7",
                      "Der_8",
                      "Der_9",
                      "Der_10r")

# self criticism items
self_cri_items <- c("FSCRS_1z",
                    "FSCRS_2z",
                    "FSCRS_4z",
                    "FSCRS_6z",
                    "FSCRS_7z",
                    "FSCRS_9z",
                    "FSCRS_10z",
                    "FSCRS_12z",
                    "FSCRS_14z",
                    "FSCRS_15z",
                    "FSCRS_17z",
                    "FSCRS_18z",
                    "FSCRS_20z",
                    "FSCRS_22z")

# self reassurance items
self_re_items <- c("FSCRS_3z",
                   "FSCRS_5z",
                   "FSCRS_8z",
                   "FSCRS_11z",
                   "FSCRS_13z",
                   "FSCRS_16z",
                   "FSCRS_19z",
                   "FSCRS_21z")

# vector with all sensitive variables
sens_vars <- c(depression_items,
               derailment_items,
               self_cri_items,
               self_re_items)

# dataset without score values
data <- data[, c("Age", "Sex", "Occupation", "Ethnicity", sens_vars)]

# score variables
score_vars <- c("Derailment", "Self_Criticism", 
                "Self_Reassurance", "Depression")

# Scaling function ----
create_scores <- function(df) {
    df$Depression <- rowSums(df[, depression_items], na.rm = TRUE)
    df$Derailment <- rowMeans(df[, derailment_items], na.rm = TRUE)
    df$Self_Criticism <- rowSums(df[, self_cri_items], na.rm = TRUE)
    df$Self_Reassurance <- rowSums(df[, self_re_items], na.rm = TRUE)
    
    return(df)
}

