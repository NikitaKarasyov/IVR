# Generated by Django 4.0.1 on 2022-01-25 16:55

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0004_alter_user_contact'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserOfQuiz',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.AddField(
            model_name='quiz',
            name='companies',
            field=models.ManyToManyField(related_name='companies', through='server.UserOfQuiz', to='server.User'),
        ),
        migrations.AddField(
            model_name='userofquiz',
            name='quiz',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='server.quiz'),
        ),
        migrations.AddField(
            model_name='userofquiz',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='server.user'),
        ),
    ]
