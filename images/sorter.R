setwd("D:/OneDrive - University of Iowa/Wasserman's Lab/Experiments/2020 HumanCancer/tissue_exp/")
#Identify images, and sort them into sets and magnification files

#get the non-rotated images
files = dir("./images/base/")

trialsf = file('./set_info/base_sets.js')

mags = c('4x', '10x', '20x')
rots = c('00_', 'VF_', 'HF_', '90_', '270', '180')
vars = c()
for (m in mags){
  for (s in c('A', 'B')){
    for (r in rots){
    imgs = files[grepl(ifelse(m == '4x', sprintf('*%s.jpg', s), sprintf('*%s%s.jpg', s, m)), files) &
                   substr(files, 1, 3) == r]
    #sort
    imgs = c(imgs[grepl('CA', imgs)], imgs[grepl('NM', imgs)])
    #write
    vars = c(vars,
             paste0(sprintf('var %s%s%s = [', s, m, substr(as.character(r), 1, 2)),
             paste0(sprintf("{exemplar: '%s', category: '%s', rotation: '%s'}", 
                            imgs, 
                            rep(c("CA", "NM"), each = length(imgs)/2), 
                            rep(r, length(imgs))),
                    collapse = ','), '];\n'))
    }
  }
}
writeLines(vars, trialsf)
close(trialsf)

