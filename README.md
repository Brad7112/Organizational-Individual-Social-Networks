# Organizational-Individual-Social-Networks
Made in compliance with NVSQ data transparency for experiments

Data cleaning: 
1. Keep necessary variables
2. Change "No Answer" to missing values
3. Create categorical variable related to the variable "the year living in the same place"
4. Append 2010 and 2012 to increase the number of observation
5. Change "20 Don't want to state the income", "21 Don't know", and "99 No answer" to missing value related to the variable "As to "Respondent annual income: Overall"
6. Create dummy variable related to the variable "Last school respondent attended"
7. Divide floor by 10 and delete decimal point related to categorical variable relate to "ageb
8. Delete "9 No answer" and replace "8 Not applicable" into "O Not chosen" about each volunteer activities
9. Create a new variable to mean all volunteer activities excluding "experience of volunteer activities: None"
10. Reorganize "Currently married" and "Cohabiting" and reorganize "Divorce", "Widowed", "Never married", and "Separated" related to the variable "marital stasus"
11. Drop "9 No answer" and reorganize "Almost everyday" and "Several times a week" related to the variable "frequency of meals with friends"
12. Drop "9 No answer" and reorganize "I worked last week" and "I was going to work last week, but did not work" related to the variable "work status"

Estimate logistic regression:
1. Dependent variables: any volunteer activities, and specific volunteer activities such as " ", " ", "●.
1-1. Any volunteer activities: the person who did at least one volunteering or five volunteer activities

For more details, please see my paper and do-file.
