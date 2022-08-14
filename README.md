# Tweet Credibility for Climate Events based on Social Network Analysis

This repository contains code and evaluation files for the thesis work on project titled "Tweet Credibility for Climate Events based on Social Network Analysis"  completed as part of Master's in AI Degree program at National University of Ireland, Galway.

## Project Overview:

Twitter generates and distributes both credible and non-credible information at a rapid speed through tweets, especially during emergency events. With the complex nature of the social media data, several factors affect the flow and reach of information which have been studied by many researchers to create a viable approach for automatic tweet credibility assessment, most of which are based on the use of supervised learning algorithms. This research work, on the other hand, explores the domain of tweet credibility as a network science and information retrieval problem, given that network structures are inherent to Twitter data. Using network science, information retrieval, and natural language processing techniques, an approach is devised to determine tweet credibility by analysing networks of tweets encompassing different tweet features as network relationships. Building upon the existing research in the area, this research project presents a novel approach for calculating tweet credibility scores that can be used to rank the tweets based on the correctness and trustworthiness of the information they share. The results of the novel approach that generates a set of gold standard reliable tweets from the data instead of using labels for learning are compared with a word n-grams based supervised approach to analyse and report its effectiveness.

# Prerequisites for running the project:

1. CrisisMMD Dataset: The dataset can be downloaded from [1](https://crisisnlp.qcri.org/crisismmd). This work has used version 2 of the dataset. The annotations files contain tab-separated files for each climate event which contains tweet ids used to create custom datasets for this research.

2. Twitter API Keys: To access the Twitter APIs used in this research, a Twitter developer account needs to be created which then allows the creation of a project and an app under that project. API keys and bearer tokens need to be generated for the app created under a project, and these keys and tokens can then be used for making the API requests. [2](https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api) provides guidelines for obtaining the keys and tokens. For the purpose of this research all API keys and Tokens are saved in a text file as a json object and read directly from the file. The API keys file associated with this research has not been committed to the repository for privacy reasons. 

# Thesis Code:

Following files need to be run in the given order to reproduce the results reported in the thesis.

1. create_dataset.ipynb
2. create_networks.ipynb
3. network_community_detection.R
4. analyse_communities.ipynb
5. similarity_score_calculation.ipynb

The similarity_score_calculation.ipynb file generates a list of credibility scores for each tweet in the dataset and performs evaluation to get precision, recall and f-measure scores achieved by the system. The original results reported in the thesis have been uploaded to the evaluation -> thesis_results folder.

6. word_ngrams_supervised.ipynb file contains the implementation of the supervised approach presented in [3] and generates precision, recall, and f-measure scores for a given dataset as output.

7. analyse_overlapping_tweets.ipynb file can be used to check the informativeness of tweets extracted as core tweets.


# References:
[1] “Crisismmd: Multimodal crisis dataset,” [Online]. Available: https://crisisnlp.qcri.org/crisismmd

[2] Twitter Developer Platform, “Getting started: How to get access to the Twitter API,” [Online]. Available: https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api

[3] N. Hassan, W. Gomaa, G. Khoriba, and M. Haggag, “Credibility detection in twitter using word n-gram analysis and supervised machine learning techniques,” International Journal of Intelligent Engineering and Systems, vol. 13, pp. 291–300, Dec. 2020. [Online]. Available: https://doi.org/10.22266/ijies2020.0229.27
