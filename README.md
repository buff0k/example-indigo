# example-indigo

Example set of configuration files for running [Indigo](https://github.com/OpenUpSA/indigo) on Heroku or with [dokku](https://github.com/dokku/dokku) or additionally deployment to [Docker](https://docker.io) via Dockerfile:

## Dokku Deployment (working):

NB!!! This assumes that you have already installed and deployed Dokku, refer to their documentation for instructions...

Create the Dokku app (Named indigo)

```bash
dokku apps:create indigo
```
Allow upload of files larger than 1Megabyte

```bash
dokku nginx:set indigo clietn-max-body-size 100M;
```

Set ENV variables: (Change below settings for your environment):

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
```

Install the Dokku Postgres Plugin:

```bash
sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git
```

Create a Postgres Database and link it to the indigo app:

```bash
dokku postgres:create indigodb
```

```bash
dokku postgres:link indigodb indigo
```

Clone and enter from GIT:

```bash
git clone https://github.com/buff0k/example-indigo
```

```bash
cd example-indigo
```

Add the dokku git host for the app:

```bash
git remote add dokku dokku@host-name:indigo
```

Disable CHECKS for the initial deployment (Remember to re-enable after the initial deployment for updates):

```bash
dokku checks:disable indigo
```

Deploy Indigo to Dokku:

```bash
git push dokku
```

```bash
dokku checks:enable indigo
```

```bash
dokku run indigo python manage.py update_countries_plus
```

```bash
dokku run indigo python manage.py loaddata languages_data.json.gz
```

```bash
dokku run indigo python manage.py createsuperuser
```

## Docker Deployment (testing):

NB!! mv example-env .env and edit the variables prior to deployment.

sudo docker-compose run web indigo startproject indigo

sudo chown -R $USER:$USER (or leave unchanged if running as root)

docker-compose up
