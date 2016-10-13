//
//  MHUDefines.h
//  MHUI
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <MHUI/MHUNamespaceDefines.h>

#ifndef MHUI_EXTERN
    #ifdef __cplusplus
        #define MHUI_EXTERN   extern "C" __attribute__((visibility ("default")))
    #else
        #define MHUI_EXTERN   extern __attribute__((visibility ("default")))
    #endif
#endif