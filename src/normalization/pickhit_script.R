rm(list=ls())
source('pickhit_util.R')
root <- '.'
sfp_1 <- read.csv(sprintf('%s/norm_result/sfp_1_norm_table.csv', root), stringsAsFactors=F)
sfp_2 <- read.csv(sprintf('%s/norm_result/sfp_2_norm_table.csv', root), stringsAsFactors=F)
AcpS_1 <- read.csv(sprintf('%s/norm_result/AcpS_1_norm_table.csv', root), stringsAsFactors=F)
AcpS_2 <- read.csv(sprintf('%s/norm_result/AcpS_2_norm_table.csv', root), stringsAsFactors=F)
data.table <- cbind(sfp_1[, c('TS', 'spot', 'seq', 'unique_seq_idx', 'theta')], matrix(NA, nrow=nrow(sfp_1), ncol=3))
raw.table <- read.csv('../../data/all_TS_raw_reading.csv', stringsAsFactors=F)
colnames(data.table) <- c('TS', 'spot', 'seq', 'unique_seq_idx', 'sfp_1', 'sfp_2', 'AcpS_1', 'AcpS_2')
for (n in 1:nrow(sfp_2))
    data.table[data.table[, 'seq'] == sfp_2[n, 'seq'], 'sfp_2'] <- sfp_2[n, 'theta']
for (n in 1:nrow(AcpS_1))
    data.table[data.table[, 'seq'] == AcpS_1[n, 'seq'], 'AcpS_1'] <- AcpS_1[n, 'theta']
for (n in 1:nrow(AcpS_2))
    data.table[data.table[, 'seq'] == AcpS_2[n, 'seq'], 'AcpS_2'] <- AcpS_2[n, 'theta']
#data.table <- data.table[data.table[, 'TS'] != 2,]

#sfp_type <- log.rank(data.table, 'sfp_1', 0.1, 'sfp_2', 1, 'AcpS_1', 1)
#slice.table(sfp_type, 20, 'rank_table', 'sfp_type')

#AcpS_type <- log.rank(data.table, 'AcpS_1', 0.1, 'AcpS_2', 1, 'sfp_1', 1)
#slice.table(AcpS_type, 20, 'rank_table', 'AcpS_type')

#### Rank by sfp orthogonal labeling
#org_data <- data.table[data.table[, 'TS'] != 2,]
#vals <- 0.1 * to.log(org_data[, 'sfp_1']) + to.log(org_data[,'sfp_1'] - org_data[,'AcpS_1'])
#org_data <- cbind(org_data, vals)
#rank_by_sfp_orth <- org_data[order(vals, decreasing=T),]
#slice.table(rank_by_sfp_orth[1:499,], 20, 'rank_table', 'rank_by_sfp_orth')
### Rank by AcpS orthogonal labeling
#org_data <- data.table[data.table[, 'TS'] != 2,]
#vals <- 0.1 * to.log(org_data[, 'AcpS_1']) + to.log(org_data[,'AcpS_1'] - org_data[,'sfp_1'])
#org_data <- cbind(org_data, vals)
#rank_by_AcpS_orth <- org_data[order(vals, decreasing=T),]
#slice.table(rank_by_AcpS_orth[1:499,], 20, 'rank_table', 'rank_by_AcpS_orth')
#### Rank by sfp label and unlabel
#org_data <- data.table[data.table[, 'TS'] != 2,]
#vals <- 0.1 * to.log(org_data[, 'sfp_1']) + to.log(org_data[,'sfp_1'] - org_data[,'sfp_2'])
#org_data <- cbind(org_data, vals)
#rank_by_sfp_label_unlabel <- org_data[order(vals, decreasing=T),]
#slice.table(rank_by_sfp_label_unlabel[1:499,], 20, 'rank_table', 'rank_by_sfp_label_unlabel')
### Rank by AcpS label and unlabel
org_data <- data.table[data.table[, 'TS'] != 2,]
vals <- 0.1 * to.log(org_data[, 'AcpS_1']) + to.log(org_data[,'AcpS_1'] - org_data[,'AcpS_2'])
org_data <- cbind(org_data, vals)
rank_by_AcpS_label_unlabel <- org_data[order(vals, decreasing=T),]
slice.table(rank_by_AcpS_label_unlabel[1:499,], 20, 'rank_table', 'rank_by_AcpS_label_unlabel')
