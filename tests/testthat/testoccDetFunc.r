context("Test occDetFunc")

# Create data
n <- 15000 #size of dataset
nyr <- 20 # number of years in data
nSamples <- 100 # set number of dates
nSites <- 50 # set number of sites
set.seed(125)

# Create somes dates
first <- as.Date(strptime("2010/01/01", "%Y/%m/%d")) 
last <- as.Date(strptime(paste(2010+(nyr-1),"/12/31", sep=''), "%Y/%m/%d")) 
dt <- last-first 
rDates <- first + (runif(nSamples)*dt)

# taxa are set as random letters
taxa <- sample(letters, size = n, TRUE)

# three sites are visited randomly
site <- sample(paste('A', 1:nSites, sep=''), size = n, TRUE)

# the date of visit is selected at random from those created earlier
time_period <- sample(rDates, size = n, TRUE)

# format data
suppressWarnings({visitData <- formatOccData(taxa = taxa, site = site,
                                             time_period = time_period)})

test_that("Test occDetFunc errors", {
  
 expect_error(results <- occDetFunc(taxa_name = 'a',
                       n_iterations = 50,
                       burnin = 500, 
                       occDetdata = visitData$occDetdata,
                       spp_vis = visitData$spp_vis,
                       write_results = FALSE,
                       seed = 111),
              'must not be larger that the number of iteration')
  
 expect_error(results <- occDetFunc(taxa_name = 'apple',
                                    n_iterations = 50,
                                    burnin = 15, 
                                    occDetdata = visitData$occDetdata,
                                    spp_vis = visitData$spp_vis,
                                    write_results = FALSE,
                                    seed = 111),
              'taxa_name is not the name of a taxa in spp_vis')    
})

test_that("Test occDetFunc with defaults", {
  
  sink(file=ifelse(Sys.info()["sysname"] == "Windows",
                   "NUL",
                   "/dev/null"))
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111)
  sink()

  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
})

test_that("Test occDetFunc with model types", {
  
  sink(file=ifelse(Sys.info()["sysname"] == "Windows",
                   "NUL",
                   "/dev/null"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'centering',
                                                  'halfcauchy'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))

  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'centering',
                                                  'inversegamma'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'intercept'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'intercept',
                                                  'halfcauchy'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'intercept',
                                                  'inversegamma'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'centering',
                                                  'halfcauchy'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'centering',
                                                  'inversegamma'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'intercept'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'intercept',
                                                  'halfcauchy'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'intercept',
                                                  'inversegamma'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk',
                                                  'halfcauchy'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  
  sink()
  
})

test_that("Test occDetFunc with julian date", {
  
  sink(file=ifelse(Sys.info()["sysname"] == "Windows",
                   "NUL",
                   "/dev/null"))
  
  suppressWarnings({visitData <- formatOccData(taxa = taxa, site = site,
                                               time_period = time_period,
                                               includeJDay = TRUE)})
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'intercept',
                                                  'inversegamma', 'jul_date'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  expect_true('beta1' %in% row.names(results$BUGSoutput$summary))
  expect_true('beta2' %in% row.names(results$BUGSoutput$summary))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'centering',
                                                  'halfcauchy', 'jul_date'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  expect_true('beta1' %in% row.names(results$BUGSoutput$summary))
  expect_true('beta2' %in% row.names(results$BUGSoutput$summary))
  
  sink()
  
})  

test_that("Test occDetFunc with catagorical list length", {
  
  sink(file=ifelse(Sys.info()["sysname"] == "Windows",
                   "NUL",
                   "/dev/null"))
  
  suppressWarnings({visitData <- formatOccData(taxa = taxa, site = site,
                                               time_period = time_period,
                                               includeJDay = TRUE)})
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('ranwalk', 'intercept',
                                                  'inversegamma', 'catlistlength'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  expect_true('dtype2.p' %in% row.names(results$BUGSoutput$summary))
  expect_true('dtype3.p' %in% row.names(results$BUGSoutput$summary))
  
  results <- occDetFunc(taxa_name = 'a',
                        n_iterations = 50,
                        burnin = 15, 
                        occDetdata = visitData$occDetdata,
                        spp_vis = visitData$spp_vis,
                        write_results = FALSE,
                        seed = 111, modeltype = c('indran', 'centering',
                                                  'halfcauchy', 'catlistlength'))
  expect_identical(results$SPP_NAME, 'a')
  expect_identical(results$n.iter, 50)
  expect_identical(names(results),
                   c("model", "BUGSoutput", "parameters.to.save", "model.file", 
                     "n.iter", "DIC", "SPP_NAME", "min_year", "max_year",
                     "nsites", "nvisits", "species_sites", "species_observations"))
  expect_true('dtype2.p' %in% row.names(results$BUGSoutput$summary))
  expect_true('dtype3.p' %in% row.names(results$BUGSoutput$summary))
  
  sink()
  
})  