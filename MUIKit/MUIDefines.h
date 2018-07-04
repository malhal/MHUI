//
//  MUIDefines.h
//  MUIKit
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#ifndef MUIKIT_EXTERN
    #ifdef __cplusplus
        #define MUIKIT_EXTERN   extern "C" __attribute__((visibility ("default")))
    #else
        #define MUIKIT_EXTERN   extern __attribute__((visibility ("default")))
    #endif
#endif

#import <MUIKit/MUIDefines+Namespace.h>
