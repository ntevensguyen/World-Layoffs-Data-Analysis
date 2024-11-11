# Layoffs Data Analysis

This repository contains an exploratory data analysis (EDA) of layoff trends using SQL. The dataset, `layoffs_staging2`, includes data on layoffs from various companies, with fields like `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, and `funds_raised_millions`.

## Project Overview

The SQL queries provide insights into general trends, industry-specific data, geographic patterns, company analysis, and time-series trends. This analysis helps identify patterns, pinpoint industries and locations most impacted by layoffs, and uncover seasonal trends.

## Analysis and Key Insights

### 1. General Trends
- **Total Layoffs Per Year**: Calculated total layoffs by year to understand overall trends.
- **Layoffs by Country and Industry**: Assessed layoffs by country and industry to identify which regions and sectors are most affected.
- **Average Layoff Percentage by Industry**: Determined average layoff percentages by industry, revealing which sectors had the highest workforce reduction rates.

### 2. Industry-Specific Analysis
- **Highest Average Layoffs by Industry**: Identified the top 10 industries with the highest average number of layoffs, providing insights into sectors facing the most significant challenges.

### 3. Company Analysis
- **Companies with Highest Total Layoffs**: Highlighted companies with large layoff events, and examined trends in layoffs over time.
- **Layoffs by Company Size**: Explored how layoffs vary by company size, using `funds_raised_millions` as a proxy for size.

### 4. Geographic Insights
- **Layoffs by Location**: Identified locations and countries with the highest total layoffs.
- **Layoff Percentages by Location**: Analyzed average layoff percentages by location to explore possible regional patterns.

### 5. Time Series Analysis
- **Monthly Layoff Trends**: Investigated whether layoffs increase during specific months.
- **Yearly and Monthly Distribution**: Examined month-by-month layoffs across years to uncover possible seasonal patterns.

## Usage

The SQL queries used in this analysis are included in the repository. To reproduce the analysis:
1. Load the `layoffs_staging2` table in your SQL environment.
2. Run the queries in sequence to explore each aspect of the analysis.

## Conclusion

This EDA reveals key patterns in layoff trends, including impacted industries, regions, and seasonal variations. By understanding these trends, stakeholders can gain insights into economic challenges and workforce dynamics across industries and locations.

## License

This project is licensed under the MIT License.
