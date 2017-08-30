# 智能引入依赖包
import <- function (pkgs){
  new_pkgs <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]

  if (length(new_pkgs)) install.packages(new_pkgs, dependencies = TRUE)

  sapply(pkgs, require, character.only = TRUE)
}
