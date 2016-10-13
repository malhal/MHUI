//
//  MHUNamespaceDefines.h
//  MHUI
//
//  Generated using MHNamespaceGenerator on 13/10/2016
//

#if !defined(__MHUI_NS_SYMBOL) && defined(MHUI_NAMESPACE)
    #define __MHUI_NS_REWRITE(ns, symbol) ns ## _ ## symbol
    #define __MHUI_NS_BRIDGE(ns, symbol) __MHUI_NS_REWRITE(ns, symbol)
    #define __MHUI_NS_SYMBOL(symbol) __MHUI_NS_BRIDGE(MHUI_NAMESPACE, symbol)
// Classes
    #define MHUAccountViewController __MHUI_NS_SYMBOL(MHUAccountViewController)
    #define MHUDictionaryViewController __MHUI_NS_SYMBOL(MHUDictionaryViewController)
    #define MHUEditableTableCell __MHUI_NS_SYMBOL(MHUEditableTableCell)
    #define MHUFlipController __MHUI_NS_SYMBOL(MHUFlipController)
    #define MHULogInViewController __MHUI_NS_SYMBOL(MHULogInViewController)
    #define MHUSignUpViewController __MHUI_NS_SYMBOL(MHUSignUpViewController)
// Categories
    #define mhu_alertControllerWithTitle __MHUI_NS_SYMBOL(mhu_alertControllerWithTitle)
    #define mhu_alertWindow __MHUI_NS_SYMBOL(mhu_alertWindow)
    #define mhu_createBlurredBackgroundView __MHUI_NS_SYMBOL(mhu_createBlurredBackgroundView)
    #define mhu_loading __MHUI_NS_SYMBOL(mhu_loading)
    #define mhu_progressView __MHUI_NS_SYMBOL(mhu_progressView)
    #define mhu_setAlertWindow __MHUI_NS_SYMBOL(mhu_setAlertWindow)
    #define mhu_setHidden __MHUI_NS_SYMBOL(mhu_setHidden)
    #define mhu_setLoading __MHUI_NS_SYMBOL(mhu_setLoading)
    #define mhu_show __MHUI_NS_SYMBOL(mhu_show)
    #define mhu_showAlertWithError __MHUI_NS_SYMBOL(mhu_showAlertWithError)
    #define mhu_showAlertWithMessage __MHUI_NS_SYMBOL(mhu_showAlertWithMessage)
    #define mhu_showAlertWithTitle __MHUI_NS_SYMBOL(mhu_showAlertWithTitle)
    #define mhu_transitionSlide __MHUI_NS_SYMBOL(mhu_transitionSlide)
    #define mhu_viewDidDisappear __MHUI_NS_SYMBOL(mhu_viewDidDisappear)
// Externs
#endif
