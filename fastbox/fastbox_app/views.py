# ---------- IMPORTS -------------
import json
import random
from django.shortcuts import render,HttpResponse,redirect
# from django.views import View
from django.db.models import Q 
from django.db.models import Sum
from .models import *
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.decorators import login_required
from .decorators import *
import datetime
from django.core.files.storage import FileSystemStorage
from .forms import *
import razorpay
import requests
# ----password change
from django.contrib import messages
from django.contrib.auth import update_session_auth_hash
#--------------------mail ------------
from django.core.mail import send_mail
from django.conf import settings

from django.views.decorators.csrf import csrf_exempt
# Create your views here.
headers = { 
  "apikey": "ffd51640-b7a0-11ee-8892-c79b591bd9ed"}



# ------------------- TEST -------------------------
#.......test page for code testing.....
def test(request):
    return render(request,'test.html')
    
# ------------------- HOME -------------------------
# ...main pages start here.......
# @allowed_user(allowed_roles=['customer'])
def home(request):
    context = {}
    userid=request.user.id
    usern=request.user.username
    c = Group.objects.get(name='customer')
    uc = c.user_set.count()
    d = Group.objects.get(name='dealer')
    dc = d.user_set.count()
    o = Group.objects.get(name='owner')
    oc = o.user_set.count()
    wc =uc+oc
    sc = order_shipment.objects.all().count()
    # g = request.user.groups.name
    context['user_count'] = uc
    context['dealer_count'] = dc
    context['worker_count'] = wc
    context['shipment_count'] = sc
    if request.method == "POST":
        if 'zipcode' in request.POST:
            try:
                zd = dealer.objects.filter(pincode=request.POST['zipcity'])
            except:
                zd = dealer.objects.filter(city=request.POST['zipcity'])
            if not zd:
                context['nozipcodes']="zd"
                print("no query")
            print(zd)
            context['zipcodes']=zd
            
            
        if 'trackPackage' in request.POST:
            status = {
                'start':0,
                'assigned':0,
                'pickup':5,
                'at sender office':20,
                'onboard':43,
                'at receiver office':65,
                'deliver':90,
                'end':90,
            }
            id = request.POST['trackid']
            try:
                o = order_shipment.objects.get(shipment_id=id)
                st = status[o.shipment_status]
                print(st)
                context['trackPackage']=o
                context['status']=st
                print(id)
            except:
                context['trackPackage']="a"
                context['errmsg']='Invalid Order Id...'
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    # context['group'] = g
    print("result : ",request.user.is_authenticated)
    print("user logged in: ",userid,usern)
    return render(request,'index.html',context)

# ------------------- HEADER CONTENT -------------------------

def about(request):
    context = {}
    userid=request.user.id
    usern=request.user.username
    c = Group.objects.get(name='customer')
    uc = c.user_set.count()
    d = Group.objects.get(name='dealer')
    dc = d.user_set.count()
    o = Group.objects.get(name='owner')
    oc = o.user_set.count()
    wc =uc+oc
    sc = order_shipment.objects.all().count()
    # g = request.user.groups.name
    t = User.objects.filter(is_superuser=0).count()
    context['dealer_count'] = dc
    context['worker_count'] = wc
    context['user_count'] = t
    return render(request,'about.html',context)

def contact(request):
    context = {}
    if request.method=='POST':
        name = request.POST['name']
        email = request.POST['email']
        subject = request.POST['subject']
        message = request.POST['message']
        date = datetime.datetime.now()
        # print(name,email,subject,message)
        q = contact_query.objects.create(name=name,email=email,subject=subject,message=message,date=date,time=date)
        q.save()
        context = {}
        context['msg'] = "Your message has been sent. Thank you!"
        return render(request,'contact.html',context)
    
    return render(request,'contact.html',context)
# ------------------- FOOTER CONTENT -------------------------

def service(request):
    return render(request,'services.html')

# =====terms===
def terms(request):
    return render(request,'termsConditions.html')

# =====privacy===
# @allowed_user(allowed_roles=['dealer'])
def privacy(request):
    return render(request,'privacy.html')

# ------------------- LOGIN -------------------------

def user_register(request):
    if request.method=='POST': 
        uname = request.POST['uname']
        email = request.POST['email']
        psw = request.POST['psw']
        cpsw = request.POST['cpsw']
        context = {}
        if psw == cpsw:
            try:
                u = User.objects.create_user(username=uname,password=psw,email=email)
                u.save()
                # s= u.save()
                group = Group.objects.get(name='customer')
                # print(group)
                u.groups.add(group)
            except:
                context['errmsg']="user with same username already present.."
                return render(request,'register.html',context) 
            else:
                context['success_msg'] = "Your account has been created"
                return render(request,"register.html",context)
        else:
            context['errmsg'] = "The Password Does not match to confirm password..."
            return render(request,'register.html',context)
    
    return render(request,'register.html')

