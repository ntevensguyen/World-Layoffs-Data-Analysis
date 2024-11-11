###########################################################################################################

-- 								          Data Cleaning
    
###########################################################################################################
SELECT * FROM world_layoffs.layoffs_staging;
/*
Data cleaning steps:
- remove duplicates
- standardize data
- null and blank values
- remove columns/rows that aren't neccessary
*/


# create table layoffs_staging
# like layoffs
# ;

# insert layoffs_staging
# select *
# from layoffs
# ;


select * 
from(
SELECT * , row_number() over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, country, funds_raised_millions) as row_num
FROM layoffs_staging
)row_table
where row_num>1
;

#another way to write the subquery above
with duplicate_cte as
(
SELECT * , row_number() over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
select *
from duplicate_cte
where row_num>1
;

select *
from layoffs_staging
where company = 'Casper'
;


#you cant DELETE/update a cte
with duplicate_cte as
(
SELECT * , row_number() over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
delete 
from duplicate_cte
where row_num>1;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, 
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_staging2;

insert into layoffs_staging2
SELECT * , row_number() over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, country, funds_raised_millions) as row_num
FROM layoffs_staging;

select *
from layoffs_staging2
where row_num>1
;

delete
from layoffs_staging2
where row_num>1
;

select * from layoffs_staging2;


################STANDARDIZING DATA

select company, trim(company)
from layoffs_staging2
;

update layoffs_staging2
set company = trim(company)
;

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry='Crypto'
where industry like 'crypto%';


select country
from layoffs_staging2
where country like 'united states%'
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country);

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select *
from layoffs_staging2;

#change 'date' data type from text to date 
alter table layoffs_staging2
modify column `date` date;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;


select *
from layoffs_staging2
where industry is null or industry='';

select *
from layoffs_staging2
where company='airbnb';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

update layoffs_staging2
set industry=null
where industry='';

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
set t1.industry=t2.industry
where (t1.industry is null)
and t2.industry is not null;


select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from 
layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;