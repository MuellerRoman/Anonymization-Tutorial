# Anonymizing Psychological Research Data: An R Tutorial

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.24287502.svg)](https://doi.org/10.5281/zenodo.24287502)

Online supplementary material to the article

> Müller, R., Templ, M., & Strobl, C. (2026). *Anonymization of Research Data for Open Science in Psychology*. Manuscript under review.

## 📖 [Read the tutorial online](https://muellerroman.github.io/Anonymization-Tutorial/)

The tutorial opens directly in your browser. You do not need to install R or anything else to read it.

---

## Overview

The tutorial walks through a complete anonymization workflow for a real psychological research dataset, using the R package [**sdcMicro**](https://cran.r-project.org/package=sdcMicro). It covers:

- **Disclosure risk assessment** with *k*-anonymity, SUDA, and *l*-diversity
- **Non-perturbative anonymization** with global recoding and local suppression
- **Perturbative anonymization** with rank swapping and PRAM
- **Re-identification risk after perturbation**, assessed by record linkage
- **Utility assessment**: distributions, associations, and the reproducibility of regression results

The tutorial is an introductory worked example, not a universal blueprint. A suitable anonymization strategy always depends on the dataset and on the disclosure scenario.

## Repository structure

```text
.
├── tutorial.qmd                  # Quarto source of the tutorial (text + R code)
├── R/
│   ├── data_preparation.R        # loads the dataset and defines variable groups
│   └── association_heatmap.R     # helper function for the association heatmaps
├── data/
│   ├── SelfRelating_Depression_UK.csv   # original dataset (Colman et al., 2020)
│   ├── README.md                 # data source, citation, and license
│   └── LICENSE                   # CC BY-SA 4.0 notice for the dataset
├── assets/
│   ├── references.bib            # bibliography
│   ├── apa.csl                   # APA citation style
│   └── DAG.png                   # figure used in the tutorial
├── renv.lock                     # exact R and package versions
├── renv/                         # renv infrastructure (packages are not tracked)
├── .Rprofile                     # activates renv when the project is opened
├── Anonymization_Tutorial.Rproj  # RStudio project file
├── .gitattributes                # keeps the dataset byte-identical (no line-ending conversion)
├── CITATION.cff                  # citation metadata ("Cite this repository")
├── LICENSE                       # MIT license for the code
└── README.md
```

## Reproducing the tutorial

**Requirements**

- [R](https://cran.r-project.org/) 4.4.3 (the version used to render the tutorial)
- [Quarto](https://quarto.org/docs/get-started/)
- [RStudio](https://posit.co/download/rstudio-desktop/) (recommended)

**Steps**

1. Clone or [download](https://github.com/MuellerRoman/Anonymization-Tutorial/archive/refs/heads/main.zip) this repository.
2. Open `Anonymization_Tutorial.Rproj` in RStudio. [renv](https://rstudio.github.io/renv/) installs itself automatically.
3. Install the package versions recorded in `renv.lock`:

   ```r
   renv::restore()
   ```

4. Open `tutorial.qmd` and click **Render**, or run the following in a terminal:

   ```bash
   quarto render tutorial.qmd
   ```

All random procedures use fixed seeds, so the rendered results should match the online version.

## Data

The tutorial uses a publicly available dataset from PsychArchives:

> Colman, R. D., Vione, K. C., & Kotera, Y. (2020). *Psychological risk factors for depression in UK student and general populations: Derailment, self-criticism and self-reassurance* [Data set]. PsychArchives. https://doi.org/10.23668/psycharchives.4189

The dataset is redistributed here unmodified under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) license. See [`data/README.md`](data/README.md) for details.

## Citation

If you use this tutorial, please cite the article:

> Müller, R., Templ, M., & Strobl, C. (2026). *Anonymization of Research Data for Open Science in Psychology*. Manuscript under review.

To refer to the tutorial and code itself, cite the archived version on Zenodo:

> Müller, R., Templ, M., & Strobl, C. (2026). *Anonymizing psychological research data: An R tutorial* [Computer software]. Zenodo. https://doi.org/10.5281/zenodo.24287502

## License

| Content | License |
|---|---|
| R code (`R/`, code in `tutorial.qmd`) | [MIT](LICENSE) |
| Tutorial text and figures | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) |
| Dataset (`data/`) | [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), © Colman, Vione & Kotera (see [`data/LICENSE`](data/LICENSE)) |

## Acknowledgement

This work was funded by the Swiss National Science Foundation (grant number 211751).