@unauthenticated_user
def user_login(request):
    if request.method=='POST': 
        uname = request.POST['uname']
        psw = request.POST['psw']
        context = {}
        u = authenticate(username=uname,password=psw)  # matching the data in database
        # try:
        if u is not None:
            if u.groups.all()[0].name == 'customer':      #check if the person is customer group
                login(request,u)  
                print(User.objects.all().filter(username=uname).exists()) # check if person exist in database
                return redirect('home')
            else:
                context['errmsg']="No user found..., Register first."    
                return render(request,'login.html',context)
        else:  # not exist
            if User.objects.all().filter(username=uname).exists(): # username is correct but not psw
                print(User.objects.all().filter(username=uname).exists())
                context['errmsg']="Invalid username and password.."    
                return render(request,'login.html',context)
            else: # no user found
                print("user not found")
                context['errmsg']="No user found..., Register first."    
                return render(request,'login.html',context)
            
            
    return render(request,'login.html')

@unauthenticated_dealer
def dealerLogin(request):
    if request.method=='POST':
        duname = request.POST['uname']
        dpsw = request.POST['psw']
        print(duname,dpsw)
        context = {}
        u = authenticate(username=duname,password=dpsw)
        if u is not None:
            if u.groups.all()[0].name == 'dealer':      #check if the person is dealer group
                login(request,u)
                print(User.objects.all().filter(username=duname).exists())
                #----first dealer---
                fd = User.objects.get(id=request.user.id)
                print("first login: ",fd.last_login,fd.username,fd.password)
                return redirect('dashboard')
            else:
                context['errmsg']="No user found...,Request for registration first..."    
                return render(request,'dealerLogin.html',context)
        else:
            if User.objects.all().filter(username=duname).exists():
                print(User.objects.all().filter(username=duname).exists())
                context['errmsg']="Invalid username and password.."    
                return render(request,'dealerLogin.html',context)
            else:
                print("user not found")
                context['errmsg']="No user found..., Request for registration..."    
                return render(request,'dealerLogin.html',context)
            
    return render(request,'dealerLogin.html')

@unauthenticated_dealer
def ownerLogin(request):
    if request.method=='POST':
        duname = request.POST['uname']
        dpsw = request.POST['psw']
        print(duname,dpsw)
        context = {}
        u = authenticate(username=duname,password=dpsw)
        if u is not None:
            if u.groups.all()[0].name == 'owner':      #check if the person is dealer group
                login(request,u)
                print(User.objects.all().filter(username=duname).exists())
                return redirect('dashboard')
            else:
                context['errmsg']="No Owner with this username found..."    
                return render(request,'ownerLogin.html',context)
        else:
            if User.objects.all().filter(username=duname).exists():
                print(User.objects.all().filter(username=duname).exists())
                context['errmsg']="Invalid username and password.."    
                return render(request,'ownerLogin.html',context)
            else:
                print("user not found")
                context['errmsg']="No Owner with this username found..."    
                return render(request,'ownerLogin.html',context)
            
    return render(request,'ownerLogin.html')

# ------------------- FORMS -------------------------

def dealerForm(request):
    if request.method == 'POST':
        context = {}
        firstname = request.POST['fname'] 
        lastname = request.POST['lname'] 
        companyname = request.POST['cname'] 
        add_line_1 = request.POST['streetadd'] 
        add_line_2 = request.POST['streetadd2'] 
        city = request.POST['city'] 
        postalcode = request.POST['postalcode']
        country = request.POST['country'] 
        ph_no = request.POST['phone']
        email = request.POST['email']
        wh_city = request.POST['wh_city'] 
        wh_area = request.POST['wh_area'] 
        wh_country = request.POST['wh_country'] 
        wh_tenure = request.POST['status']
        date = datetime.datetime.now()
        print(firstname,lastname,companyname,add_line_1,add_line_2,city,postalcode,country,ph_no,email,wh_area,wh_city,wh_country,wh_tenure,date)
        if firstname=="" or lastname=="" or companyname=="" or add_line_1=="" or add_line_2=="" or postalcode=="" or country=="" or city=="" or email=="" or ph_no==""or wh_area==""or wh_city==""or wh_country=="" or wh_tenure=="":
            context['errmsg'] = 'Please fill up all fields in form'
            return render(request,'dealerForm.html',context)
        else:
            dr = dealer_request.objects.create(firstname=firstname,lastname=lastname,companyname=companyname,add_line_1=add_line_1,add_line_2=add_line_2,city=city,postalcode=postalcode,country=country,ph_no=ph_no,email=email,wh_area=wh_area,wh_city=wh_city,wh_country=wh_country,wh_tenure=wh_tenure,date=date)
            dr.save()
            print("data saved...")
            context['msg'] = 'Your form has been submitted, we will contact you ASAP...'
            return render(request,'dealerForm.html',context)
    return render(request,'dealerForm.html')

def businessForm(request):
    if request.method=='POST': 
        cname = request.POST['cname']
        cperson = request.POST['cperson']
        streetadd = request.POST['streetadd']
        streetadd2 = request.POST['streetadd2']
        city = request.POST['city']
        postalcode = request.POST['postalcode']
        country = request.POST['country']
        phone = request.POST['phone']
        email = request.POST['email']
        details = request.POST['details']
        date=datetime.datetime.now()
        context = {}
        if cname=="" or cperson=="" or streetadd=="" or streetadd2=="" or city=="" or postalcode=="" or country=="" or phone=="" or email=="" or details=="":
            context['errmsg'] = 'Please fill up all fields in form'
            return render(request,'businessForm.html',context)
        else:
            try:
                b = business_query.objects.create(company_name=cname,contact_person=cperson,street_address=streetadd,street_address_line_2=streetadd2,city=city,postal_code=postalcode,country=country,ph_no=phone,email=email,details=details,date=date)
                b.save()
                print("data saved...")
            except:
                context['errmsg'] = 'Something went wrong, PLease try later.'
                return render(request,'businessForm.html',context)
            
            context['msg'] = 'Your form has been submitted, we will contact you ASAP...'
            # print(cname,cperson,streetadd,streetadd2,city,postalcode,country,phone,email,details)
            return render(request,'businessForm.html',context)

    return render(request,'businessForm.html')
