from django.db.models import fields
from django.db.models.fields import IntegerField
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

from .models import *


class AchievementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Achievement
        fields = "__all__"


class ThemeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Theme
        fields = "__all__"


class QuizSerializer(serializers.ModelSerializer):
    themes = ThemeSerializer(many=True, read_only=True)

    class Meta:
        model = Quiz
        fields = "__all__"


class PointSerializer(serializers.ModelSerializer):
    class Meta:
        model = Point
        fields = "__all__"


class UserSerializer(serializers.ModelSerializer):
    # def create(self, validated_data):
    #     return User.objects.create_user(**validated_data)

    participating = QuizSerializer(many=True, read_only=True)
    achievements = AchievementSerializer(many=True, read_only=True)
    points = PointSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = "__all__"
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['name', 'email']
            )
        ]


class AchievementRelatedSerializer(serializers.ModelSerializer):
    user_achievements = UserSerializer(many=True)

    class Meta:
        model = Achievement
        fields = "__all__"


class QuizOfUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuizOfUser
        fields = "__all__"


class ThemeOfQuizSerializer(serializers.ModelSerializer):
    class Meta:
        model = ThemeOfQuiz
        fields = "__all__"


class PointOfUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = PointOfUser
        fields = "__all__"


class AchievementOfUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AchievementOfUser
        fields = "__all__"
