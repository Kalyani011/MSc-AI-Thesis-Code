# Script to create communities from the four tweet networks representing different relationships 
# and save the communities as described in Section 5.3.1.1.

# Run the entire script to generate communities lists for each of the 
# four networks described in Section 5.2.

##### Note: This step requires to have the four networks created using 
#####       create_networks.ipynb script for a given climate event.

library(igraph) # Loading the igraph library for using community detection algorithms

## INITIALISATIONS:

# Set following path to directory containing the networks created for the climate event specified
network_store_path <- '../../Data/Networks'

# Set following path to the directory where network communities are to be stored
network_communities_path = '../../Data/Communities'

# Following is the list of climate event names as per the files 
# stored in annotations folder of CrisisMMD dataset. 
# 'california_wildfires'
# 'hurricane_harvey'
# 'hurricane_irma'
# 'hurricane_maria'
# 'iraq_iran_earthquake'
# 'mexico_earthquake'
# 'srilanka_floods'

# Set the event name of climate event for which the network communities are to be generated
event_name <- 'california_wildfires'

# DEFINING FUNCTIONS FOR READING GRAPHS, CONVERTING IGRAPH COMMUNITY OBJECT INTO LIST OF COMMUNITIES, AND
# SAVING THE COMMUNITIES AS CSV FILES:

# Method to read graph from disk
read_tweets_graph <- function(relationship) {
  return (read.graph(file=paste0(network_store_path,'/',event_name,'_',relationship,'.gml'), format=
                       "gml"))
}

# Method to get clusters of tweet ids according to the communities detected
# and store in a compatiable format which can be processed further.
get_communities <- function(community) {
  # Getting communities from community object
  clusters <- communities(community)
  for (x in 1:length(clusters)) {
    # Converting the communities into strings
    clusters[x] <- toString(clusters[[x]])
  }
  # Storing communities as list of strings to save as csv file
  communities <- c()
  for(cluster in clusters) {
    communities <- c(communities, cluster)
  }  
  return(communities)
}

# Method to save communities in csv file
save_community <- function(community_obj, relationship, algorithm) {
  write.csv(get_communities(community_obj), file=
              paste0(network_communities_path,'/',event_name,'_',algorithm,'_',relationship,'.csv'))  
}

# READING GRAPHS:

# Reading author relationship tweets network
G_author <- read_tweets_graph('author')
V(G_author)$name <- V(G_author)$label
V(G_author)$deg <- degree(G_author)
# Removing nodes with zero degree (isolates)
G_author <- delete_vertices(G_author, V(G_author)[V(G_author)$deg==0])

# Reading url relationship tweets network
G_url <- read_tweets_graph('url')
V(G_url)$name <- V(G_url)$label
V(G_url)$deg <- degree(G_url)
# Removing nodes with zero degree (isolates)
G_url <- delete_vertices(G_url, V(G_url)[V(G_url)$deg==0])

# Reading similar retweet count relationship tweets network
G_retweets <- read_tweets_graph('retweet_count')
V(G_retweets)$name <- V(G_retweets)$label
V(G_retweets)$deg <- degree(G_retweets)
# Removing nodes with zero degree (isolates)
G_retweets <- delete_vertices(G_retweets, V(G_retweets)[V(G_retweets)$deg==0])

# Reading similar followers count relationship tweets network
G_followers <- read_tweets_graph('followers')
V(G_followers)$name <- V(G_followers)$label
V(G_followers)$deg <- degree(G_followers)
# Removing nodes with zero degree (isolates)
G_followers <- delete_vertices(G_followers, V(G_followers)[V(G_followers)$deg==0])

# APPLYING THE THREE COMMUNITY DETECTION ALGORITHMS AS DISCUSSED IN SECTION 5.3.1.1:

# Applying Louvain Community Detection Algorithm on Networks
louvain.author <- cluster_louvain(G_author)
louvain.url <- cluster_louvain(G_url)
louvain.retweets <- cluster_louvain(G_retweets)
louvain.followers <- cluster_louvain(G_followers)

# Applying Infomap Community Detection Algorithm on Networks
infomap.author <- cluster_infomap(G_author)
infomap.url <- cluster_infomap(G_url)
infomap.retweets <- cluster_infomap(G_retweets)
infomap.followers <- cluster_infomap(G_followers)

# Applying Walktrap Community Detection Algorithm on Networks
walktrap.author <- cluster_walktrap(G_author)
walktrap.url <- cluster_walktrap(G_url)
walktrap.retweets <- cluster_walktrap(G_retweets)
walktrap.followers <- cluster_walktrap(G_followers)

# SAVING THE GENERATED COMMUNITIES ON DISK IN CSV FORMAT:

# Saving louvain communities
save_community(louvain.author, 'author', 'louvain_isolates')
save_community(louvain.url, 'urls', 'louvain_isolates')
save_community(louvain.retweets, 'retweet_count', 'louvain_isolates')
save_community(louvain.followers, 'followers', 'louvain_isolates')

# # Saving infomap communities
save_community(infomap.author, 'author', 'infomap_isolates')
save_community(infomap.url, 'urls', 'infomap_isolates')
save_community(infomap.retweets, 'retweet_count', 'infomap_isolates')
save_community(infomap.followers, 'followers', 'infomap_isolates')

# # Saving walktrap communities
save_community(walktrap.author, 'author', 'walktrap_isolates')
save_community(walktrap.url, 'urls', 'walktrap_isolates')
save_community(walktrap.retweets, 'retweet_count', 'walktrap_isolates')
save_community(walktrap.followers, 'followers', 'walktrap_isolates')

# The functions used in above code are based on following resources:

# REFERENCES:
# [1] c. Hayes. "CT5133 Web & Network Science: Community Detection", 
#     National University of Ireland, Galway.
# [2] R Documentation. "Finding community structure by multi-level optimization of modularity". 
#     Available:https://igraph.org/r/doc/cluster_louvain.html
# [3] R Documentation. "Community structure via short random walks". 
#     Available:https://igraph.org/r/doc/cluster_walktrap.html
# [4] R Documentation. "Infomap community finding". 
#     Available:https://igraph.org/r/doc/cluster_infomap.html
# [5] K. Kawale. "CT5133 Web & Network Science Assessment 3: Community Detection on 
#     Word Association Network", 2022, National University of Ireland, Galway.