# ------------------- DASHBOARD CONTENT -------------------------

#----------DASH COMMAN----------
def user_logout(request):
    logout(request)
    return redirect('home')

@login_required(login_url='login')
# @allowed_user(allowed_roles=['customer','dealer','owner'])
def dashboard(request):
    context={}
    time = datetime.datetime.now()
    context['time']= time
    c = Group.objects.get(name='customer')
    uc = c.user_set.count()
    context['user_count']=uc
    d = Group.objects.get(name='dealer')
    dc = d.user_set.count()
    context['dealer_count']=dc
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    qd1 = Q(completed=0)
    print('current login',request.user.id)
    if "dealer" in current_user_groups:
        rqdealer = dealer.objects.get(dealer_id=request.user.id)
        print('req dealer: ',rqdealer)
        context['rqdealer']=rqdealer
        qd2 = Q(r_dealer_id=rqdealer)
        qp = Q(shipment_status="pickup")
        qaa = Q(shipment_status='assigned')
        qd4 = ~Q(shipment_status='start')
        qb = Q(shipment_status="at sender office")
        qd3 = Q(shipment_status="at receiver office")
        que = Q(shipment_status="deliver")
        quo = Q(shipment_status="onboard")
        o = order_shipment.objects.filter(qd2 & qd1 & (qd3 | que))
        if order_shipment.objects.filter(r_dealer_id=rqdealer):
            print("in if state")
            o = order_shipment.objects.filter(qd2 & qd1 & (quo | qp | qb | qaa) & qd4)
        print(o)
        context['upcomingorder'] = o
        #---- employee--
        e = employee.objects.filter(dealer_id=rqdealer)
        context['employee']=e
        # ---
        print('request dealer:',rqdealer)
        qa2 = Q(s_dealer_id=rqdealer)
        qa3 = Q(r_dealer_id=rqdealer)
        # qa = ~Q(shipment_status='start')
        qae = ~Q(shipment_status='end')
        mot = ~Q(mot=None)
        Nmot = Q(mot=None)
        qnr = ~Q(shipment_status="at receiver office")
        qnd = ~Q(shipment_status="deliver")
        qbe = Q(shipment_status="deliver")
        print("Q",order_shipment.objects.filter(s_dealer_id=rqdealer))
        
        # ao = order_shipment.objects.filter(qa2 & (quo | qb | qaa | qp) & qd4 & qnr & qnd & qae)
        ao = order_shipment.objects.filter(((qa2) | (qa3 & Nmot & ~(qaa | qb | quo))) & qd4 & qae)
        if ao.exists():
            print("it exist")
        else:
            ao = order_shipment.objects.filter(qa3 & (qd3 | qbe) & qd4)
            print("receiverorder",ao)
                
        # try:
        #     ao = order_shipment.objects.filter(qa2 & (quo | qb | qaa | qp) & qd4 & qnr & qnd & qae)
        # except:
        #     ao = order_shipment.objects.filter(qa3 & (qd3 | qbe) & qd4)
        #     print("receiverorder",ao)
        print("id: ",rqdealer.id)
        print("acc order: ",ao)
        context['currentorder']=ao
        #----new order--
        q1 = Q(completed=0)
        q3 = Q(shipment_status='start')
        print(request.user.id)
        sdealer = dealer.objects.get(dealer_id=request.user.id)
        q22 = Q(s_dealer_id=sdealer)
        q23 = Q(r_dealer_id=sdealer)
        o = order_shipment.objects.filter(qd1 & q22 & q3).count()
        u = order_shipment.objects.filter(qd1 & q23 & quo).count()
        print("count",o)
        context['ocount'] = o
        context['ucount'] = u
        if request.method == "POST":
            if 'mode' in request.POST:
                est = request.POST['est']
                mode = request.POST['mot']
                orderid = request.POST['orderid']
                date = order_shipment.objects.get(id=orderid).date
                print(type(est))
                e_date = date + datetime.timedelta(hours=int(est)+24)
                print(mode,est,orderid,date,e_date)
                # status='onboard'
                os = order_shipment.objects.filter(id=orderid)
                os.update(id=orderid,e_date=e_date,mot=mode,shipment_status="onboard")
                
    #---
    q1 =Q(sender_id=request.user.id)
    q2 =Q(completed=1)
    q3 =Q(completed=0)
    #---progress
    status = {
        'start':0,
        'assigned':0,
        'pickup':5,
        'at sender office':20,
        'onboard':43,
        'at receiver office':65,
        'deliver':90,
    }
    try:
        s = order_shipment.objects.filter(q1 & q3)
        # s = order_shipment.objects.all()
        context['active']= s
        context['status']=status
        # for x in s:
        #     st = status[x.shipment_status]
        #     context['statusname']=x.shipment_status
        #     context['status']=st
        print(context['status'])
    except:
        print("no order")
    ps = order_shipment.objects.filter(q1 & q2)
    context['orders']= ps
    # print(s.shipment_status)
    #-----counts--
    rcount = dealer_request.objects.all().count()
    context['rcount']=rcount
    print("group: ",request.user.groups.all())
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    amt = order_shipment.objects.aggregate(Sum('cost'))
    context['cost']=amt['cost__sum']
    return render(request,'dashboard.html',context)

