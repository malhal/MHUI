//
//  MUIDefines+Namespace.h
//  MUIKit
//
//  Generated using MHNamespaceGenerator on 22/09/2017
//

#if !defined(__MUIKIT_NAMESPACE_APPLY) && defined(MUIKIT_NAMESPACE) && defined(MUIKIT_NAMESPACE_LOWER)
    #define __MUIKIT_NAMESPACE_REWRITE(ns, s) ns ## _ ## s
    #define __MUIKIT_NAMESPACE_BRIDGE(ns, s) __MUIKIT_NAMESPACE_REWRITE(ns, s)
    #define __MUIKIT_NAMESPACE_APPLY(s) __MUIKIT_NAMESPACE_BRIDGE(MUIKIT_NAMESPACE, s)
	#define __MUIKIT_NAMESPACE_APPLY_LOWER(s) __MUIKIT_NAMESPACE_BRIDGE(MUIKIT_NAMESPACE_LOWER, s)
// Classes
    #define MUIAccountViewController __MUIKIT_NAMESPACE_APPLY(MUIAccountViewController)
    #define MUIAlertController __MUIKIT_NAMESPACE_APPLY(MUIAlertController)
    #define MUIDictionaryViewController __MUIKIT_NAMESPACE_APPLY(MUIDictionaryViewController)
    #define MUIEditableTableCell __MUIKIT_NAMESPACE_APPLY(MUIEditableTableCell)
    #define MUIFlipController __MUIKIT_NAMESPACE_APPLY(MUIFlipController)
    #define MUILogInViewController __MUIKIT_NAMESPACE_APPLY(MUILogInViewController)
    #define MUILongRunningTaskController __MUIKIT_NAMESPACE_APPLY(MUILongRunningTaskController)
    #define MUIMultilineTableCell __MUIKIT_NAMESPACE_APPLY(MUIMultilineTableCell)
    #define MUIProgressViewController __MUIKIT_NAMESPACE_APPLY(MUIProgressViewController)
    #define MUISignUpViewController __MUIKIT_NAMESPACE_APPLY(MUISignUpViewController)
// Categories
    #define MUI __MUIKIT_NAMESPACE_APPLY(MUI)
    #define mui_alertControllerWithTitle __MUIKIT_NAMESPACE_APPLY_LOWER(mui_alertControllerWithTitle)
    #define mui_alertWindow __MUIKIT_NAMESPACE_APPLY_LOWER(mui_alertWindow)
    #define mui_createBlurredBackgroundView __MUIKIT_NAMESPACE_APPLY_LOWER(mui_createBlurredBackgroundView)
    #define mui_loading __MUIKIT_NAMESPACE_APPLY_LOWER(mui_loading)
    #define mui_progressView __MUIKIT_NAMESPACE_APPLY_LOWER(mui_progressView)
    #define mui_setAlertWindow __MUIKIT_NAMESPACE_APPLY_LOWER(mui_setAlertWindow)
    #define mui_setHidden __MUIKIT_NAMESPACE_APPLY_LOWER(mui_setHidden)
    #define mui_setLoading __MUIKIT_NAMESPACE_APPLY_LOWER(mui_setLoading)
    #define mui_show __MUIKIT_NAMESPACE_APPLY_LOWER(mui_show)
    #define mui_showAlertWithError __MUIKIT_NAMESPACE_APPLY_LOWER(mui_showAlertWithError)
    #define mui_showAlertWithMessage __MUIKIT_NAMESPACE_APPLY_LOWER(mui_showAlertWithMessage)
    #define mui_showAlertWithTitle __MUIKIT_NAMESPACE_APPLY_LOWER(mui_showAlertWithTitle)
    #define mui_transitionSlide __MUIKIT_NAMESPACE_APPLY_LOWER(mui_transitionSlide)
    #define mui_viewDidDisappear __MUIKIT_NAMESPACE_APPLY_LOWER(mui_viewDidDisappear)
// Externs
#endif
