from server.models import *
from server.serializers import AchievementRelatedSerializer, UserSerializer, AchievementSerializer, QuizSerializer, \
    PointOfUserSerializer, QuizOfUserSerializer, ThemeOfQuizSerializer, AchievementOfUserSerializer
from rest_framework import generics
from django.views.decorators.csrf import csrf_exempt
import requests
from bs4 import BeautifulSoup as bs
from rest_framework.views import APIView
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
import rest_framework.status

#
# class UserRecordView(APIView):
#     permission_classes = [IsAdminUser]
#     def get(self, format=None):
#         users = User.objects.all()
#         serializer = UserSerializer(users, many=True)
#         return Response(serializer.data)
#     def post(self, request):
#
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


class QuizOfUserList(generics.ListCreateAPIView):
    queryset = QuizOfUser.objects.all()
    serializer_class = QuizOfUserSerializer


class QuizOfUserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = QuizOfUser.objects.all()
    serializer_class = QuizOfUserSerializer


class ThemeOfQuizList(generics.ListCreateAPIView):
    queryset = ThemeOfQuiz.objects.all()
    serializer_class = ThemeOfQuizSerializer


class ThemeOfQuizDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ThemeOfQuiz.objects.all()
    serializer_class = ThemeOfQuizSerializer


class AchievementOfUserList(generics.ListCreateAPIView):
    queryset = AchievementOfUser.objects.all()
    serializer_class = AchievementSerializer


class AchievementOfUserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AchievementOfUser.objects.all()
    serializer_class = AchievementSerializer


class PointOfUserList(generics.ListCreateAPIView):
    queryset = PointOfUser.objects.all()
    serializer_class = PointOfUserSerializer


class PointOfUserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PointOfUser.objects.all()
    serializer_class = PointOfUserSerializer
