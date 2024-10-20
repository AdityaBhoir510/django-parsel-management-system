from django.contrib import admin
from .models import *

# Register your models here.
class contactadmin(admin.ModelAdmin):
    list_display = ("name","date","time")
    
class shipmentadmin(admin.ModelAdmin):
    list_display = ("shipment_id",'sender_id',"cost",'completed')
    
admin.site.register(contact_query,contactadmin)
admin.site.register(business_query)
admin.site.register(userProfile)
admin.site.register(dealer_request)
admin.site.register(dealer)
admin.site.register(order_shipment,shipmentadmin)
admin.site.register(employee)