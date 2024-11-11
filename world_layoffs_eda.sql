###########################################################################################################

-- 								        Exploratory Data Analysis
    
###########################################################################################################

-- View all data from layoffs_staging2
select * 
from layoffs_staging2;

-- ##################################
-- General Trends
-- ##################################

-- Q1: What are the total layoffs per year, and how do they trend over time?
select year(`date`) as `year`, sum(total_laid_off) as total_laid_off
from layoffs_staging2
group by `year`
order by total_laid_off desc;

-- Q2: How do layoffs vary by country or industry?
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc
;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc
;

-- Q3: What is the average percentage of employees laid off by industry?
select industry, round(avg(percentage_laid_off)*100, 2) as avg_percent
from layoffs_staging2
group by industry
order by avg_percent desc
;

-- ##################################
-- Industry-Specific Analysis
-- ##################################

-- Q4: Which industries have the highest average layoffs?
select industry, round(avg(total_laid_off),2)
from layoffs_staging2
group by industry
order by 2 desc
limit 10
;

-- ##################################
-- Company Analysis
-- ##################################

-- Q5: Which companies have the highest total layoffs, and how do these numbers change over time?
select company, sum(total_laid_off)
from layoffs_staging2
group by company
having max(total_laid_off) > 7000
order by total_laid_off desc;

-- Q6: What is the average percentage of layoffs by company size (e.g., based on funds raised or location)?
select company, funds_raised_millions, round(avg(percentage_laid_off),3) avg_percent
from layoffs_staging2
group by company, funds_raised_millions
having avg_percent is not null
order by funds_raised_millions desc
;

with ranked_layoffs as (
    select 
        company, 
        year(`date`) as `year`, 
        sum(total_laid_off) as total_laid_off_year, 
        dense_rank() over(partition by year(`date`) order by sum(total_laid_off) desc) as ranking
    from layoffs_staging2
    group by company, `year`
    having sum(total_laid_off) is not null and `year` is not null
)
select 
    company, 
    `year`, 
    total_laid_off_year, 
    ranking
from ranked_layoffs
where ranking <= 5;

-- ##################################
-- Geographic Insights
-- ##################################

-- Q7: Which locations or countries have seen the most layoffs?
select country, location, sum(total_laid_off)
from layoffs_staging2
group by 1,2
having sum(total_laid_off) is not null
order by 3 desc
;

-- Q8: Are there any trends between layoff percentages and location?
select location, avg(percentage_laid_off) as avg_percentage_laid_off,
sum(total_laid_off) as total_laid_off, count(distinct company) as number_of_companies
from layoffs_staging2
group by location
having total_laid_off is not null and avg_percentage_laid_off is not null
order by avg_percentage_laid_off desc;

-- ##################################
-- Time Series Analysis
-- ##################################

-- Q9: Are layoffs seasonal, or do they increase in certain months?
select monthname(`date`) as month, sum(total_laid_off)
from layoffs_staging2
group by month with rollup
having sum(total_laid_off) is not null
order by field(month,'January', 'February', 'March', 'April', 'May',
'June', 'July', 'August', 'September', 'October', 'November', 'December')
;

-- Q10: How have layoffs been distributed month-by-month over a specific year?
select substring(`date`, 1, 4) as `year`, substring(`date`, 6, 2) as `month`, sum(total_laid_off) 
from layoffs_staging2
where substring(`date`, 1, 4) and substring(`date`, 6, 2) is not null
group by `year`, `month` with rollup
order by `year`, `month`;

