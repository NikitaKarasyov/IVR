# Generated by Django 4.0.1 on 2022-01-26 16:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0005_userofquiz_quiz_companies_userofquiz_quiz_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='interests',
            field=models.CharField(blank=True, max_length=300),
        ),
    ]
