
find_path(MINIUPNP_INCLUDE_DIR miniupnpc.h PATH_SUFFIXES miniupnpc)
find_library(MINIUPNP_LIBRARY miniupnpc)

if(MINIUPNP_INCLUDE_DIR AND MINIUPNP_LIBRARY)
  set(MINIUPNP_FOUND TRUE)
else()
  set(MINIUPNP_FOUND FALSE)
endif()

MARK_AS_ADVANCED(MINIUPNP_INCLUDE_DIR MINIUPNP_LIBRARY)
