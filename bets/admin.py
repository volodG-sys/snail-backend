from django.contrib import admin
from .models import Snail

@admin.register(Snail)
class SnailAdmin(admin.ModelAdmin):
    list_display = ('name', 'photo')
