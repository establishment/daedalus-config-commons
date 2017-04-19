import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))

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

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'infra.org',
        'USER': 'postgres',
        'PASSWORD': '{{ POSTGRES_PASSWORD }}',
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}

ACCOUNTS_EMAIL_HOST = "{{ ACCOUNTS_EMAIL_HOST }}"
ACCOUNTS_EMAIL_PORT = {{ ACCOUNTS_EMAIL_PORT }}
ACCOUNTS_EMAIL_USER = "contact@infra.org"
ACCOUNTS_EMAIL_PASSWORD = {"{{ ACCOUNTS_EMAIL_PASSWORD }}"}
ACCOUNTS_EMAIL_TLS = {"{{ ACCOUNTS_EMAIL_USE_TLS }}"}

RECAPTCHA_PRIVATE_KEY = {"{{ RECAPTCHA_PRIVATE_KEY }}"}

FORCE_LIVE = True
