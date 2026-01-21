from django.contrib import admin
from .models import Expense, SMSMessage, Category

@admin.register(Expense)
class ExpenseAdmin(admin.ModelAdmin):
    list_display = ('description', 'amount', 'category', 'user', 'date')
    list_filter = ('category', 'date', 'user')
    search_fields = ('description', 'user__username')
    ordering = ('-date',)

@admin.register(SMSMessage)
class SMSMessageAdmin(admin.ModelAdmin):
    list_display = ('sender', 'amount', 'merchant', 'is_processed', 'received_at')
    list_filter = ('is_processed', 'bank_name')
    search_fields = ('message_body', 'sender')
    ordering = ('-received_at',)

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'icon', 'color')
    search_fields = ('name',)
