## General questions
### 1. Explain the different parts required when building a data pipeline. Give examples of tools for each stage (if relevant to your experience describe GCP tools or other Cloud platform)

Building a data pipeline involves several stages, each with its own set of components and tools to process and move data from source to destination. Data pipelines are essential for ETL/ELT (Extract, Transform, Load) processes, data integration, and data analytics. Here are the different parts of a data pipeline and examples of tools for each stage:

##### Data Extraction:

This is the initial stage where data is collected from different sources (databases, files, Apis, external applications).
* Tools:
  * GCP: Google Cloud Storage for data, Cloud Storage Transfer Service
  * Other Cloud: AWS Transfer Family (files), Aws Kinesis (streaming)

##### Data Transformation and Processing:

Data extracted is often raw and needs to be cleaned, enriched, or transformed to match the target schema. Sometimes needs more complex processing, such as aggregation, filtering, or joining.

* Tools:
    * GCP: Cloud Dataprep, Dataflow, Dataprep
    * Other Cloud: AWS Lambda, AWS Glue, Databricks

##### Data Storage:

Processed data needs to be stored in data lakes or data warehouse and database for analysis.
* Tools:
  * GCP: BigQuery, Cloud Bigtable, Cloud Spanner, Cloud SQL
  * Other Cloud: Amazon Redshift, Azure SQL Data Warehouse

##### Data Orchestration:

Orchestrating the entire pipeline, scheduling jobs, and handling error handling and retries.
* Tools:
  * GCP: Cloud Composer, Cloud Scheduler
  * Other Cloud: AWS Step Functions, Azure Logic Apps
  * Open Source: Apache Airflow

##### Data Monitoring and Logging:

Ensuring the pipeline's health and tracking issues.
* Tools:
  * GCP: Stackdriver Logging, Monitoring
  * Other Cloud: AWS CloudWatch, Azure Monitor
  * Open Source: ELK Stack (Elasticsearch, Logstash, Kibana)

##### Data Security and Compliance:

Implementing data security, encryption, and ensuring regulatory compliance.
 * Tools:
   * GCP: Google Cloud Key Management Service (KMS), Data Loss Prevention (DLP)
   * Other Cloud: AWS Key Management Service (KMS), Azure Key Vault

##### Data Delivery and Reporting:

Making data accessible for end-users through reports, dashboards, or APIs.
* Tools:
  * GCP: Data Studio, Looker
  * Other Cloud: Tableau, Power BI

##### Data Backup and Recovery:

Ensuring data is backed up and can be restored in case of failures.
* Tools:
  * GCP: Google Cloud Storage, Cloud SQL automated backups
  * Other Cloud: AWS Backup, Azure Backup

##### Data Versioning and Lineage:

Tracking data changes and understanding how data flows through the pipeline.
* Tools:
  * GCP: Cloud Data Catalog, BigQuery Lineage
  * Other Cloud: AWS Glue Data Catalog
 

### 2. Describe how would you define Monitoring on your processes


Data monitoring and logging are essential components of a data pipeline that ensure the pipeline's health, track issues, and provide insights into its performance. There are three key points related with this.

* Logging:

Logging involves recording events, activities, and errors throughout the data pipeline. It helps in troubleshooting and auditing.

* Monitoring:

Monitoring refers to the real-time or periodic observation of the data pipeline's key metrics and health indicators. It helps ensure that the pipeline is operating within expected parameters.

* Alerting:

Alerting is closely tied to monitoring and is essential for immediate response to critical issues.
Alerts can be configured to notify the operations team or stakeholders when specific conditions, such as high error rates or pipeline downtime, are detected.

### 3. How can you assure Data Quality of your model? In which stage in the pipeline would you address this issue?

Data quality is a critical step in building and maintaining a successful data model. Data quality assurance should be addressed at multiple stages of the data pipeline, but it is particularly important in the following stages:

##### 1. Data Extraction Stage:

Addressing data quality issues at the source is the first and most effective way to ensure data quality. This stage involves:
* Data Validation: Data schema validation, check for missing, inconsistent, or duplicate data in the source systems. 
* Data Cleansing: Cleanse data to remove or correct errors, such as typos, missing values, or outliers.

##### 2. Data Loading Stage:

