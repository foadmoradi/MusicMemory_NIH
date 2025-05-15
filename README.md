## MusicMemory_NIH
This project explores the relationship between musical training and memory performance using data from the Adolescent Brain Cognitive Development (ABCD) study, provided by the NIH (National Institutes of Health).

We compare memory abilities between musicians and non-musicians using standardized cognitive tests, and further examine whether the amount of musical practice correlates with memory performance.

## 📊 Dataset
Data used in this project comes from the following NIH ABCD datasets:

abcd_tb_tlb01 (Picture Sequence Memory Test)

abcd_lpsaiq01 (List Sorting Working Memory Test)

You can access them at:
https://nda.nih.gov/data-structure/abcd_tb_tlb01
and
https://nda.nih.gov/data-structure/abcd_lpsaiq01

Please download the .csv files and place them in a folder named NIHTB.

## 🧠 Memory Tasks Used
PSMT (Picture Sequence Memory Test): Measures episodic memory by asking participants to recall sequences of pictures.

LSWMT (List Sorting Working Memory Test): Assesses working memory by requiring subjects to sort and recall items by category and size.

## 🛠 How to Run
This repository includes MATLAB code. To run the analysis:

Place all relevant NIH .csv files into the NIHTB folder.

Execute the scripts in the following order:

First_ReadFiles.m,
Second_ScoresTests.m,
Third_ReadMusixData.m,
Fourth_CorrelationPracticeTime.m

## 📈 Key Findings
A statistically significant difference (p < 0.05) was found in memory scores between musicians and non-musicians.

However, among musicians, there was no significant correlation between weekly practice hours and memory performance.

🔎 This suggests that musical training may be associated with enhanced memory, but increased practice time alone does not predict higher memory scores.

## 👤 Author
Foad Moradi.
Find me on social media utilizing the following hashtag:
#foadmoradimusic
