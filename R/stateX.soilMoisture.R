#' stateX.soilMoisture
#'
#' The function \code{stateX.soilMoisture()} provides the key features of the soil Moisture.
#' 1- Compute the water amount (in mm) of precipitation and snowmelt, for each level zone:
#' i-on non-glaciated soils
#' ii- on glaciated soils
#' iii- on glaciers
#' iv- NOT YET on bogs
#' 2- compute the Z(t): Actual water volume present in the soil moisture zone (Skaugen et Onof, 2013)
#' @param isoil precipitation and/or snowmelt from the elevation zones, vector(level zone)
#' @param gisoil glaciermelt from the elevation zones, vector(level zone)
#' @param bisoil bog melt from the elevation zones, vector(level zone)
#' @param swgt weights for input for each elevation zone
#' @param gwgt weights for input for each elevation zone
#' @param snowfree weights for input for each elevation zone
#' @param glacfrac fraction of glaciers area
#' @keywords soilMoisture
#' @export
#' @examples
#' \dontrun{
#' stateX()
#' }
stateX.soilMoisture <-function(isoil,gisoil,bisoil=NULL,swgt,gwgt,snowfree,glacfrac){

  waterSoil <- ifelse(!is.null(isoil),waterAmount(isoil=isoil,wgt=swgt),0)
  waterGlaciatedSoil <- ifelse(!is.null(isoil),waterAmount(isoil=isoil,wgt=gwgt),0)
  waterGlaciers <- ifelse(!is.null(gisoil),waterAmount(isoil=gisoil,wgt=gwgt*snowfree),0)

  bisoil <- NULL
  waterBogs <- ifelse(!is.null(bisoil),waterAmount(isoil=bisoil,wgt=swgt),0)

  # waterGlaciatedSoil + waterGlaciers is total output from glaciers
  # rem: gwgt because it is going to be scaled by glacfrac later on

  # waterVolume: input from rain, snow and glaciers
   Z <- waterVolume(waterSoil=waterSoil,waterGlaciatedSoil=waterGlaciatedSoil,waterGlaciers=waterGlaciers,waterBogs=waterBogs,glacfrac=glacfrac)

  cat("gisoil: ", gisoil, "\n" )
  cat("gwgt: ", gwgt, "\n" )
  cat("snowfree: ", snowfree, "\n" )
  cat("waterGlaciers: ", waterGlaciers, "\n" )

  results <- list(waterSoil = waterSoil,
                  waterGlaciatedSoil = waterGlaciatedSoil,
                  waterGlaciers = waterGlaciers,
                  Z = Z)

  return(results)
}
