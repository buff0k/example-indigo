# example-indigo

Example set of configuration files for running [Indigo](https://github.com/OpenUpSA/indigo) on Heroku or with [dokku](https://github.com/dokku/dokku) or additionally deployment to [Docker](https://docker.io) via Dockerfile:

## Dokku Deployment (working):

```bash
dokku apps:create indigo

dokku nginx:set indigo clietn-max-body-size 100M;
```

{Change below settings for your environment}

```bash
dokku config:set indigo \
    DISABLE_COLLECTSTATIC=1 \
    DJANGO_DEBUG=false \
    DJANGO_SECRET_KEY=some random characters \
    AWS_ACCESS_KEY_ID=your AWS Access Key \
    AWS_SECRET_ACCESS_KEY=your AWS Secret \
    AWS_S3_BUCKET=your AWS Bucket \
    DJANGO_DEFAULT_FROM_EMAIL=name@domain.com \
    DJANGO_EMAIL_HOST=smtp.domain.com \
    DJANGO_EMAIL_HOST_PASSWORD=Your email password \
    DJANGO_EMAIL_HOST_PORT=25 \
    DJANGO_EMAIL_HOST_USER=name@domain.com \
    GOOGLE_ANALYTICS_ID=Your analytics ID \
    SUPPORT_EMAIL=name@domain.com \
    NOTIFICATION_EMAILS_BACKGROUND=true

dokku postgres:create indigodb

dokku postgres:link indigodb indigo

git clone https://github.com/buff0k/example-indigo

cd example-indigo

git remote add dokku dokku@host-name:indigo

dokku checks:disable indigo

git push dokku

dokku checks:enable indigo

dokku run indigo python manage.py update_countries_plus

dokku run indigo python manage.py loaddata languages_data.json.gz

dokku run indigo python manage.py createsuperuser
```

## Docker Deployment (testing):

NB!! mv example-env .env and edit the variables prior to deployment.

sudo docker-compose run web indigo startproject indigo

sudo chown -R $USER:$USER (or leave unchanged if running as root)

docker-compose up
