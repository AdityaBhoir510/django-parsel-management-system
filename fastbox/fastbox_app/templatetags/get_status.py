from django import template

register= template.Library()

@register.filter
def get_status(code,dict):
    return dict.get(code,"unknown")