@login_required(login_url='login')
# @allowed_user(allowed_roles=['customer'])
def profile(request):
    context={}
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    # imgform = pictureUpload()
    # context['imgform']= imgform 
    # try:
    #     c = userProfile.objects.get(user_id=request.user.id)
    #     context['userProfile']=c
    # except:
    #     print("new user")
    try:
        sdealer = dealer.objects.get(dealer_id=request.user.id) 
        qd1 = Q(completed=0)
        q22 = Q(s_dealer_id=sdealer)
        q3 = Q(shipment_status='start')
        o = order_shipment.objects.filter(qd1 & q22 & q3).count()
        print("count",o)
        context['ocount'] = o
    except:
        print("count 0")
        
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print("old profile picture:",type(u.picture))
        print("old profile picture:",u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
        #----------old change psw-----------
    # form = PasswordChangeForm(request.user)
    # context['form']=form
    if request.method =="POST":
        if "changepsw" in request.POST:
            current_password = request.POST['current_password']
            new_password = request.POST['new_password']
            u = request.user
            if u.check_password(current_password):
                u.set_password(new_password)
                u.save()
                update_session_auth_hash(request, u)  # Important!
                messages.success(request, 'Your password was successfully updated!')
                return redirect('profile')
            else:
                messages.error(request, 'Please correct the error below.')
                        
        # name = request.POST['formname']
        if "edit_profile" in request.POST:
            # print("form :",name)  
            firstname = request.POST['firstname']
            lastname = request.POST['lastname']
            country = request.POST['country']
            address = request.POST['address']
            phone = None
            if request.POST['phone'] != "":
                phone = int(request.POST['phone'])
            email = request.POST['email']
            #------------ uplaod file code
            # pimage = pictureUpload(request.POST,request.FILES)
            pimage = request.FILES.get('pimage',None)
            # if pimage == None:
            #     pimage = u.picture    
            # pimage = request.FILES['pimage']
            # try:
            #     pimage = request.FILES['pimage']
            # except:
            #     print("no file found")
            # else:
            #     pimage = u.picture
            fss = FileSystemStorage()
            if pimage:
                image = fss.save(pimage.name,pimage)
                image_url = fss.url(image)
                print("image upload:",image)
                print("image upload:",image_url)
            elif u.picture != "media/images/person-circle.svg":
                # image_url = fss.url(u.picture)
                image_url = u.picture
                print("profile image changed")
            else:
                print("user image:",image_url)
            print("profile image:",pimage)
            # context['image_url']=image_url
            # print(pimage)
            # print(firstname,lastname,country,address,phone,email)
            # u = User.objects.get(id=request.user.id)
            User.objects.filter(id=request.user.id).update(first_name=firstname,last_name=lastname,email=email)
            try:
                userProfile.objects.filter(user_id=request.user.id).update(country=country,address=address,ph_no=phone,picture=image_url)
            except userProfile.DoesNotExist:
                print('no user found creating one...')
            else:
                try:
                    p = userProfile.objects.create(user_id=request.user.id,country=country,address=address,ph_no=phone,picture=image_url)
                    p.save()
                    print("user created")
                except:
                    print('error: ',Exception)
                
            # print('userid :',u.id)
            
            # print(firstname,lastname,)    
        # if name == 'changepsw':
        #     print("form :",name)       
    return render(request,'profile.html',context)

#----------DASH ADMN----------
@login_required(login_url='login')
@allowed_user(allowed_roles=['owner'])
def dealerRequest(request):
    context = {}
    r = dealer_request.objects.all()
    print("last dealer:",User.objects.last().username)
    context['request']=r
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    rcount = dealer_request.objects.all().count()
    context['rcount']=rcount
    #----
    print("group: ",request.user.groups.all())
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,'dealerRequest.html',context)


@login_required(login_url='login')
@allowed_user(allowed_roles=['owner'])
def addD(request,did):
    context = {}
    r = dealer_request.objects.all()
    context['request']=r
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    try: # false
        remail = dealer_request.objects.get(id=did).email
        print(remail)
        if User.objects.get(email=remail): # true
            # d = User.objects.get(email=remail)
            print("dealer selected:",User.objects.get(email=remail))
        else:
            context['errmsg'] = "Dealer already exists... Maybe form was re-submitted."      
    except: # true
        dr = dealer_request.objects.filter(id=did)[0]
        context['msg'] = "The Dealer has been added..."
        date = datetime.datetime.now()
        send_welcome_email(dr.email,dr.firstname)
        #---new user
        ugd= User.objects.create_user(username=dr.firstname,password=dr.firstname,email=dr.email)
        ugd.save()
        print(User.objects.all())
        nd = User.objects.last()
        #-----new dealer
        cd = dealer.objects.create(firstname=dr.firstname,lastname=dr.lastname,city=dr.city,pincode=dr.postalcode,country=dr.country,email=dr.email,phone=dr.ph_no,add_line_1=dr.add_line_1,add_line_2=dr.add_line_2,jdate=date,dealer_id=nd)    
        cd.save()
        group = Group.objects.get(name='dealer')
        # print(group)
        ugd.groups.add(group)
        print(dr)
        dr.delete()
    else: # else for false
        context['errmsg'] = "Dealer already exists... Maybe form was re-submitted."   
        return render(request,'dealerRequest.html',context)
        
    # print(d)
    # context['errmsg'] = "Request has been deleted..."    
    return render(request,'dealerRequest.html',context)

