#' Amount of water
#'
#' The function \code{waterAmount(} computes the amount of water
#' Unit is in mm
#' @param isoil precipitation and/or snowmelt for each of the elevation zones
#' @param wgt weights of the input for each of the elevation zones
#' @keywords soilMoisture
#' @export
#' @examples
#' \dontrun{
#' waterAmount()
#' }

waterAmount <-function(isoil,wgt){
  amount <-sum(isoil*wgt)
  return(amount)
}
