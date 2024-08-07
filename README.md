# YouTube Monetization

![banner](banner.jpg)

## Description

This project demonstrates how to use SQL to answer various questions related to YouTube video monetization, following specific conditions and instructions. The dataset includes information about video views, countries, CMP (Cost per Mille), and video classifications. The context of the problem is as follows:

YouTube monetizes the views of videos that content creators have on their platform based on several criteria. For this exercise, we consider that a video can only be monetized if comments are enabled and the video does not have classifications 29, 19, or 27, which represent categories not paid by YouTube. Monetization is based on paying the channel per 1000 views a video receives, known as CMP, which varies by country. Some countries are starting to tax income generated through digital platforms. For this exercise, we consider that Colombia imposes a 10% tax on video income unless the video belongs to classification 26 (health and care), which is exempt. If a country is not listed in the CMP table, the default CMP of the United Kingdom is used.

## Objectives

The objective of this project is to answer specific questions related to YouTube video monetization using SQL. The questions provided are:

1. Create a calculated field that shows the monetization value of the video and another with the taxes generated.
2. Calculate the total monetization per channel and the taxes paid by each.
3. Considering that the monetization goal for channels in Mexico is the average monetization of that country, determine the gap that channels in Mexico need to reach the goal.
4. Determine the number of views required for videos from channels in the USA to reach a monetization of one million dollars.
5. Identify the channels in Colombia that have been most exempt from taxes.
6. Determine which country among the specified ones has the highest monetization.
7. Based on the group's opinion, decide what is more convenient for Colombia: opening a health and wellness channel or a gardening channel (classification 24).
8. Determine which is more convenient in Mexico: a gardening channel (classification 24) or a gaming channel (classification 23).
9. If the CMP of the USA were reduced by 25%, would the income in Mexico be higher than in the USA?

## Data Source

The dataset used in this project is from Kaggle.

## Project Structure

The repository contains the following files:

- `backup_AnalisisMonetizacionYoutube.zip`: This file contains the backup to create the database with the tables and populate them.
- `Consultas.sql`: This file contains the SQL queries used to answer the project questions.
- `output_table_example.png`: An example image of the output table for the first question.

## Instructions

To run this project:

1. Download the repository.
2. Open and run `backup_AnalisisMonetizacionYoutube.zip` to set up the database with all necessary information.
3. Open and run `Consultas.sql` to execute the queries that answer the specified questions.

There are no additional prerequisites or dependencies required.

## Contact

For questions or feedback, please contact me via:

- Email: [josuejr7.m@gmail.com](mailto:josuejr7.m@gmail.com)
- LinkedIn: [www.linkedin.com/in/josueromero-dataanalyst](https://www.linkedin.com/in/josueromero-dataanalyst)
