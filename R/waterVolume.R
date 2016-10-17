#' Volume of water
#'
#' The function \code{waterAmount(} computes the amount of water
#' Unit is in mm
#' @param waterSoil amount of water on non glaciated soil
#' @param waterGlaciatedSoil amount of melting water on glaciated soil
#' @param waterGlaciers amount of melting water on glaciers
#' @param waterBogs amount of water in bogs. Not taken into account so far
#' @param glacfrac fraction of glaciers area
#' @keywords soilMoisture
#' @export
#' @examples
#' \dontrun{
#' waterVolume()
#' }

waterVolume <-function(waterSoil,waterGlaciatedSoil,waterGlaciers,waterBogs=NULL,glacfrac){
  res <- waterSoil*(1-(glacfrac))+glacfrac*(waterGlaciatedSoil+waterGlaciers)
  return(res)
}
