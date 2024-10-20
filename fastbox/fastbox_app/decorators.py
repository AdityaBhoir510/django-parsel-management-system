from django.http import HttpResponse
from django.shortcuts import redirect

def unauthenticated_user(view_func):
    def wrapper_func(request, *args, **kwargs):
        if request.user.is_authenticated:
            return redirect('home')
        else:
            return view_func(request, *args, **kwargs)
    return wrapper_func

def unauthenticated_dealer(view_func):
    def wrapper_func(request, *args, **kwargs):
        if request.user.is_authenticated:
            return redirect('dashboard')
        else:
            return view_func(request, *args, **kwargs)
    return wrapper_func

def allowed_user(allowed_roles=[]):    
    def deco_name(view_func):
        def wrapper_func(request,*args,**kwargs):
            group = None
            print("permission:",allowed_roles)

            if request.user.groups.exists():
                group = request.user.groups.all()[0].name
                print("group:",group)
            
                if group in allowed_roles:
                    print("allowed group:",group)
                    return view_func(request,*args,**kwargs)
                else:
                    return redirect('error404')
                
            else:
                return redirect('error404')
        return wrapper_func
    return deco_name