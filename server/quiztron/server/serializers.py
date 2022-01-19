from django.db.models import fields
from django.db.models.fields import IntegerField
from rest_framework import serializers

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
    participating = QuizSerializer(many=True, read_only=True)
    achievements = AchievementSerializer(many=True, read_only=True)
    points = PointSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = "__all__"


class AchievementRelatedSerializer(serializers.ModelSerializer):
    user_achievements = UserSerializer(many=True)

    class Meta:
        model = Achievement
        fields = "__all__"
