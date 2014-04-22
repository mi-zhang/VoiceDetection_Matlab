/*
 * MATLAB Compiler: 4.3 (R14SP3)
 * Date: Fri Dec  2 16:53:31 2005
 * Arguments: "-B" "macro_default" "-R" "-nojvm" "-m" "-W" "main" "-T"
 * "link:exe" "featureExtractor.m" 
 */

#include "mclmcr.h"

#ifdef __cplusplus
extern "C" {
#endif
const unsigned char __MCC_featureExtractor_session_key[] = {
        '4', '0', 'B', '3', '5', '3', '4', 'C', '1', '7', '7', 'E', 'C', '6',
        '0', '0', 'D', '9', '4', 'F', '8', 'A', '0', '3', '1', 'B', '8', 'B',
        '3', 'D', 'F', 'B', '0', '2', 'E', '7', 'D', 'F', '6', 'D', 'E', '6',
        'D', '3', '8', '7', '1', '3', 'C', 'B', '9', 'B', '1', '5', 'D', 'B',
        '3', 'C', '7', 'E', '9', '5', 'E', 'A', '3', 'D', '8', '7', '5', 'C',
        'E', 'E', '8', 'A', 'D', 'A', '0', '7', 'C', '7', '2', '3', '1', '7',
        '4', '5', 'E', 'E', 'A', 'A', '1', '9', '7', '2', 'A', 'F', 'C', '8',
        'A', 'B', 'B', 'B', 'A', '6', '0', '0', 'E', 'F', 'E', 'A', '7', 'A',
        '7', '1', 'B', '6', '8', '2', '2', '6', 'C', 'B', '1', 'C', '5', '2',
        'F', '1', 'A', 'E', 'D', '3', 'A', '7', '8', 'C', 'F', '1', 'C', '0',
        'E', '0', 'E', 'C', '6', '8', '8', '5', '0', '8', '0', '8', '3', '5',
        'D', '0', '4', '5', 'C', 'F', '9', '7', 'F', '1', 'B', '9', 'D', '7',
        '3', 'A', 'E', '0', '4', 'B', '0', '4', '1', '5', '3', 'D', 'F', 'E',
        'C', '5', 'A', 'D', '7', 'C', 'B', 'B', '9', 'B', 'D', '2', '6', 'C',
        '7', '2', 'F', 'B', 'B', '5', 'A', '1', '3', '9', 'F', '1', '7', '5',
        '3', '6', '9', '3', '9', 'C', '3', '1', '5', '9', 'C', 'D', '0', '4',
        '6', '9', 'D', '6', '4', 'E', '7', '8', '5', 'B', 'B', '9', '3', 'F',
        'A', 'A', 'F', '3', 'D', '4', '6', '2', '9', 'D', 'A', '8', '2', 'F',
        '6', 'A', '3', '2', '\0'};

const unsigned char __MCC_featureExtractor_public_key[] = {
        '3', '0', '8', '1', '9', 'D', '3', '0', '0', 'D', '0', '6', '0', '9',
        '2', 'A', '8', '6', '4', '8', '8', '6', 'F', '7', '0', 'D', '0', '1',
        '0', '1', '0', '1', '0', '5', '0', '0', '0', '3', '8', '1', '8', 'B',
        '0', '0', '3', '0', '8', '1', '8', '7', '0', '2', '8', '1', '8', '1',
        '0', '0', 'C', '4', '9', 'C', 'A', 'C', '3', '4', 'E', 'D', '1', '3',
        'A', '5', '2', '0', '6', '5', '8', 'F', '6', 'F', '8', 'E', '0', '1',
        '3', '8', 'C', '4', '3', '1', '5', 'B', '4', '3', '1', '5', '2', '7',
        '7', 'E', 'D', '3', 'F', '7', 'D', 'A', 'E', '5', '3', '0', '9', '9',
        'D', 'B', '0', '8', 'E', 'E', '5', '8', '9', 'F', '8', '0', '4', 'D',
        '4', 'B', '9', '8', '1', '3', '2', '6', 'A', '5', '2', 'C', 'C', 'E',
        '4', '3', '8', '2', 'E', '9', 'F', '2', 'B', '4', 'D', '0', '8', '5',
        'E', 'B', '9', '5', '0', 'C', '7', 'A', 'B', '1', '2', 'E', 'D', 'E',
        '2', 'D', '4', '1', '2', '9', '7', '8', '2', '0', 'E', '6', '3', '7',
        '7', 'A', '5', 'F', 'E', 'B', '5', '6', '8', '9', 'D', '4', 'E', '6',
        '0', '3', '2', 'F', '6', '0', 'C', '4', '3', '0', '7', '4', 'A', '0',
        '4', 'C', '2', '6', 'A', 'B', '7', '2', 'F', '5', '4', 'B', '5', '1',
        'B', 'B', '4', '6', '0', '5', '7', '8', '7', '8', '5', 'B', '1', '9',
        '9', '0', '1', '4', '3', '1', '4', 'A', '6', '5', 'F', '0', '9', '0',
        'B', '6', '1', 'F', 'C', '2', '0', '1', '6', '9', '4', '5', '3', 'B',
        '5', '8', 'F', 'C', '8', 'B', 'A', '4', '3', 'E', '6', '7', '7', '6',
        'E', 'B', '7', 'E', 'C', 'D', '3', '1', '7', '8', 'B', '5', '6', 'A',
        'B', '0', 'F', 'A', '0', '6', 'D', 'D', '6', '4', '9', '6', '7', 'C',
        'B', '1', '4', '9', 'E', '5', '0', '2', '0', '1', '1', '1', '\0'};

static const char * MCC_featureExtractor_matlabpath_data[] = 
    { "featureExtractor/", "toolbox/compiler/deploy/",
      "projects/hsd/src/matlab/conversation/voicing/",
      "projects/hsd/src/matlab/conversation/voicing/util/",
      "homes/gws/danny/matlab/libs/rastamat/",
      "homes/gws/danny/matlab/libs/FullBNT/KPMtools/",
      "$TOOLBOXMATLABDIR/general/", "$TOOLBOXMATLABDIR/ops/",
      "$TOOLBOXMATLABDIR/lang/", "$TOOLBOXMATLABDIR/elmat/",
      "$TOOLBOXMATLABDIR/elfun/", "$TOOLBOXMATLABDIR/specfun/",
      "$TOOLBOXMATLABDIR/matfun/", "$TOOLBOXMATLABDIR/datafun/",
      "$TOOLBOXMATLABDIR/polyfun/", "$TOOLBOXMATLABDIR/funfun/",
      "$TOOLBOXMATLABDIR/sparfun/", "$TOOLBOXMATLABDIR/scribe/",
      "$TOOLBOXMATLABDIR/graph2d/", "$TOOLBOXMATLABDIR/graph3d/",
      "$TOOLBOXMATLABDIR/specgraph/", "$TOOLBOXMATLABDIR/graphics/",
      "$TOOLBOXMATLABDIR/uitools/", "$TOOLBOXMATLABDIR/strfun/",
      "$TOOLBOXMATLABDIR/imagesci/", "$TOOLBOXMATLABDIR/iofun/",
      "$TOOLBOXMATLABDIR/audiovideo/", "$TOOLBOXMATLABDIR/timefun/",
      "$TOOLBOXMATLABDIR/datatypes/", "$TOOLBOXMATLABDIR/verctrl/",
      "$TOOLBOXMATLABDIR/codetools/", "$TOOLBOXMATLABDIR/helptools/",
      "$TOOLBOXMATLABDIR/demos/", "toolbox/local/", "toolbox/compiler/",
      "toolbox/signal/signal/", "toolbox/signal/sigtools/" };

static const char * MCC_featureExtractor_classpath_data[] = 
    { "" };

static const char * MCC_featureExtractor_libpath_data[] = 
    { "" };

static const char * MCC_featureExtractor_app_opts_data[] = 
    { "" };

static const char * MCC_featureExtractor_run_opts_data[] = 
    { "-nojvm" };

static const char * MCC_featureExtractor_warning_state_data[] = 
    { "" };


mclComponentData __MCC_featureExtractor_component_data = { 

    /* Public key data */
    __MCC_featureExtractor_public_key,

    /* Component name */
    "featureExtractor",

    /* Component Root */
    "",

    /* Application key data */
    __MCC_featureExtractor_session_key,

    /* Component's MATLAB Path */
    MCC_featureExtractor_matlabpath_data,

    /* Number of directories in the MATLAB Path */
    37,

    /* Component's Java class path */
    MCC_featureExtractor_classpath_data,
    /* Number of directories in the Java class path */
    0,

    /* Component's load library path (for extra shared libraries) */
    MCC_featureExtractor_libpath_data,
    /* Number of directories in the load library path */
    0,

    /* MCR instance-specific runtime options */
    MCC_featureExtractor_app_opts_data,
    /* Number of MCR instance-specific runtime options */
    0,

    /* MCR global runtime options */
    MCC_featureExtractor_run_opts_data,
    /* Number of MCR global runtime options */
    1,
    
    /* Component preferences directory */
    "featureExtractor_895AD2B79B600B7337E315FC60130623",

    /* MCR warning status data */
    MCC_featureExtractor_warning_state_data,
    /* Number of MCR warning status modifiers */
    0,

    /* Path to component - evaluated at runtime */
    NULL

};

#ifdef __cplusplus
}
#endif