#------------send email ----------------
def send_welcome_email(email,cred):
    subject = 'Welcome to FastBox Family'
    message = f'''
    Welcome to the team
        
    You are Officially a Partner dealer of FastBox.
    
    this Email is for your login credientials
    
    Id : {cred}
    Password : {cred}
    '''
    recipient_list = [email]
    
    send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, recipient_list)

@login_required(login_url='login')
@allowed_user(allowed_roles=['owner'])
def deleteD(request,did):
    context = {}
    r = dealer_request.objects.all()
    context['request']=r
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    try: # false
        dr = dealer_request.objects.get(id=did)
        context['msg'] = "The Dealer has been deleted..."
        print(dr)
        dr.delete()
    except: # true
        print("cannot delete")
        context['errmsg'] = "Request already deleted..."   
        return render(request,'dealerRequest.html',context)
        
    # print(d)
    # context['errmsg'] = "Request has been deleted..."    
    return render(request,'dealerRequest.html',context)

@login_required(login_url='login')
@allowed_user(allowed_roles=['owner'])
def dealerManagement(request):
    context = {}
    r = dealer_request.objects.all()
    context['request']=r
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end--- 
    rcount = dealer_request.objects.all().count()
    context['rcount']=rcount
    #------ delete requests ---
    if 'delete_D' in request.POST:
        did = request.POST['did']
        dr = dealer.objects.get(id=did)
        duid = dr.dealer_id
        # tryid = User.objects.get(username=dr.dealer_id).id
        try: # false
            dr = dealer.objects.get(id=did)
            print(dr)
            uid = User.objects.get(username=dr.dealer_id)
            print("UID",uid)
            uid.delete()
            context['msg'] = "The Dealer has been deleted..."
        except Exception: # true
            print("cannot delete")
            print(Exception)
            context['errmsg'] = "Dealer already deleted..."   
            return render(request,'dealerManagement.html',context)
        print("Dealer Delete:",did)
        print("Dealer userid:",duid)
        # print("USer:",tryid)
    
    #----
    print("group: ",request.user.groups.all())
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    d = dealer.objects.all()
    context['dealer']=d
    return render(request,'dealerManagement.html',context)

@login_required(login_url='login')
@allowed_user(allowed_roles=['owner'])
def businessQuery(request):
    context = {}
    q = business_query.objects.all()
    context['querys'] = q
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    rcount = dealer_request.objects.all().count()
    context['rcount']=rcount
    #----
    print("group: ",request.user.groups.all())
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,'businessQuery.html',context)

@login_required(login_url='login')
@allowed_user(allowed_roles=['owner'])
def contactQuery(request):
    context = {}
    q = contact_query.objects.all()
    context['querys'] = q
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    print("group: ",request.user.groups.all())
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,'contactQuery.html',context)

#----------DASH DEALER----------
@login_required(login_url='login')
@allowed_user(allowed_roles=['dealer'])
def dealerhistory(request):
    context={}
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    sdealer = dealer.objects.get(dealer_id=request.user.id)
    q1 =Q(s_dealer_id=sdealer)
    q4 =Q(r_dealer_id=sdealer)
    print(q1)
    q2 =Q(completed=1)
    ps = order_shipment.objects.filter(q2 & (q1 | q4))
    context['completeorder']= ps
    qd1 = Q(completed=0)
    q22 = Q(s_dealer_id=sdealer)
    q3 = Q(shipment_status='start')
    o = order_shipment.objects.filter(qd1 & q22 & q3).count()
    print("count",o)
    context['ocount'] = o
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,"dealerhistory.html",context)


@login_required(login_url='login')
@allowed_user(allowed_roles=['dealer'])
def manageEmp(request):
    context={}
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    de = employee.objects.filter(dealer_id=dealer.objects.get(dealer_id=request.user.id))
    context['employee']=de
    sdealer = dealer.objects.get(dealer_id=request.user.id)
    #----
    if request.method=="POST":
        fname=request.POST['fname']
        lname=request.POST['lname']
        email=request.POST['email']
        phone=request.POST['phone']
        print(fname,lname,email,phone)
        e = employee.objects.create(firstname=fname,lastname=lname,e_email=email,e_phone=phone,dealer_id=sdealer)
        e.save()
        context['msg']="Employee added successfully"
        
    q1 =Q(s_dealer_id=sdealer)
    print(q1)
    q2 =Q(completed=1)
    ps = order_shipment.objects.filter(q2 & q1)
    context['completeorder']= ps
    qd1 = Q(completed=0)
    q22 = Q(s_dealer_id=sdealer)
    q3 = Q(shipment_status='start')
    o = order_shipment.objects.filter(qd1 & q22 & q3).count()
    print("count",o)
    context['ocount'] = o
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,"dealerEmp.html",context)

