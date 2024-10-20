from django import forms
from .models import *

class pictureUpload(forms.ModelForm):
    model = userProfile
    picture = forms.ImageField(
        widget= forms.FileInput(
            attrs={
                'class': "btn-primary btn-sm"
            }
        )
    )
        
