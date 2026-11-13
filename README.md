# OVERVIEW:
This project follows the creation of an R package that contains two functions: one that retrieves the career match data for tennis players from the website tennisabstract.com, and another that makes the plots. 
The overall file structure of the project is as follows: 
HW03-3-ESTEBANLOPEZ-UCB/
├── man/
│   ├── fetch_career_data.Rd
│   └── plot_career_scatter.Rd
├── R/
│   ├── fetch_career_data.R
│   ├── plot_career_scatter.R
│   └── utils.R
├── tests/
│   ├── testthat.R
│   └── testthat/
│       ├── fixtures/
│       │   ├── FemalePlayerCareer.JS
│       │   └── MalePlayerCareer.JS
│       └── test-career_pipeline.R
├── DESCRIPTION
├── instructions.md
├── NAMESPACE
└── README.md
# Tennisrpkg: 
The package is called 'tennisrpkg', and it's designed to fetch, clean, and visualize match histories from tennisabstract.com. It can be installed using the devtools command. The package contains two main functions, fetch_career_data() and plot_career_scatter(), the former to retrieve the career data and the latter to generate the plot. 
# Reflection: 
When making the 'tennisrpkg' package, I realized how challenging it is to perform a data analysis workflow to produce a working R package. I spent a considerable amount of time looking into helper functions in order to make the most efficient package. The main challenge that I encountered was handling the differences between ATP and WTA data formats, so the cleaning helper made everything flow smoothly into uniform dataframes. The two .JS files under the 'fixtures' folder, 'FemalePlayerCareer.JS' and 'MalePlayerCareer.JS', made it so that the package itself is test-ready, independent of live websites. 
Overall, this project helped me realize the maintaining a package structure that is clean and efficient makes it so that the code itself is easier to share. 