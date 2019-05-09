# Interactive Visualization

The purpose of this project is to visualize the relationsips between student's performance in different types of test items.

* [My Shiny App](https://victoriayang.shinyapps.io/interactive-visualization/)

<img align="center" width = "850" src="https://github.com/victoria-yang/interactive-visualization-project/blob/master/ShinyGif.gif">

## Procedure
* **Data Wrangling** 

    The original datasets are **quiz-categories.csv** and **midterm-result.csv** which can also be found in this github repository. The datasets are wrangled and turned into the datasets showing below. Some of the variables in the original datasets were not used in this project. For instance, the enrollment status (0 = enroll, 1 = audit), number of attempt of each test item, and how much time did a student spent for answering each test item. 

    **student_performance.csv** shows the correctness of each student in each item of the midterm test.  and **item_type.csv** maps the test items to related knowledge and test types. 

    In this midtern, there were 30 items in total and covered seven topics which are wrangling, coding, d.trees, sna, nlp, viz, n.nets. All the items were also categorized in different test types such as whether the answer is googleable, whether this item related to just in time learning, whether this item is a substantive question (involved wrestling with a complex idea that does not have a definitive answer). Most of the test items covered more than one topics and can be related to more than one abilities. For example, Question 13 requires student's knowledge of coding and sna. Its answer is googleale and requires student's just in time learning skills.

* **Data Analysis**

    Since this project is explorational, rigorous statistical analyses were not used in this project. This led to many limitations which I will elaborate in the **Limitation** section. 

    The related topics and types of each item were simply added up. For instance, there were 4 items related to wrangling skills so a student can get maximum 4 points in wrangling part. There were 10 items related to coding skills so a student can get maximum 10 points in coding part.
    
    <img align="center" width = "600" src="https://github.com/victoria-yang/interactive-visualization/blob/master/W_and_C.png">


* **Visualization**

    Scatter plots were used to show the relation between each type of test items. Each dot on the plot represents the student's performance in each certain type of test item. The color of the dot encodes the information of the total score of that student. The darker the dot is, the higher total score that student got in the midterm test.


* **Bind the visualization to the Shiny framework**

    In this section, please refer to the [Shiny Apps Documentation](https://shiny.rstudio.com/).

    The user can select two topics or test types and play with the data to see the relationship between them. If the user is interested in the raw data, he or she can click on more -> datasets to see the raw data.

## Dataset Info
<img align="center" width = "850" src="https://github.com/victoria-yang/interactive-visualization-project/blob/master/DatasetInfo.gif">

- **student_performance.csv**
    - Description: This dataset shows the correctness of each student in each item of the midterm test. There are 30 items in total.
    - Variables: 
        - id: student id
        - Q1_c ~ Q30_c: incorrect=0, correct=1 in the midterm test items

    
- **item_type.csv**
    - Description: This dataset maps the test items to related knowledge and test types.
    - Variables: 
        - Question: test items id
        - wrangling: Question required data manipulations skills  
        - coding: Question required coding skills  
        - d.trees: Question invoilved decision trees  
        - sna: Question involved social network analysis  
        - nlp: Question involved natural language processing  
        - viz: Question involved visualization of data  
        - n.nets: Question involved neural nets  
        - googleable: Question could be answered by searching the internet  
        - non-googleable: Question could not be answered through simple searching of the internet  
        - jitl: Question involved learning somethimg new (just in time learning)  
        - substantive: Question involved wrestling with a complex idea that does not have a definitive answer


## Discovery

As we can see in the visualization, student’s performance in some topics are more related to higher total score. For instance, if you select coding as y axis and total as x axis, you can see that student’s correctness in coding items has a high correlation to their total score. This pattern is also similar to nlp and viz items. 

<img align="center" width = "600" src="https://github.com/victoria-yang/interactive-visualization-project/blob/master/coding_total.png">

While d.tree item seems to has less correlation to the total score. (There is a dot appears at unreasonable place and I will fix that later…)

<img align="center" width = "600" src="https://github.com/victoria-yang/interactive-visualization-project/blob/master/d.tree_total.png">

The results of four different question types are showed in the following gif. Interestingly, the correctness of googleable items seems to has the highest correlation to the total score than other types of item.

<img align="center" width = "600" src="https://github.com/victoria-yang/interactive-visualization-project/blob/master/types_total.gif">

## Limitations

* **The method of labeling of these topics and item types is unknown**

    We are also unable to see the original test questions of this midterm exam.

* **The constructs of each topic and item type can overlap in a certain degree**

    So we cannot expect the the results of this project can be analogized to other courses. Regression Analysis is need to gain more rigorous inferences.

* **The number of items related to different topics is severely unbalanced**

    We can see that some topics contains 15 items and some just 3. 

* **The correlation could be overestimated by visually inspect these plots just because the number of items represent certain topics is larger than another**

    We can see that if a topic contains more items, that topic seems to have higher correlation to the total score. The remedial ways to deal with this problem could be to calculate the correlation coefficient and draw the regression line to the visualization.

* **Some dots are hidden because they are at the same position on the plot**

    There are 26 students in total but some plots shows less than 26 dots. Some methods should be utilized to spread those overlapping dots without move them too far way from their orginal position.

## Future work

* The item difficulty and discrimination will be calculated for each item for further analysis to make comparison between these items more meaningful and accurate. 

* **Hover** function will be add into my Shinyapps so when the users mouseover the dot on the plot, they are provided information such as student id and their advantages and weakness. 

* The descriptive statistics as well as individual information of both student performance and each type of items will be shown in the tabs **Individual**  and  **Test Items**.

## Tools
* [R](https://www.r-project.org)
* [RStudio](https://www.rstudio.com)
* [Shiny](https://www.rstudio.com/products/shiny-2/)- An open source R package that provides an web framework for building web applications using R
* [Shinyapps.io](https://www.shinyapps.io/)- A platform to put your Shiny applications without having to set up a Shiny Server in advance
* [RecordIt](http://recordit.co) - An application helps you turn screen records into gif files 

## Author
[Chieh-An (Victoria) Yang](https://www.linkedin.com/in/victoria-chieh-an-yang/) - Learning Analytics MS student at Teachers College, Columbia University

