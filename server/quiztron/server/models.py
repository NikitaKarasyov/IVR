from django.db import models
from datetime import datetime


class Point(models.Model):
    value = models.IntegerField(default=0)

    def __str__(self):
        return str(self.value)


class Theme(models.Model):
    name = models.CharField(max_length=25)

    def __str__(self):
        return self.name


class Achievement(models.Model):
    name = models.CharField(max_length=32)
    description = models.CharField(max_length=100)

    def str(self):
        return [self.name, self.description]


class Quiz(models.Model):
    name = models.CharField(max_length=100)
    description = models.CharField(
        max_length=1000,
        blank=True,
        default="It looks, like this quiz does not have a description"
    )
    date = models.DateTimeField(default=datetime(1970, 1, 1), editable=True)
    themes = models.ManyToManyField("Theme", through='ThemeOfQuiz',related_name='themes')
    url = models.URLField(default='No url provided')
    companies = models.ManyToManyField('User', through='UserOfQuiz', related_name='companies')

    def __str__(self):
        return self.name


class User(models.Model):
    name = models.CharField(max_length=32)
    email = models.CharField(max_length=100)
    password = models.CharField(max_length=32)
    contact = models.CharField(max_length=100, blank=True)
    current_points = models.IntegerField(default=0)
    points = models.ManyToManyField(Point, through='PointOfUser', related_name='points')
    achievements = models.ManyToManyField(Achievement, through='AchievementOfUser', related_name='achievements')
    participating = models.ManyToManyField(Quiz, through='QuizOfUser', related_name='participating')
    interests = models.CharField(max_length=300, blank=True)


    def __str__(self):
        return self.name


class PointOfUser(models.Model):
    point = models.ForeignKey('Point', on_delete=models.CASCADE)
    user = models.ForeignKey('User', on_delete=models.CASCADE)


class AchievementOfUser(models.Model):
    achievement = models.ForeignKey('Achievement', on_delete=models.CASCADE)
    user = models.ForeignKey('User', on_delete=models.CASCADE)


class QuizOfUser(models.Model):
    quiz = models.ForeignKey('Quiz', on_delete=models.CASCADE)
    user = models.ForeignKey('User', on_delete=models.CASCADE)

    def validate_unique(self, exclude=None):
        qs = Quiz.objects.filter()

class ThemeOfQuiz(models.Model):
    theme = models.ForeignKey('Theme', on_delete=models.CASCADE)
    quiz = models.ForeignKey('Quiz', on_delete=models.CASCADE)


class UserOfQuiz(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    quiz = models.ForeignKey('Quiz', on_delete=models.CASCADE)