from .models import Achievement, User, Quiz
from .serializers import AchievementRelatedSerializer, UserSerializer, AchievementSerializer, QuizSerializer
from rest_framework import generics
import requests
from bs4 import BeautifulSoup as bs

class UserList(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class AchievementList(generics.ListCreateAPIView):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer


class UserWithAchievement(generics.ListCreateAPIView):
    queryset = Achievement.objects.all()
    serializer_class = AchievementRelatedSerializer


class UserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class AchievementDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer


class QuizList(generics.ListCreateAPIView):
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer


class QuizDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer


