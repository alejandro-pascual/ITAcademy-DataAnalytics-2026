CREATE OR REPLACE EXTERNAL TABLE `sprint3-analytics-alejandro.sprint3_bronze.transactions_raw`
  OPTIONS (
    format ="CSV",
    uris = ['gs://bootcamp-data-analytics-public/ERP/transactions.csv'],
    field_delimiter = ';'
    );
CREATE OR REPLACE EXTERNAL TABLE `sprint3-analytics-alejandro.sprint3_bronze.companies_raw`
  (
    company_id STRING,
    company_name STRING,
    phone STRING,
    email STRING,
    country STRING,
    website STRING
  )
  OPTIONS (
    format ="CSV",
    uris = ['gs://bootcamp-data-analytics-public/ERP/companies.csv'],
    skip_leading_rows = 1
    );
CREATE OR REPLACE EXTERNAL TABLE `sprint3-analytics-alejandro.sprint3_bronze.american_users_raw`
  OPTIONS (
    format ="CSV",
    uris = ['gs://bootcamp-data-analytics-public/CRM/american_users.csv']
    );
CREATE OR REPLACE EXTERNAL TABLE `sprint3-analytics-alejandro.sprint3_bronze.european_users_raw`
  OPTIONS (
    format ="CSV",
    uris = ['gs://bootcamp-data-analytics-public/CRM/european_users.csv']
    );
CREATE OR REPLACE EXTERNAL TABLE `sprint3-analytics-alejandro.sprint3_bronze.credit_cards_raw`
  OPTIONS (
    format ="CSV",
    uris = ['gs://bootcamp-data-analytics-public/CRM/credit_cards.csv']
    );

