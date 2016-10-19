#' Initialize information related to Soil Moisture
#'
#' Initialize the information related to ssoil Moisture
#' @param method method for the initialization, "load", "source", "manual", "procecessed"
#' @param path directory where to get the files
#' @param waterSoil amount of water in soil (in mm)
#' @param waterGlaciatedSoil amount of water in glaciated soil (in mm)
#' @param waterGlaciers amount of water in glaciers (in mm)
#' @param Z waterVolume, input from rain, snow and glaciers (in mm)
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
#' init.soilMoisture()
#' }
init.soilMoisture <-function(method=NULL,path=NULL,waterSoil=NULL,waterGlaciatedSoil=NULL,waterGlaciers=NULL,Z=NULL,
               isoil=NULL,gisoil=NULL,bisoil=NULL,swgt=NULL,gwgt=NULL,snowfree=NULL,glacfrac=NULL){

  soilMoisture <- switch(method,
    "manual"    = init.manual(waterSoil=waterSoil,waterGlaciatedSoil=waterGlaciatedSoil,waterGlaciers=waterGlaciers,Z=Z),
    "processed" = init.parocessed(isoil=isoil,gisoil=gisoil,bisoil=bisoil,swgt=swgt,gwgt=gwgt,snowfree=snowfree,glacfrac=glacfrac),
    "load"      = init.load(path=path),
    "source"    = init.source(path=path),
    (message=paste0("Invalid method:", method,".")))

  return(soilMoisture)
}

init.manual <- function(waterSoil,waterGlaciatedSoil,waterGlaciers,Z){
   res <- list(waterSoil=waterSoil,
               waterGlaciatedSoil=waterGlaciatedSoil,
               waterGlaciers=waterGlaciers,
               Z=Z)
  return(res)
}

init.load <- function(path){
  load(paste0(path,"soilMoisture.rda"))
  return(soilMoisture)
}

init.source <- function(path){
  source(paste0(path,"soilMoisture.R"),local=TRUE)
  return(soilMoisture)
}

init.processed <-function(isoil,gisoil,bisoil,swgt,gwgt,snowfree,glacfrac){
  if ( (!is.null(isoil)) && (!is.null(gisoil)) && (!is.null(swgt)) && (!is.null(gwgt)) && (!is.null(snowfree)) && (!is.null(glacfrac)) ) {
    res <- stateX(isoil=isoil,gisoil=gisoil,bisoil=bisoil,swgt=swgt,gwgt=gwgt,snowfree=snowfree,glacfrac=glacfrac)
    return(res)
  } else stop("NULL arguments in init.processed Soil Moisture")

}
