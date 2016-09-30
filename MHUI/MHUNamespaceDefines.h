//
//  MHUNamespaceDefines.h
//  MHUI
//
//  Generated using MHNamespaceGenerator on 30/09/2016
//

#if !defined(__MHUI_NS_SYMBOL) && defined(MHUI_NAMESPACE)
    #define __MHUI_NS_REWRITE(ns, symbol) ns ## _ ## symbol
    #define __MHUI_NS_BRIDGE(ns, symbol) __MHUI_NS_REWRITE(ns, symbol)
    #define __MHUI_NS_SYMBOL(symbol) __MHUI_NS_BRIDGE(MHUI_NAMESPACE, symbol)
// Classes
    #define MHUAuthViewController __MHUI_NS_SYMBOL(MHUAuthViewController)
    #define MHUDictionaryViewController __MHUI_NS_SYMBOL(MHUDictionaryViewController)
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
    #define mhu_transitionSlide __MHUI_NS_SYMBOL(mhu_transitionSlide)
    #define mhu_viewDidDisappear __MHUI_NS_SYMBOL(mhu_viewDidDisappear)
// Externs
    #define MHUAuthLogInSegueIdentifier __MHUI_NS_SYMBOL(MHUAuthLogInSegueIdentifier)
    #define MHUAuthSignUpSegueIdentifier __MHUI_NS_SYMBOL(MHUAuthSignUpSegueIdentifier)
    #define MHUIVersionNumber __MHUI_NS_SYMBOL(MHUIVersionNumber)
    #define MHUIVersionString __MHUI_NS_SYMBOL(MHUIVersionString)
#endif
