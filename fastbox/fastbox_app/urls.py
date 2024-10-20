"""
URL configuration for fastbox project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', views.Home, name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# from django.conf.urls import url
from django.urls import path
from fastbox_app import views
from fastbox_app.views import *
# from django.contrib.auth import views as auth_views


urlpatterns = [
    # url(r'^password/$', views.change_password, name='change_password'),
    # ------------------- PSW -------------------------
    # path('password_change/', auth_views.PasswordChangeView.as_view(template_name='registration/password_change.html'), name='password_change'),
    # path('password_change/done/', auth_views.PasswordChangeDoneView.as_view(template_name='registration/password_change_done.html'), name='password_change_done'),
    # ------------------- TEST -------------------------
    path("test",views.test,name='test'),
    # ------------------- HOME -------------------------
    path("",views.home,name='home'),
    # ------------------- HEADER CONTENT -------------------------
    path("about",views.about,name='about'),
    path("contact",views.contact,name='contact'),
    # ------------------- FOOTER CONTENT -------------------------
    path("terms",views.terms,name='terms'),
    path("privacy",views.privacy,name='privacy'),
    path("service",views.service,name='service'),
    # ------------------- LOGIN -------------------------
    path("login/",views.user_login,name='login'),
    path("register",views.user_register,name='register'),
    path("dealerLogin",views.dealerLogin,name='dealerLogin'),
    # ------------------- FORMS -------------------------
    path("dealerForm",views.dealerForm,name='dealerForm'),
    path("businessForm",views.businessForm,name='businessForm'),
    # ------------------- DASHBOARD CONTENT -------------------------
    # *****comman****
    path("resetpsw",views.resetuser,name='resetuserpsw'),
    path("dashboard",views.dashboard,name='dashboard'),
    path("logout",views.user_logout,name='logout'),
    path("profile",views.profile,name='profile'),
    # *****admin****
    path("ownerlogin",views.ownerLogin,name='ownerLogin'),
    path("dealerRequest",views.dealerRequest,name='dealerRequest'),
    path("businessQuery",views.businessQuery,name='businessQuery'),
    path("contactQuery",views.contactQuery,name='contactQuery'),
    path("dealerManagement",views.dealerManagement,name='dealerManagement'),
    path("addD/<did>",views.addD,name='addD'),
    path("deleteD/<did>",views.deleteD,name='deleteD'),
    # *****dealer****
    path("dealersorder",views.dealersorder,name='dealersorder'),
    path("dealerhistory",views.dealerhistory,name='dealerhistory'),
    path("manageEmp",views.manageEmp,name='manageEmp'),
    # *****customer****
    path("updatestatus/<oid>",views.updatestatus,name='updatestatus'),
    # path("dealerdash",views.dealer_dash,name='dealerDash'),
    path("makeShipment",views.makeShipment,name='makeShipment'),
    path("paymentgateway",views.paymentgateway,name='paymentgateway'),
    path("trackPackage",views.trackPackage,name='trackPackage'),
    path("shipmentHistory",views.shipmentHistory,name='shipmentHistory'),
    # ------------------- ADMIN -------------------------
    path("pagenotfound",views.pagenotfound,name='error404'),
    # path("manageD/<did>",views.manageDealer,name='managedealer')
]