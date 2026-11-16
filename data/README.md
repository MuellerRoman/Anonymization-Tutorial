# Data

## Source

`SelfRelating_Depression_UK.csv` is the original dataset published on PsychArchives:

> Colman, R. D., Vione, K. C., & Kotera, Y. (2020). *Psychological risk factors for depression in UK student and general populations: Derailment, self-criticism and self-reassurance* [Data set]. PsychArchives. https://doi.org/10.23668/psycharchives.4189

The data were collected for the following study:

> Colman, R. D., Vione, K. C., & Kotera, Y. (2024). Psychological risk factors for depression in the UK general population: Derailment, self-criticism and self-reassurance. *British Journal of Guidance & Counselling, 52*(4), 645–662. https://doi.org/10.1080/03069885.2022.2110214

## File

| File | Description |
|---|---|
| `SelfRelating_Depression_UK.csv` | 107 participants; sociodemographic variables (age, sex, occupation, ethnicity) and item responses for the derailment, self-criticism and self-reassurance, and depression scales, plus derived variables |

The file is redistributed **unmodified**. Its MD5 checksum is identical to the version on PsychArchives (`b944b541d52fe73344b371083aa1c249`).

## Processing

No changes are made to the file itself. When the tutorial runs, [`R/data_preparation.R`](../R/data_preparation.R) loads the file and keeps the four quasi-identifiers and the item-level variables. Standardized and derived variables (e.g., composite scale scores) are dropped and recomputed where needed.

## License

The dataset is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/) by its original authors. It is listed on PsychArchives with *Sharing Level 0 (Public Use)*. See [`LICENSE`](LICENSE).

Under the ShareAlike condition, adapted versions of this dataset (for example, anonymized datasets created with the code in this tutorial) must be distributed under CC BY-SA 4.0 or a compatible license if you share them.