@login_required(login_url='login')
@allowed_user(allowed_roles=['dealer'])
def dealersorder(request):
    context = {}
    #----new order--
    q1 = Q(completed=0)
    q3 = Q(shipment_status='start')
    print(request.user.id)
    sdealer = dealer.objects.get(dealer_id=request.user.id)
    q2 = Q(s_dealer_id=sdealer)
    print(q2)
    o = order_shipment.objects.filter(q1 & q2 & q3)
    context['dealerorder'] = o
    qd1 = Q(completed=0)
    q22 = Q(s_dealer_id=sdealer)
    o = order_shipment.objects.filter(qd1 & q22 & q3).count()
    print("count",o)
    context['ocount'] = o
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    if 'acceptorder' in request.POST:
        oid = request.POST['orderid'] 
        emp = request.POST['pickupguy']
        days = request.POST['days']
        print(days)
        ao = order_shipment.objects.filter(id=oid)
        o = order_shipment.objects.get(id=oid)
        e = employee.objects.filter(id=emp)
        od = o.date
        print(od)
        if days == 'Today':
            sd = datetime.datetime.now()
            print(sd)
        elif days == 'Tomorrow':
            sd = od + datetime.timedelta(days=1)
            print(sd)
        elif days == '2 day':
            sd = od + datetime.timedelta(days=2)
            print(sd)
        elif days == '3 day':
            sd = od + datetime.timedelta(days=3)
            print(sd)
            
        ao.update(id=oid,shipment_status="assigned",e_date=sd)
        e.update(id=emp,assigned_order=oid)
        # ao.update(id=oid,shipment_status="assigned")
        print(ao,emp)
        # return redirect('dashboard',msg="The order has been excepted. employee has been informed,the order will wbe picked up soon")
        context["msg"]="The order has been excepted. employee has been informed,the order will wbe picked up soon"
    #---- employee--
    e = employee.objects.filter(dealer_id=sdealer)
    context['employee']=e
    print("group: ",request.user.groups.all())
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,"dealersorder.html",context)

#----------DASH CUSTOMER----------
def updatestatus(request,oid):
    o = order_shipment.objects.filter(id=oid)
    if o[0].shipment_status=="assigned":
        o.update(id=oid,shipment_status="pickup")
    elif o[0].shipment_status=="pickup":
        o.update(id=oid,shipment_status="at sender office")
    elif o[0].shipment_status=="at sender office":
        o.update(id=oid,shipment_status="onboard")
    elif o[0].shipment_status=="onboard":
        o.update(id=oid,shipment_status="at receiver office")
    elif o[0].shipment_status=="at receiver office":
        o.update(id=oid,shipment_status="deliver")
    else:
        o.update(id=oid,shipment_status="end",completed=1)
    return redirect('dashboard')

