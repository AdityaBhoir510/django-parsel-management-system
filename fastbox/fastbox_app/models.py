from django.db import models
from django.contrib.auth.models import User

# Create your models here.
# ==========Profile=========
class userProfile(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,db_column='userID')
    picture = models.ImageField(upload_to='images',blank=True,null=True,default='media/images/person-circle.svg')
    country = models.CharField(max_length=50)
    address = models.CharField(max_length=255)
    country = models.CharField(max_length=50)
    ph_no = models.BigIntegerField(null=True,blank=True,default=None)

    def __str__(self):
        return self.user.username

class contact_query(models.Model):
    name = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    subject = models.CharField(max_length=255)
    message = models.TextField()
    date = models.DateField()
    time = models.TimeField()

    def __str__(self):
        return f"{self.name} {self.date} {self.time}"
    
class business_query(models.Model):
    company_name = models.CharField(max_length=50)
    contact_person = models.CharField(max_length=50)
    street_address = models.CharField(max_length=255)
    street_address_line_2 = models.CharField(max_length=255)
    city = models.CharField(max_length=50)
    postal_code = models.IntegerField()
    country = models.CharField(max_length=50)
    ph_no = models.BigIntegerField()    
    email = models.EmailField()
    details = models.TextField()
    date = models.DateField()

    def __str__(self):
        return self.company_name

class dealer_request(models.Model):
    firstname = models.CharField(max_length=50)
    lastname = models.CharField(max_length=50) 
    companyname = models.CharField(max_length=50) 
    add_line_1 = models.CharField(max_length=255)
    add_line_2 = models.CharField(max_length=255)
    city = models.CharField(max_length=50)
    country = models.CharField(max_length=50)
    postalcode = models.IntegerField() 
    ph_no = models.BigIntegerField()
    email = models.EmailField()
    wh_city = models.CharField(max_length=50)
    wh_area = models.CharField(max_length=255)
    wh_country = models.CharField(max_length=50)
    wh_tenure = models.CharField(max_length=50)
    date = models.DateField()

# authorized dealers granted by owners
class dealer(models.Model):
    dealer_id = models.ForeignKey(User,on_delete=models.CASCADE)
    firstname = models.CharField(max_length=50)
    lastname = models.CharField(max_length=50)
    city = models.CharField(max_length=50)
    pincode = models.IntegerField()
    country = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    phone = models.BigIntegerField()
    add_line_1 = models.CharField(max_length=255)
    add_line_2 = models.CharField(max_length=255)
    jdate= models.DateField()
    
class order_shipment(models.Model):
    status = (
        ("1","assigned"),
        ("2","pickup"),
        ("3","at sender office"),
        ("4","onboard"),
        ("5","at receiver office"),
        ("6","deliver"),
        ("7","end")
    )
    shipment_id = models.IntegerField()
    sender_id = models.ForeignKey(User,related_name="sender",on_delete=models.CASCADE)
    n_sender_add = models.CharField(max_length=50)
    n_sender_zip = models.IntegerField()
    n_sender_city = models.CharField(max_length=50)
    n_sender_country = models.CharField(max_length=50)
    n_sender_ph_no = models.BigIntegerField()
    # recipent_id = models.ForeignKey(User,related_name="recipent",on_delete=models.CASCADE)
    n_recipent = models.CharField(max_length=50)
    n_recipent_add = models.CharField(max_length=50)
    n_recipent_zip = models.IntegerField()
    n_recipent_city = models.CharField(max_length=50)
    n_recipent_country = models.CharField(max_length=50)
    n_recipent_ph_no = models.BigIntegerField()
    # p_length = models.FloatField()
    # p_width = models.FloatField()
    # p_height = models.FloatField()
    p_weight = models.FloatField()
    p_size = models.CharField(max_length=50)
    p_type = models.CharField(max_length=50)
    p_insurance = models.CharField(max_length=50)
    # p_fragile = models.CharField(max_length=50)
    s_dealer_id = models.ForeignKey(dealer,related_name="s_dealer",on_delete=models.CASCADE)
    r_dealer_id = models.ForeignKey(dealer,related_name="r_dealer",on_delete=models.CASCADE)
    shipment_status = models.CharField(max_length=50,choices=status,default='start')
    cost = models.FloatField()
    distance = models.FloatField()
    mot = models.CharField(max_length=50,null=True)
    date = models.DateField()
    e_date = models.DateField(null=True,blank=True)
    completed = models.BooleanField(default=False)
    
class employee(models.Model):
    firstname = models.CharField(max_length=50)
    lastname = models.CharField(max_length=50)
    e_email = models.EmailField()
    e_phone = models.BigIntegerField()
    dealer_id = models.ForeignKey(dealer,on_delete=models.CASCADE)
    assigned_order =  models.ForeignKey(order_shipment,related_name='employees',on_delete=models.CASCADE,blank=True,null=True)
    
# order ids
# 77434   
# 48130
# 67291