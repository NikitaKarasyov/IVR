from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register([User, Achievement, Quiz, Theme, AchievementOfUser, QuizOfUser, ThemeOfQuiz, Point, PointOfUser])
