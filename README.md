# YouTube Monetization Data Analysis

This project provides an in-depth analysis of YouTube monetization data, focusing on channels from Mexico, USA, and Colombia. The analysis covers various aspects of monetization, taxes, and channel performance, offering valuable insights for optimizing YouTube channel strategies.

## Project Description

The "YouTube Monetization Data Analysis" project aims to answer the following business questions:

1. **Crear un campo calculado que muestre el valor de la monetización del video y otra con los impuestos que estos generan.**
   - *Create a calculated field to show the monetization value of the video and another field for the taxes generated.*

2. **Monetización total por canales y los impuestos pagados por cada uno de ellos.**
   - *Total monetization per channel and the taxes paid by each.*

3. **Considerando que tomaremos como meta de monetización para los canales de México el promedio de la monetización de ese país, cuál es la brecha que los canales de México tienen para alcanzar la meta.**
   - *Considering the average monetization of channels in Mexico as the target, what is the gap for Mexican channels to reach this target?*

4. **Cuántas visitas requieren los videos de los canales de USA para alcanzar una monetización de un millón de dólares.**
   - *How many views do videos from USA channels need to reach a monetization of one million dollars?*

5. **Cuáles son los canales de Colombia que han sido más exonerados de impuestos.**
   - *Which channels in Colombia have been most exempted from taxes?*

6. **En qué país de los indicados se tiene una mayor monetización.**
   - *Which of the indicated countries has the highest monetization?*

7. **Según la opinión del grupo, qué es más conveniente para Colombia, abrir un canal de salud y bienestar o un canal de jardinería (clasificación 24).**
   - *According to the group's opinion, what is more convenient for Colombia: opening a health and wellness channel or a gardening channel (classification 24)?*

8. **En México, qué es más conveniente, un canal de jardinería (clasificación 24) o un canal de videojuegos (clasificación 23).**
   - *In Mexico, what is more convenient: a gardening channel (classification 24) or a video game channel (classification 23)?*

9. **Si el CPM de USA se redujera en un 25%, ¿los ingresos en México serían mayores a los de USA?**
   - *If the CPM in the USA were reduced by 25%, would the revenues in Mexico be higher than those in the USA?*

## Important Considerations

YouTube monetizes video views based on several criteria that content creators must meet. For this analysis, the following considerations are applied:

- **Monetization Eligibility**: Only videos with comments enabled and without classifications 29, 19, and 27 are considered for monetization. These classifications represent video types not paid by YouTube.
- **Cost per Mille (CPM)**: Monetization is based on the number of views, with payment made per 1000 views (CPM). The CPM varies by country.
- **Taxation**: Some countries impose taxes on income generated through digital platforms. In this analysis:
  - Colombia imposes a 10% tax on video income, except for videos classified under 26 (health and wellness), which are exempt.
  - If a country is not listed in the CPM data, the default CPM of the United Kingdom is used.

## Project Structure

The project includes the following components:

- **Database Backup**: Backup of the tables used in the analysis.
- **SQL Queries**: The SQL scripts used to answer the business questions.

## Table of Contents

1. [Database Backup](#database-backup)
2. [SQL Queries](#sql-queries)
3. [Important Considerations](#important-considerations)
4. [Contact](#contact)

## Database Backup

The backup of the tables used in this project is provided in the `database_backup` directory. Ensure to restore these tables in your SQL environment to run the analysis queries.

## SQL Queries

The SQL queries used to answer the business questions are included in the `sql_queries` directory. Each file corresponds to a specific question outlined in the project description.

## Contact

For any questions or further information, please contact:

- [LinkedIn](https://www.linkedin.com/in/yourprofile)
- [Email](mailto:your.email@example.com)

Feel free to connect and discuss the project or any other data analysis inquiries.

---

Thank you for exploring the YouTube Monetization Data Analysis project. We hope you find the insights valuable and the analysis helpful.
