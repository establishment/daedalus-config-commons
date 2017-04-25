DEBUG = True

PORT_INCREMENT = 0000

# email for django error logging
SERVER_EMAIL = "{{ EMAIL_SERVER_EMAIL }}"

# email settings
EMAIL_USE_TLS = ("{{ EMAIL_USE_TLS }}" == "True")
EMAIL_HOST = "{{ EMAIL_HOST }}"
EMAIL_PORT = {{ EMAIL_PORT }}
EMAIL_HOST_USER = "{{ EMAIL_HOST_USER }}"
EMAIL_HOST_PASSWORD = "{{ EMAIL_HOST_PASSWORD }}"

DEFAULT_FROM_EMAIL = "{{ EMAIL_DEFAULT_FROM_EMAIL }}"

LINODE_API_SECRET_KEY = "{{ LINODE_API_KEY }}"

ALLOWED_HOSTS = ["*"]

MOCK_MACHINE_ID = {{ MOCK_MACHINE_ID }}

DATABASES = {
   "default": {
       "ENGINE": "django.db.backends.postgresql_psycopg2",
       "NAME": "{{ DJANGO_APP_DATABASE_NAME }}",
       "USER": "postgres",
       "PASSWORD": "{{ POSTGRES_PASSWORD }}",
       "HOST": "127.0.0.1",
       "PORT": str(PORT_INCREMENT + 5432),
   },
}

REDIS_CONNECTION = {
   "host": "localhost",
   "port": 6379 + PORT_INCREMENT,
   "db": 0,
   "password": None,
}

REDIS_CONNECTION_WEBSOCKETS = REDIS_CONNECTION
REDIS_CONNECTION_CACHING = REDIS_CONNECTION
REDIS_CONNECTION_LOGGING = REDIS_CONNECTION
REDIS_CONNECTION_SERVICES = REDIS_CONNECTION
REDIS_CONNECTION_JOBS = REDIS_CONNECTION

ACCOUNTS_EMAIL_HOST = "{{ ACCOUNTS_EMAIL_HOST }}"
ACCOUNTS_EMAIL_PORT = {{ ACCOUNTS_EMAIL_PORT }}
ACCOUNTS_EMAIL_USER = "{{ ACCOUNTS_EMAIL_USER }}"
ACCOUNTS_EMAIL_PASSWORD = "{{ ACCOUNTS_EMAIL_PASSWORD }}"
ACCOUNTS_EMAIL_TLS = "{{ ACCOUNTS_EMAIL_USE_TLS }}"

RECAPTCHA_PRIVATE_KEY = "{{ RECAPTCHA_PRIVATE_KEY }}"

DEFAULT_HTTP_PROTOCOL = "http"

# This setting is required to override the Django's main loop, when running in
# development mode, such as ./manage runserver
WSGI_APPLICATION = "establishment.websockredis.django_runserver.application"

ENABLE_MANAGE_URLS = True

import infraorg.logging_settings

for logger in infraorg.logging_settings.LOGGING["loggers"].values():
   logger["level"] = "DEBUG"
   logger["handlers"].append("console")
