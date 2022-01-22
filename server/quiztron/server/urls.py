from django.urls import path
from quiztron.views import *

app_name = 'server'
urlpatterns = [
    path('users/', UserList.as_view(), name='users'),
    path('users/<int:pk>/', UserDetail.as_view(), name='user_details'),
    path('achievements/', AchievementList.as_view(), name='achievements'),
    path('achievements/<int:pk>/', AchievementDetail.as_view(), name='achievement_details'),
    path('quizes/', QuizList.as_view(), name='quizes'),
    path('quizes/<int:pk>/', QuizDetail.as_view(), name='quiz_details'),

    path('achievement-of-user/', AchievementOfUserList.as_view(), name='achievement_of_user'),
    path('achievement-of-user/<int:pk>/', AchievementOfUserDetail.as_view(), name='achievement_of_user_details'),
    path('point-of-user/', PointOfUserList.as_view(), name='point_of_user'),
    path('point-of-user/<int:pk>/', PointOfUserDetail.as_view(), name='point_of_user_details'),
    path('quiz-of-user/', QuizOfUserList.as_view(), name='quiz-of-user'),
    path('quiz-of-user/<int:pk>/', QuizOfUserDetail.as_view(), name='quiz-of-user_details'),
    path('theme-of-quiz/', ThemeOfQuizList.as_view(), name='theme_of_quiz'),
    path('theme-of-quiz/<int:pk>/', ThemeOfQuizDetail.as_view(), name='theme_of_quiz_details'),
]