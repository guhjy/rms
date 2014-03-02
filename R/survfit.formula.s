survfit.formula <- function(formula, data, ...)
{
  sff <- survival::survfit.formula
  ## Cannot use getS3method('survfit', 'formula') as will cause recursion
  ## Can't use as.name('survival::survfit.formula')
  mc <- match.call()
  mc[[1L]] <- as.name('sff')
  f <- eval(mc, list(sff=sff), parent.frame())
  
  f$maxtime <- max(f$time)

  g <- if(missing(data)) model.frame(formula)
  else model.frame(formula, data=data)
  Y <- model.extract(g, 'response')
  iat <- attr(Y, 'inputAttributes')
  f$units      <- iat$time$units
  f$time.label <- iat$time$label
  f$call <- match.call()
  f
}
