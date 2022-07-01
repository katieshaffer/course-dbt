##Part 1: dbt Snapshots
* Snapshot created (orders_snapshot.sql)

## Part 2: Modeling challenge
* Fct_product_funnel_all_time.sql includes all time numbers for the product funnel as well as the drop off percentages between funnel levels
* Fct_product_funnel_monthly.sql will show the counts on an aggregated monthly basis, so we can track changes over time
* Added exposure for the two new funnel models above

## Part 3: Reflection questions -- please answer 3A or 3B, or both!
Reflecting on your learning in this class...if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
* While we use dbt, there is a lot of functionality that we could benefit from using much more regularly. Tests are a big component that would increase our data quality. Increased utilization of dbt docs would also help our stakeholders understand the data better.
* Currently, we don’t use exposures at all, so when a model changes, we have a difficult time determining the downstream impacts such as which reports in our BI tool use that model. I would recommend that we begin adding this.