Data loading, which can be part of ETL (Extract, Transform, Load) processes, should include:
* Data Validation: Confirm that the data being loaded matches the expected schema and business rules.
* Data Reconciliation: Verify that the data count in the destination matches the source to ensure no data loss or duplication.

##### 3. Data Processing Stage:

Within the processing stage, data quality can be addressed by:
* Monitoring: Continuously monitor data quality metrics such as accuracy, completeness, and timeliness during processing.
* Quality Control: Implement business logic and validation rules to flag or correct outliers or errors within the data.

##### 5. Data Delivery and Reporting Stage:

Ensuring that data quality is maintained as the model's output is delivered to end-users is essential. This includes:
* Quality Assurance in Output: Verify that the model's predictions or reports adhere to expected data quality standards.
* User Feedback: Collect user feedback to identify data quality issues that may not have been previously detected.

To assure data quality, the following practices and tools can be use:

* Data Profiling Tools: These tools automatically examine data to identify anomalies, missing values, and patterns that may indicate data quality issues.
* Data Quality Frameworks: Implement data quality frameworks that define quality standards, validation rules, and guidelines for data handling.
* Data Quality Metrics: Define key data quality metrics, such as completeness, accuracy, consistency, and timeliness, to measure and monitor data quality.

* Data Catalogs: Use data catalogs to document and track metadata and data lineage, helping to understand data quality and lineage.


### 4. You have to create a streaming process that reads the events that our players create and writes them into a Bigquery table, which technology would you choose and why?

Since the destination is BigQuery, choosing tools that integrates well with Coogle Cloud services is essential. So, considering the stages defined in the first question a valid or posile solution will be the next one:

##### Apache Kafka or Apache Pulsar (Data Ingestion): 

Both Kafka and Pulsar are popular open-source messaging systems that excel at handling high-throughput event streams. These platforms offer the following advantages:

* Scalability: Kafka and Pulsar are designed to handle large volumes of data, making them suitable for streaming player-generated events.
* Durability: They provide data durability by storing events on disk, ensuring that no data is lost.
* Real-time Processing: Kafka and Pulsar support real-time data ingestion, allowing for immediate processing of events as they arrive.
* Data Integration: Use connectors, such as Kafka Connectors or Pulsar IO connectors, to stream data from Kafka or Pulsar to Google Cloud services Dataflow.



##### Google Cloud Dataflow (Data Processing): 

Google Cloud Dataflow is a serverless stream and batch data processing service. Here's how it fits into the process:

* Real-time Processing: Dataflow can process streaming data in real-time, enabling you to apply transformations, aggregations, and enrichments to player-generated events.
* Scalability: Dataflow automatically scales to handle varying data volumes, which is vital for accommodating fluctuating player activity.
* Integration with BigQuery: You can easily write processed data to BigQuery, making it accessible for analysis and reporting.

### 5. How would you describe your ideal CI/CD pipeline?

An ideal CI/CD pipeline is a set of automated processes and best practices that facilitate the development, testing, and deployment of software. Here's a description of the ideal CI/CD pipeline:


1. Source Control Management (SCM):

The pipeline starts with a robust SCM system like Git, where all code is versioned, tracked, and organized into repositories.

2. Continuous Integration (CI):

An automated CI process is triggered upon each commit, which  can include the following:
* Building: Code is compiled, dependencies are resolved, and binaries are generated.
* Testing: A suite of automated tests, including unit tests, integration tests, and code quality checks, is executed.
* Static Code Analysis: Code is checked for style, security, standardization using tools like SonarQube or Fortify.
* Artifact Generation: If all checks pass, artifacts are created, ready for deployment.

3. Automated Deployment:

An automated deployment process takes place in a controlled and reproducible manner.

Deployments can be done in different environments, including development, staging, and production.

Infrastructure as Code (IaC) principles may be used to define and provision the necessary infrastructure for deployment.

4. Monitoring and Logging:

Continuous monitoring of application and infrastructure in production environments to detect issues.

Log aggregation and analysis to identify and troubleshoot problems.

5. Feedback Loop and Documentation:

Feedback from automated tests, code reviews, and monitoring informs improvements and drives quality.

Comprehensive documentation and knowledge sharing within the team



6. Rollback and recovery systems

The pipeline includes mechanisms for easy rollback in case of deployment failures.
Detailed recovery plans and procedures are in place to minimize downtime and user impact.

