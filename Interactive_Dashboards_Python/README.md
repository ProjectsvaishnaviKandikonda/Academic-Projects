*Global Cyber Incident Data Visualization*
-----------------------------------------------------------------------------

This project analyzes the EurepoC Global Cyber Incident dataset to provide insights into the evolving cyber threat landscape.

The analysis focuses on identifying trends such as:

- The top 10 most targeted countries and the top 10 countries from which attacks originate.

- The most common incident types.

- The most targeted sectors (receiver categories).

- The primary threat actor types (initiator categories).

- The impact scores of different incident types.

*Conclusion*

The analysis concludes that Data Theft is a globally widespread threat, while Ransomware is more region-specific. There has been a steady rise in cyber incidents over time, with notable spikes in 2015 and 2020. The box plot analysis of impact scores highlights that Disruption incidents show the greatest variability. The findings emphasize the need for region-specific mitigation strategies and the importance of prioritizing responses based on impact.

*Technologies Used*

The main technologies used are Python and the following libraries:

- pandas for data manipulation and analysis.

- plotly and matplotlib for creating interactive and static visualizations.

- seaborn for statistical data visualization.

-----------------------------------------------------------------------------
*Threat Intelligence Dashboard*
-----------------------------------------------------------------------------

This project, which includes eda_threat_intel.ipynb and optimized_dashboard.py, is a cyber threat intelligence dashboard. It processes data from NVD CVE and MITRE ATT&CK datasets, cleans it, and presents it in an interactive Streamlit application. The dashboard visualizes key threat intelligence metrics, including CVEs, CVSS scores, and mapped MITRE techniques.

The analysis and dashboard focus on:

- CVEs, their CVSS scores, and severity ratings.

- The percentage of CVEs mapped to MITRE techniques.

- The mapping of CVEs to specific MITRE techniques and tactics.

- The distribution of vulnerabilities by severity and year.

*Conclusion*

The exploratory data analysis (EDA) in eda_threat_intel.ipynb provides an initial insight that only a small percentage (around 14.82%) of CVEs have a mapped MITRE technique. The optimized_dashboard.py script further visualizes this data, allowing users to draw conclusions about the most prevalent vulnerabilities and attack techniques based on filters for year and severity.

*Technologies Used*

The main technologies used are Python and the following libraries:

- pandas for data cleaning and preparation.

- streamlit for creating and hosting the interactive web dashboard.

- plotly.express for building the visualizations within the dashboard.