@login_required(login_url='login')
@allowed_user(allowed_roles=['customer'])
def makeShipment(request):
    pricekm =10
    addprice =120
    context={}
    context['pricekm']=pricekm
    request.session['addprice'] = addprice
    context['addprice']=request.session.get('addprice')
    context['weight']= request.session.get('packageWeight')
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    if "shipment_info" in request.POST:
        # formname = request.POST['formname']:
        #---------sender--------
        senderName = request.POST['senderName']
        senderAddress_add = request.POST['senderAddress_add']
        senderAddress_zip = request.POST['senderAddress_zip']
        senderAddress_city = request.POST['senderAddress_city']
        senderAddress_country = request.POST['senderAddress_country']
        senderAddress_phone = request.POST['senderAddress_phone']
        request.session['senderAddress_zip'] = senderAddress_zip
        request.session['senderName'] = senderName
        request.session['senderAddress_add'] = senderAddress_add
        request.session['senderAddress_city'] = senderAddress_city
        request.session['senderAddress_country'] = senderAddress_country
        request.session['senderAddress_phone'] = senderAddress_phone
        # ---recipent
        recipientName = request.POST['recipientName']
        recipientAddress_add = request.POST['recipientAddress_add']
        recipientAddress_zip = request.POST['recipientAddress_zip']
        recipientAddress_city = request.POST['recipientAddress_city']
        recipientAddress_country = request.POST['recipientAddress_country']
        recipientAddress_phone = request.POST['recipientAddress_phone']
        request.session['recipientName'] = recipientName
        request.session['recipientAddress_add'] = recipientAddress_add
        request.session['recipientAddress_zip'] = recipientAddress_zip
        request.session['recipientAddress_country'] = recipientAddress_country
        request.session['recipientAddress_city'] = recipientAddress_city
        request.session['recipientAddress_phone'] = recipientAddress_phone
        # ---end
        shipmentType = request.POST['shipmentType']
        insurance = request.POST['insurance']
        packageSize = request.POST['packagesize']
        packageWeight = request.POST['packageWeight']
        context['locatedealer'] = {}
        print(packageSize)
        #
        #storing the values so that when reload of page the variable will not reset
        request.session['packageSize'] = packageSize
        request.session['shipmentType'] = shipmentType
        request.session['insurance'] = insurance
        # request.session['fragile'] = fragile
        request.session['packageWeight'] = packageWeight
        # request.session['packageDimension'] = float(packageLength)*float(packageWidth)*float(packageHeight)
        if dealer.objects.filter(pincode=recipientAddress_zip):
            rd = dealer.objects.filter(pincode=recipientAddress_zip)
        elif dealer.objects.filter(city=recipientAddress_city):
            rd = dealer.objects.filter(city=recipientAddress_city)
        else:
            rd = dealer.objects.filter(country=recipientAddress_country)
        print(rd)
        context['locatedealer']['recipentdealerloc']= rd
        # senderlocations
        if dealer.objects.filter(pincode=senderAddress_zip):
            sd = dealer.objects.filter(pincode=senderAddress_zip)
        elif dealer.objects.filter(city=senderAddress_city):
            sd = dealer.objects.filter(city=senderAddress_city)
        else:
            sd = dealer.objects.filter(country=senderAddress_country)
        print(sd)
        context['locatedealer']['senderdealerloc']= sd
            
    if  "select_dealer" in request.POST:
        dealeratsender = request.POST['dealeratsender']
        dealeratrecipent = request.POST['dealeratrecipent']
        sd_id =dealer.objects.get(id=dealeratsender) # high
        rd_id =dealer.objects.get(id=dealeratrecipent) # low 
        rd_pin = rd_id.pincode
        sd_pin = sd_id.pincode 
        print('pincodes: ',sd_pin,rd_pin)
        #--------distance calculator---
        params = (
            ("code",sd_pin),
            ("compare",rd_pin),
            ("country","in"),
            );
        response = requests.get('https://app.zipcodebase.com/api/v1/distance', headers=headers, params=params);
        str_dic = response.text
        distance = json.loads(str_dic)
        print("distance:",distance['results'][str(rd_pin)])
        distkm =distance['results'][str(rd_pin)]
        request.session['distance']= distkm
        context['payment']= "p"
        context['weight']= request.session.get('packageWeight')
        context['distance']= request.session.get('distance')
        amount= "{:.2f}".format(pricekm * distkm + addprice)
        context['amount']=amount
        request.session['amount']=amount
        # context['packageDimension']= request.session.get('packageDimension')
        context['packageSize']= request.session.get('packageSize')
        request.session['dealeratsender'] = dealeratsender
        request.session['dealeratrecipent'] = dealeratrecipent
        sid = random.randint(10000,99999)
        request.session['orderid']=sid
        context['orderid']=request.session.get('orderid')   
        price=float(request.session.get('amount'))
        print('orderid',request.session.get('orderid'))
        oid= str(sid)
        client = razorpay.Client(auth=("rzp_test_rOgiQUix1apLnN", "Kvhw6yh0fS0JQKwgSE4ZxbKy"))
        client.set_app_details({"title" : "fastbox", "version" : "5.1.1"})
        data = { "amount": price*100, "currency": "INR", "receipt": "receiptid_"+oid }
        payment = client.order.create(data=data)
        print(payment)
        context['data']=payment
        
        print("dealer selection:",dealeratrecipent,dealeratsender)
    
    if  "paylater" in request.POST:
        context['msg']="shipment order has been placed, we will contact you at pickup."
        orderid = request.session.get('orderid')
        recipientName = request.session.get('recipientName')
        recipientAddress_add = request.session.get('recipientAddress_add')
        recipientAddress_zip = request.session.get('recipientAddress_zip')
        recipientAddress_city = request.session.get('recipientAddress_city')
        recipientAddress_country = request.session.get('recipientAddress_country')
        recipientAddress_phone = request.session.get('recipientAddress_phone')
        dealeratrecipent = request.session.get('dealeratrecipent')
        dealeratsender = request.session.get('dealeratsender')
        weight = request.session.get('packageWeight')
        shipmentType = request.session.get('shipmentType')
        insurance = request.session.get('insurance')
        # fragile = request.session.get('fragile')
        packageSize = request.session.get('packageSize')
        #-----------sender
        senderAddress_zip = request.session.get('senderAddress_zip')
        senderName = request.session.get('senderName')
        senderAddress_add = request.session.get('senderAddress_add')
        senderAddress_city = request.session.get('senderAddress_city')
        senderAddress_country = request.session.get('senderAddress_country')
        senderAddress_phone = request.session.get('senderAddress_phone')
        distance= request.session.get('distance')
        print("check: ",dealeratrecipent,dealeratsender)
        date =datetime.datetime.now()
        cost = request.session.get('amount')
        # userid = request.user.id
        # print("dealer selection:",recipientName,recipientAddress_add,recipientAddress_zip,recipientAddress_city,recipientAddress_country,recipientAddress_phone)
        so = order_shipment.objects.create(shipment_id=orderid,
                                           sender_id=request.user,
                                           n_sender_zip=senderAddress_zip,
                                           n_sender_city=senderAddress_city,
                                           n_sender_add=senderAddress_add,
                                           n_sender_country=senderAddress_country,
                                           n_sender_ph_no=senderAddress_phone,
                                           n_recipent=recipientName,
                                           n_recipent_zip=recipientAddress_zip,
                                           n_recipent_city=recipientAddress_city,
                                           n_recipent_add=recipientAddress_add,
                                           n_recipent_country=recipientAddress_country,n_recipent_ph_no=recipientAddress_phone,
                                           s_dealer_id=dealer.objects.get(id=dealeratsender),
                                           r_dealer_id=dealer.objects.get(id=dealeratrecipent),
                                           cost=cost,
                                           date=date,
                                           p_type=shipmentType,
                                        #    p_fragile=fragile,
                                           p_insurance=insurance,
                                           p_weight=weight,
                                           p_size=packageSize,
                                        #    p_height=packageHeight,
                                        #    p_length=packageLength,
                                        #    p_width=packageWidth,
                                           distance=distance,
                                           )
        #-------add sender details
        
        so.save()

    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,'makeShipment.html',context)

