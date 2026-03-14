from django.db import models

# Create your models here.
class Snail(models.Model):
    name = models.CharField(max_length=100)
    # upload_to='snails/' створить папку всередині вашого бакета
    photo = models.ImageField(upload_to='snails/') 

    def __str__(self):
        return self.name