# we need to csrf_exempt this url as
# POST request will be made by Razorpay
# and it won't have the csrf token.
@csrf_exempt
def paymentgateway(request):
    context={}
    if request.method == "POST":
        sid =request.session.get('orderid')
        payment_id=request.POST['razorpay_payment_id']
        order_id=request.POST['razorpay_order_id']
        signature=request.POST['razorpay_signature']
        print(payment_id,order_id,signature)
        context['msg']="shipment order has been placed, we will contact you at pickup.Updates will be shown on dashboard..."
        recipientName = request.session.get('recipientName')
        recipientAddress_add = request.session.get('recipientAddress_add')
        recipientAddress_zip = request.session.get('recipientAddress_zip')
        recipientAddress_city = request.session.get('recipientAddress_city')
        recipientAddress_country = request.session.get('recipientAddress_country')
        recipientAddress_phone = request.session.get('recipientAddress_phone')
        dealeratrecipent = request.session.get('dealeratrecipent')
        dealeratsender = request.session.get('dealeratsender')
        weight = request.session.get('packageWeight')
        shipmentType = request.session.get('shipmentType')
        insurance = request.session.get('insurance')
        size = request.session.get('packageSize')
        packageHeight = request.session.get('packageHeight')
        packageWidth = request.session.get('packageWidth')
        packageLength = request.session.get('packageLength')
        #-----------sender
        senderAddress_zip = request.session.get('senderAddress_zip')
        senderName = request.session.get('senderName')
        senderAddress_add = request.session.get('senderAddress_add')
        senderAddress_city = request.session.get('senderAddress_city')
        senderAddress_country = request.session.get('senderAddress_country')
        senderAddress_phone = request.session.get('senderAddress_phone')
        distance= request.session.get('distance')
        print("check: ",dealeratrecipent,dealeratsender)
        date =datetime.datetime.now()
        cost = request.session.get('amount')
        # userid = request.user.id
        # print("dealer selection:",recipientName,recipientAddress_add,recipientAddress_zip,recipientAddress_city,recipientAddress_country,recipientAddress_phone)
        so = order_shipment.objects.create(shipment_id=sid,
                                           sender_id=request.user,
                                           n_sender_zip=senderAddress_zip,
                                           n_sender_city=senderAddress_city,
                                           n_sender_add=senderAddress_add,
                                           n_sender_country=senderAddress_country,
                                           n_sender_ph_no=senderAddress_phone,
                                           n_recipent=recipientName,
                                           n_recipent_zip=recipientAddress_zip,
                                           n_recipent_city=recipientAddress_city,
                                           n_recipent_add=recipientAddress_add,
                                           n_recipent_country=recipientAddress_country,n_recipent_ph_no=recipientAddress_phone,
                                           s_dealer_id=dealer.objects.get(id=dealeratsender),
                                           r_dealer_id=dealer.objects.get(id=dealeratrecipent),
                                           cost=cost,
                                           date=date,
                                           p_type=shipmentType,
                                           p_insurance=insurance,
                                           p_weight=weight,
                                           p_size=size,
                                           distance=distance,
                                           )
        #-------add sender details
        
        so.save()
    
    return render(request,"makeShipment.html",context)

@login_required(login_url='login')
@allowed_user(allowed_roles=['customer'])
def trackPackage(request):
    context={}
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,'trackPackage.html',context)

@login_required(login_url='login')
@allowed_user(allowed_roles=['customer'])
def shipmentHistory(request):
    context={}
    # ---check group for dashbord option---
    current_user_groups = request.user.groups.values_list("name", flat=True)
    context['is_owner']= "owner" in current_user_groups
    context['is_customer']= "customer" in current_user_groups
    context['is_dealer']= "dealer" in current_user_groups
    # ---end---
    q1 =Q(sender_id=request.user.id)
    q2 =Q(completed=1)
    ps = order_shipment.objects.filter(q1 & q2)
    context['orders']= ps
    try: 
        u = userProfile.objects.get(user_id=request.user.id)
        context['userp'] = u
        print(u.picture)
    except userProfile.DoesNotExist:
        print("no picture found")
    return render(request,'shipmentHistory.html',context)

# ========= reset password ========
def resetuser(request):
    return render(request,'resetpsw.html')  

# ------------------- ADMIN -------------------------

def pagenotfound(request):
    return render(request,"error404.html")

# def manageDealer(request,did):
#     return redirect("dealerManagement",did=did)
# --------------------END-------------------



